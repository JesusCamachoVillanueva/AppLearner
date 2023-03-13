# AppLearner

The goal of the project is to build as accurately as possible a prediction model, which will be able to predict the resource consumption of a given container in K8.
Time-series data on CPU/Memory usage provided by Prometheus, will be used to learn and forecast future resources usage.

## Background:
Please, visit https://github.com/AdiY10/AppLearner/ for all the details.

### src:
Source folder is taken from https://github.com/AdiY10/AppLearner/

### Notebooks:
Notebooks folders contains app_training.py and app_testing.py

app_training.py trains models from data (CPU and Memory).  
Usage: python3 app_training.py container_cpu/container_mem $app_name $lookback $forecast $output_file  
Example: python3 app_training.py container_cpu coredns 24 24 cpu_coredns_24_24

app_testing.py predicts the unknown sequences showing graphs with MAE and RSME with diferent number of forecast steps  
Usage: python3 app_testing.py container_cpu/container_mem $app_name $output_file $interval //interval can be any number. Use different intervals for different ouputs from different sample measurements.  
Example: python3 app_testing.py container_cpu coredns cpu_coredns_24_24 100

### TrainedModels
Contains several already trained models with lookback 12 and 24 and forecast 12, 24, 48, 96, 192, 384, 768 and 1536
