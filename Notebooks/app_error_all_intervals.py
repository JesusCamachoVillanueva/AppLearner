# imports
import matplotlib.pyplot as plt
import sys, getopt, os
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
from memory_profiler import profile

pd.options.mode.chained_assignment = None
tf.random.set_seed(0)

# read dataset
dataset_ = ds.get_data_set(
    metric=sys.argv[1],
    application_name=sys.argv[2],
    path_to_data="../data/"
)

def get_model(trained_model):

    # trained models files to load
    file = sys.argv[4]+"_"+trained_model;
    # load json and create model
    json_file = open(file+".json", 'r')
    loaded_model_json = json_file.read()
    json_file.close()
    model = model_from_json(loaded_model_json)

    # load weights into new model
    model.load_weights(file+".h5")
    print("Loaded model " + file + " from disk")

    return model

# @profile

def predict_values(sys3, horizon, dataset_test, model):

    # input and output sequences
    n_lookback = int(sys3)  # length of input sequences (lookback period)
    n_forecast = int(horizon)  # length of output sequences (forecast period)

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
    Y_ = model(X_)
    Y_ = Y_.numpy().reshape(-1, 1)
    Y3_ = []
    Y3_ = np.array(Y3_)
    Y3_ = Y_
    # cut first prediction when longer than test set
    if(len(Y3_) > len_data - n_lookback):
        Y3_ = Y_[0:len_data - n_lookback]

    # append forecasts
    for i in range(int((len(dataset_test)-len(data_test))/n_forecast) - 0):
        X2_ = y[test_len-n_lookback+(n_forecast*(i+1)):test_len+(n_forecast*(i+1))]
        X2_ = X2_.reshape(1, n_lookback, 1)
        Y2_ = model(X2_)
        Y2_ = Y2_.numpy().reshape(-1, 1)
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

    return number, len(dataset_test), rmse, mae


# create file to write errors
error_file = sys.argv[4]+".error"
try:
    os.remove(error_file)
except OSError:
    pass
file = open(error_file, 'w')
file.write("forecast interval #samples RMSE MAE\n")
file.write("-----------------------------------\n")
file.close()

# lists
horizons = ["12", "24", "48", "96", "192", "384", "768", "1536"]
colors = ["red", "limegreen", "cyan", "maroon", "orange", "lightgray", "yellow", "black"]

# get models

model_0 = get_model(horizons[0])
model_1 = get_model(horizons[1])
model_2 = get_model(horizons[2])
model_3 = get_model(horizons[3])
model_4 = get_model(horizons[4])
model_5 = get_model(horizons[5])
model_6 = get_model(horizons[6])
model_7 = get_model(horizons[7])

# obtain RMSE and MAE for all intervals
for n in range(int(len(dataset_) * 0.33)):

    # get interval
    number = n % int(len(dataset_) * 0.33)

    # forecast interval selected (testing part)
    dataset_test = dataset_[int(len(dataset_) * 0.67) + number]

    print("Interval: "+str(number+1)+"/"+str(int(len(dataset_) * 0.33))+", #samples: "+(str(len(dataset_test))))

    # dataset_test must be euqls or greater than lookback
    if(len(dataset_test) <= int(sys.argv[3])):
        print("Interval not long enough")
        continue
    
    # iterate over the different forecast (horizon) values
    for i in range(8):

        # predict horizons & append errors
        file = open(error_file, 'a')

        if i == 0:
            number, len_test, rmse, mae = predict_values(sys.argv[3], horizons[i], dataset_test, model_0)
            file.write("12 "+str(number)+" "+str(len_test)+" "+str("{:.5f}".format(rmse))+" "+str("{:.5f}".format(mae))+"\n")
        elif i == 1:
            number, len_test, rmse, mae = predict_values(sys.argv[3], horizons[i], dataset_test, model_1)
            file.write("24 "+str(number)+" "+str(len_test)+" "+str("{:.5f}".format(rmse))+" "+str("{:.5f}".format(mae))+"\n")
        elif i == 2:
            number, len_test, rmse, mae = predict_values(sys.argv[3], horizons[i], dataset_test, model_2)
            file.write("48 "+str(number)+" "+str(len_test)+" "+str("{:.5f}".format(rmse))+" "+str("{:.5f}".format(mae))+"\n")
        elif i == 3:
            number, len_test, rmse, mae = predict_values(sys.argv[3], horizons[i], dataset_test, model_3)
            file.write("96 "+str(number)+" "+str(len_test)+" "+str("{:.5f}".format(rmse))+" "+str("{:.5f}".format(mae))+"\n")
        elif i == 4:
            number, len_test, rmse, mae = predict_values(sys.argv[3], horizons[i], dataset_test, model_4)
            file.write("192 "+str(number)+" "+str(len_test)+" "+str("{:.5f}".format(rmse))+" "+str("{:.5f}".format(mae))+"\n")
        elif i == 5:
            number, len_test, rmse, mae = predict_values(sys.argv[3], horizons[i], dataset_test, model_5)
            file.write("384 "+str(number)+" "+str(len_test)+" "+str("{:.5f}".format(rmse))+" "+str("{:.5f}".format(mae))+"\n")
        elif i == 6:
            number, len_test, rmse, mae = predict_values(sys.argv[3], horizons[i], dataset_test, model_6)
            file.write("768 "+str(number)+" "+str(len_test)+" "+str("{:.5f}".format(rmse))+" "+str("{:.5f}".format(mae))+"\n")
        else:
            number, len_test, rmse, mae = predict_values(sys.argv[3], horizons[i], dataset_test, model_7)
            file.write("1536 "+str(number)+" "+str(len_test)+" "+str("{:.5f}".format(rmse)+" "+str("{:.5f}".format(mae)))+"\n")
        file.close()

