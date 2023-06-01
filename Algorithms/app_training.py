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
dataset = ds.get_data_set(
    metric=sys.argv[1],
    application_name=sys.argv[2],
    path_to_data="../data/"
)

scaler_train = MinMaxScaler()
for i in range(0, int(len(dataset))):
    dataset[i]['sample'] = scaler_train.fit_transform(dataset[i][['sample']])

# generate the input and output sequences
n_lookback = int(sys.argv[3])  # length of input sequences (lookback period)
n_forecast = int(sys.argv[4])  # length of output sequences (forecast period)

# fit the model
model = Sequential()
model.add(LSTM(units=50, return_sequences=True, input_shape=(n_lookback, 1)))
model.add(LSTM(units=50))
model.add(Dense(n_forecast))

# model compilation
model.compile(loss='mean_squared_error', optimizer='adam')

upto = int(len(dataset) * 0.67)

X = []
Y = []

# store X->Y from every interval recorder separately (no concatenation between intervals)
for i in range(0, upto):

    data_train = dataset[i]

    y = data_train['sample'].fillna(method='ffill')
    y = y.values.reshape(-1, 1)

    if(n_lookback >= len(y) - n_forecast + 1):
        continue

    for j in range(n_lookback, len(y) - n_forecast + 1):
        X.append(y[j - n_lookback: j])
        Y.append(y[j: j + n_forecast])

X = np.array(X)
Y = np.array(Y)

# train model
model.fit(X, Y, epochs=100, batch_size=100, verbose=2)

# save trained model
# serialize model to JSON
model_json = model.to_json()
with open(sys.argv[5]+".json", "w") as json_file:
    json_file.write(model_json)
# serialize weights to HDF5
model.save_weights(sys.argv[5]+".h5")
print("Saved model to disk")

