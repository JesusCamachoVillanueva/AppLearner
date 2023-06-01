# Author "Jesus Camacho Villanueva <jcamacho@redhat.com>"

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

# read dataset
dataset_ = ds.get_data_set(
    metric=sys.argv[1],
    application_name=sys.argv[2],
    path_to_data="../data/"
)

def predict_values(sys3, horizon, dataset_test):

    # input and output sequences
    n_lookback = int(sys3)  # length of input sequences (lookback period)
    n_forecast = int(horizon)  # length of output sequences (forecast period)

    # trained model file to load
    file = sys.argv[4]+"_"+horizon;

    # load json and create model
    json_file = open(file+".json", 'r')
    loaded_model_json = json_file.read()
    json_file.close()
    model = model_from_json(loaded_model_json)
    # load weights into new model
    model.load_weights(file+".h5")
    print("Loaded model " + file + " from disk")

    # scale data
    scaler_test = MinMaxScaler()
    dataset_test['sample'] = scaler_test.fit_transform(dataset_test[['sample']])

    # samples
    y = dataset_test['sample'].fillna(method='ffill')
    y = y.values.reshape(-1, 1)
    test_len = n_lookback
    data_test = dataset_test.head(test_len)
    len_data = len(dataset_test['sample'].to_numpy())

    # predict forecasts
    X_ = y[test_len-n_lookback:test_len]
    X_ = X_.reshape(1, n_lookback, 1)
    Y_ = model.predict(X_).reshape(-1, 1)
    Y3_ = []
    Y3_ = np.array(Y3_)
    Y3_ = Y_
    # cut first prediction when longer than test set
    if(len(Y3_) > len_data):
        Y3_ = Y_[0:len_data - n_lookback]

    # append forecasts
    for i in range(int((len(dataset_test)-len(data_test))/n_forecast) - 0):
        X2_ = y[test_len-n_lookback+(n_forecast*(i+1)):test_len+(n_forecast*(i+1))]
        X2_ = X2_.reshape(1, n_lookback, 1)
        Y2_ = model.predict(X2_).reshape(-1, 1)
        # cut last append
        if(i == int((len(dataset_test)-len(data_test))/n_forecast) - 1):
            until = len_data - len(Y3_) - n_lookback 
            Y3_ = np.concatenate((Y3_, Y2_[0:until]))
        else:
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
    mae = np.mean(np.abs(np.subtract(Y5_[test_len:test_len+forecast_len], Y4_)))

    # Recover from normalized data
    Y3_ = scaler_test.inverse_transform(Y3_)
    dataset_test['sample'] = scaler_test.inverse_transform(dataset_test[['sample']])

    return Y3_ , rmse, mae, test_len, forecast_len, len_data, number


# get interval
number = int(sys.argv[5]) % int(len(dataset_) * 0.33)

# forecast interval selected (testing part)
dataset_test = dataset_[int(len(dataset_) * 0.67) + number]

# dataset_test must be greater than lookback
if(len(dataset_test) <= int(sys.argv[3])):
    print("Interval not long enough")
    quit()

# samples
original_as_series = dataset_test['sample'].copy()
x_axis = [time for time in dataset_test["time"]]
original_as_series.index = x_axis
ax = original_as_series.plot(color="blue", label="Sample", linewidth=1)

# lists
horizons = ["12", "24", "48", "96", "192", "384", "768", "1536"]
colors = ["red", "limegreen", "cyan", "maroon", "orange", "lightgray", "yellow", "black"]
rmse = []
mae = []

# iterate over the different forecast (horizon) values
for i in range(8):
    # predict horizons
    Y3_ , rmse_, mae_, test_len, forecast_len, len_data, interval = predict_values(sys.argv[3], horizons[i], dataset_test)
    # plot results
    df_future = pd.DataFrame(columns=['Forecast'])
    df_future['Forecast'] = Y3_.flatten()
    predicted_as_series = df_future['Forecast']
    predicted_as_series.index = x_axis[test_len:test_len+forecast_len]
    predicted_as_series.plot(ax=ax, color=colors[i], label="Horizon: " + horizons[i], linewidth=1)
    rmse.append(rmse_)
    mae.append(mae_)

# title
plt.suptitle("Metric: " + sys.argv[1] + ", App: " + sys.argv[2] + ", Lookback: " + sys.argv[3] + ", Horizon: 12-1536\n12-12 RMSE: " + str("{:.5f}".format(rmse[0])) + " - MAE: " + str("{:.5f}".format(mae[0])) + " | 12-192 RMSE: " + str("{:.5f}".format(rmse[4])) + " - MAE: " + str("{:.5f}".format(mae[4])) + "\n12-24 RMSE: " + str("{:.5f}".format(rmse[1])) + " - MAE: " + str("{:.5f}".format(mae[1])) + " | 12-384 RMSE: " + str("{:.5f}".format(rmse[5])) + " - MAE: " + str("{:.5f}".format(mae[5])) + "\n12-48 RMSE: " + str("{:.5f}".format(rmse[2])) + " - MAE: " + str("{:.5f}".format(mae[2])) + " | 12-768 RMSE: " + str("{:.5f}".format(rmse[6])) + " - MAE: " + str("{:.5f}".format(mae[6])) + "\n12-96 RMSE: " + str("{:.5f}".format(rmse[3])) + " - MAE: " + str("{:.5f}".format(mae[3])) + " | 12-1536 RMSE: " + str("{:.5f}".format(rmse[7])) + " - MAE: " + str("{:.5f}".format(mae[7])) + "\n Interval: " + str(interval) + ". Samples in this interval: " + str(len_data))

# plot features
plt.legend(ncol=2, loc="upper left")
plt.xlabel("Minutes")
plt.ylabel("Values")
#plt.tight_layout()
plt.subplots_adjust(top=0.85)
plt.subplots_adjust(bottom=0.1)
plt.show()

