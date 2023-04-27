# Author "Jesus Camacho Villanueva <jcamacho@redhat.com>"

# imports
import matplotlib.pyplot as plt
import sys, getopt
from matplotlib import pylab

def get_quantiles(sys1):

    # initialize some variables and arrays
    lookback = None
    quantiles = 12
    forecasts = 9
    Matrix_rmse = [[0 for x in range(quantiles)] for y in range(forecasts)] 
    Matrix_mae = [[0 for x in range(quantiles)] for y in range(forecasts)]

    # load deciles file
    file1 = open(sys1, 'r')
    Lines = file1.readlines()

    count = 0
    # get lookback
    for line in Lines:
        count += 1
        if(count > 2 and line.strip()):
            lookback = line.split(" ")[0]
            break

    # write RMSE and MAE statistics in the arrays
    count = 0
    new_quantile = 0
    new_forecast = 0
    for line in Lines:
        count += 1
        if(count < 3):
            continue
        if(line.strip()):
            forecast = line.split(" ")[1]
            quantile = line.split(" ")[2]
            total = line.split(" ")[3]
            rmse = line.split(" ")[4]
            mae = line.split(" ")[5]
            new_quantile = new_quantile + 1
            Matrix_rmse[new_forecast][new_quantile] = rmse
            Matrix_mae[new_forecast][new_quantile] = mae
        else:
            new_forecast = new_forecast + 1
            new_quantile = 0

    file1.close()

    return lookback, Matrix_rmse, Matrix_mae

# fined lookback, and errors from the given file
lookback, Matrix_rmse, Matrix_mae = get_quantiles(sys.argv[1])

# obatin the name of the App
if(lookback == '12'):
    file_name = sys.argv[1].split('/')[-1].split('_12.deciles', 1)[0]
else:
    file_name = sys.argv[1].split('/')[-1].split('_24.deciles', 1)[0]

# quantiles (here deciles)
x = ['0.0', '<0.5', '<1.0', '<1.5', '<2.0', '<2.5', '<3.0', '<3.5', '<4.0', '<4.5', '<5.0', '<1']

# map strings results into integers and print RMSE figure
matrix_rmse = [list(map(int, x)) for x in Matrix_rmse]

plt.plot(x, matrix_rmse[0], label="Forecast 12")
plt.plot(x, matrix_rmse[1], label="Forecast 24")
plt.plot(x, matrix_rmse[2], label="Forecast 48")
plt.plot(x, matrix_rmse[3], label="Forecast 96")
plt.plot(x, matrix_rmse[4], label="Forecast 192")
plt.plot(x, matrix_rmse[5], label="Forecast 384")
plt.plot(x, matrix_rmse[6], label="Forecast 768")
plt.plot(x, matrix_rmse[7], label="Forecast 1536")

plt.suptitle("App: " + file_name + "\nRMSE (lookback=" + lookback + ")")
plt.legend(loc='best')
plt.xlabel("Error percentage")
plt.ylabel("Samples by error percentage")
plt.show()

# map strings results into integers and print MAE figure
matrix_mae = [list(map(int, x)) for x in Matrix_mae]

plt.plot(x, matrix_mae[0], label="Forecast 12")
plt.plot(x, matrix_mae[1], label="Forecast 24")
plt.plot(x, matrix_mae[2], label="Forecast 48")
plt.plot(x, matrix_mae[3], label="Forecast 96")
plt.plot(x, matrix_mae[4], label="Forecast 192")
plt.plot(x, matrix_mae[5], label="Forecast 384")
plt.plot(x, matrix_mae[6], label="Forecast 768")
plt.plot(x, matrix_mae[7], label="Forecast 1536")

plt.suptitle("App: " + file_name + "\nMAE (lookback=" + lookback + ")")
plt.legend(loc='best')
plt.xlabel("Error percentage")
plt.ylabel("Samples by error percentage")
plt.show()

