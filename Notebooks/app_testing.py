# imports
import matplotlib.pyplot as plt
import sys, getopt
import src.framework__data_set as ds
import numpy as np
import pandas as pd
import yfinance as yf
import tensorflow as tf
from matplotlib import pylab
from datetime import datetime, timedelta
from tensorflow.keras.layers import Dense, LSTM
from tensorflow.keras.models import Sequential, model_from_json
from sklearn.preprocessing import MinMaxScaler
pd.options.mode.chained_assignment = None
tf.random.set_seed(0)

# input and output sequences
n_lookback = int(sys.argv[3])  # length of input sequences (lookback period)
n_forecast = int(sys.argv[4])  # length of output sequences (forecast period)

# trained model file to load
file = sys.argv[2]+"_"+sys.argv[3]+"_"+sys.argv[4]

# load json and create model
json_file = open(file+".json", 'r')
loaded_model_json = json_file.read()
json_file.close()
model = model_from_json(loaded_model_json)
# load weights into new model
model.load_weights(file+".h5")
print("Loaded model from disk")

# read dataset
dataset_ = ds.get_data_set(
    metric=sys.argv[1],
    application_name=sys.argv[2],
    path_to_data="../data/"
)

# uncomment to show intervals per sample
for i in range(int(len(dataset_) * 0.67) + 1, len(dataset_)):
    print(i-int(len(dataset_) * 0.67))
    print("----------------" + str(int(len(dataset_[i])))) 

# forecast interval selected (testing part)
dataset_test = dataset_[int(len(dataset_) * 0.67) + int(sys.argv[5])]

# scale data
scaler_test = MinMaxScaler()
dataset_test['sample'] = scaler_test.fit_transform(dataset_test[['sample']])

# samples
y = dataset_test['sample'].fillna(method='ffill')
y = y.values.reshape(-1, 1)
test_len = n_lookback
data_test = dataset_test.head(test_len)

# predict forecasts
X_ = y[test_len-n_lookback:test_len]
X_ = X_.reshape(1, n_lookback, 1)
Y_ = model.predict(X_).reshape(-1, 1)
Y3_ = []
Y3_ = np.array(Y3_)
Y3_ = Y_

# append forecasts
for i in range(int((len(dataset_test)-len(data_test))/n_forecast) - 1):
        X2_ = y[test_len-n_lookback+(n_forecast*(i+1)):test_len+(n_forecast*(i+1))]
        X2_ = X2_.reshape(1, n_lookback, 1)
        Y2_ = model.predict(X2_).reshape(-1, 1)
        Y3_ = np.concatenate((Y3_, Y2_))

forecast_len = len(Y3_)

# For calculating RMSE
Y4_ = Y3_.flatten()
Y5_ = dataset_test['sample'].to_numpy()

# mean squared error
rmse = np.sqrt(np.square(np.subtract(Y4_,Y5_[test_len:test_len+forecast_len])).mean())

# MAE
Y4_ = Y3_.flatten()
Y5_ = dataset_test['sample'].to_numpy()
perc = np.mean(np.abs(np.subtract(Y5_[test_len:test_len+forecast_len], Y4_)))

# Recover from normalized data
Y3_ = scaler_test.inverse_transform(Y3_)
dataset_test['sample'] = scaler_test.inverse_transform(dataset_test[['sample']])

# plot results
df_future = pd.DataFrame(columns=['Forecast'])
df_future['Forecast'] = Y3_.flatten()
original_as_series = dataset_test['sample'].copy()
predicted_as_series = df_future['Forecast']
x_axis = [time for time in dataset_test["time"]]
original_as_series.index = x_axis
ax = original_as_series.plot(color="blue", label="Samples")
predicted_as_series.index = x_axis[test_len:test_len+forecast_len]
predicted_as_series.plot(ax=ax, color="red", label="Predictions")
plt.title("Metric: " + sys.argv[1] + ", App: " + sys.argv[2] + ", Lookback: " + sys.argv[3] + ", Horizon: " + sys.argv[4] + "\nRMSE: " + str("{:.5f}".format(rmse)) + " - MAE: " + str("{:.5f}".format(perc)))
plt.xlabel("Minutes")
plt.ylabel("Values")
plt.tight_layout()
#plt.subplots_adjust(bottom=0.1)
plt.show()

