# imports
import matplotlib.pyplot as plt
import sys, getopt, subprocess
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

class LSTM_Jesus:


    def __init__(self, metric="container_cpu", app="collector", path_to_data="../data/")
        # read dataset
        dataset = ds.get_data_set(
            metric=sys.argv[1],
            application_name=sys.argv[2],
            path_to_data="../data/"
        )

