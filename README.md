# AppLearner

The goal of the project is to build as accurately as possible a prediction model, which will be able to predict the resource consumption of a given container in K8.
Time-series data on CPU/Memory usage provided by Prometheus, will be used to learn and forecast future resources usage.

## Background:
Please, visit https://github.com/AdiY10/AppLearner/ for all the details.

### src:
Source folder is taken from https://github.com/AdiY10/AppLearner/

### Notebooks:
Notebooks folders contains app_training.py, app_predict.py, app_error.py, app_error_all_intervals.py and quantiles.sh.

app_training.py trains models from data (CPU and Memory).

//app_training.py trains apps with a given lookback and forecast and store the models of the trained apps (json & h5)  
//Trained file name should be: metric_name_lookback_forecast  
<b>Usage:</b> python3 app_training.py container_cpu/container_mem $app_name $lookback $forecast $output_file  
<b>Example</b>: python3 app_training.py container_cpu dns 12 48 cpu_coredns_12_48

//app_predict.py predicts unknown sequences showing graphs with MAE and RSME with diferent number of forecast steps  
//Interval can be any number. Use different intervals for predicting different ouputs from different sample measurements  
//Trained file is loaded by the next name: metric_name_lookback  
<b>Usage</b>: python3 app_predict.py container_cpu/container_mem $app_name $lookback $trained_file $interval  
<b>Example</b>: python3 app_predict.py container_mem coredns 24 cpu_coredns_24 100

//app_error.py prints a .error file with RMSE and MAE results for a trained $lookback with forecasts (12, 24, 48, 96, 192, 384, 768 and 1536) for a given app with a given interval  
<b>Usage</b>: python3 app_error.py container_cpu/container_mem $lookback $trained_file $interval  
<b>Example</b>: python3 app_error.py container_cpu 12 cpu_dns_12 364

//app_error_all_intervals.py prints a .error file with RMSE and MAE results for a trained $lookback with forecasts (12, 24, 48, 96, 192, 384, 768 and 1536) with all test intervals for a given app  
<b>Usage</b>: python3 app_error_all_intervals.py container_cpu/container_mem $lookback $trained_file  
<b>Example</b>: python3 app_error_all_intervals.py container_mem 24 mem_coredns_24

//quantiles.sh obtain quintiles from .error files and leaves a .quintiles files in the same path. quintiles are 0-0.5,0.5-1,1-1.5,1.5-2 and >2.  
<b>Usage</b>: ./quantiles.sh $error_file  
<b>Example</b>: ./quantiles.sh mem_coredns-monitor.error

### TrainedModels
Contains several already trained models with lookback 12 and 24 and forecast 12, 24, 48, 96, 192, 384, 768 and 1536, error and quintiles files (some trained models for lookback 24 and error and quintiles files for the mentioned lookback are still in progress and will be uploaded soon)
