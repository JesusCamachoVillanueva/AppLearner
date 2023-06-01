# Author "Jesus Camacho Villanueva <jcamacho@redhat.com>"

#!/bin/bash

#get file information
arg=$1
lines_in_file=$(wc $arg)
total_with_head=$(echo $lines_in_file | cut -d ' ' -f1)
total=$(expr $total_with_head - 2)
total_by_forecast=$(expr $total / 8)
file=${arg::-6}
output_file=$(echo $file".deciles")
lookback="${file: -2}"

#get deciles
range_12_rmse_0=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_12_rmse_1=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_12_rmse_2=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_12_rmse_3=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_12_rmse_4=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.20 && $4 < 0.25) print $4 }' | wc -l)
range_12_rmse_5=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.25 && $4 < 0.30) print $4 }' | wc -l)
range_12_rmse_6=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.30 && $4 < 0.35) print $4 }' | wc -l)
range_12_rmse_7=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.35 && $4 < 0.40) print $4 }' | wc -l)
range_12_rmse_8=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.40 && $4 < 0.45) print $4 }' | wc -l)
range_12_rmse_9=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.45 && $4 < 0.50) print $4 }' | wc -l)
range_12_rmse_10=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.50) print $4 }' | wc -l)

range_24_rmse_0=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_24_rmse_1=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_24_rmse_2=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_24_rmse_3=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_24_rmse_4=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.20 && $4 < 0.25) print $4 }' | wc -l)
range_24_rmse_5=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.25 && $4 < 0.30) print $4 }' | wc -l)
range_24_rmse_6=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.30 && $4 < 0.35) print $4 }' | wc -l)
range_24_rmse_7=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.35 && $4 < 0.40) print $4 }' | wc -l)
range_24_rmse_8=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.40 && $4 < 0.45) print $4 }' | wc -l)
range_24_rmse_9=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.45 && $4 < 0.50) print $4 }' | wc -l)
range_24_rmse_10=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.50) print $4 }' | wc -l)

range_48_rmse_0=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_48_rmse_1=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_48_rmse_2=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_48_rmse_3=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_48_rmse_4=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.20 && $4 < 0.25) print $4 }' | wc -l)
range_48_rmse_5=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.25 && $4 < 0.30) print $4 }' | wc -l)
range_48_rmse_6=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.30 && $4 < 0.35) print $4 }' | wc -l)
range_48_rmse_7=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.35 && $4 < 0.40) print $4 }' | wc -l)
range_48_rmse_8=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.40 && $4 < 0.45) print $4 }' | wc -l)
range_48_rmse_9=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.45 && $4 < 0.50) print $4 }' | wc -l)
range_48_rmse_10=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.50) print $4 }' | wc -l)

range_96_rmse_0=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_96_rmse_1=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_96_rmse_2=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_96_rmse_3=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_96_rmse_4=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.20 && $4 < 0.25) print $4 }' | wc -l)
range_96_rmse_5=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.25 && $4 < 0.30) print $4 }' | wc -l)
range_96_rmse_6=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.30 && $4 < 0.35) print $4 }' | wc -l)
range_96_rmse_7=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.35 && $4 < 0.40) print $4 }' | wc -l)
range_96_rmse_8=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.40 && $4 < 0.45) print $4 }' | wc -l)
range_96_rmse_9=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.45 && $4 < 0.50) print $4 }' | wc -l)
range_96_rmse_10=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.50) print $4 }' | wc -l)

range_192_rmse_0=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_192_rmse_1=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_192_rmse_2=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_192_rmse_3=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_192_rmse_4=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.20 && $4 < 0.25) print $4 }' | wc -l)
range_192_rmse_5=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.25 && $4 < 0.30) print $4 }' | wc -l)
range_192_rmse_6=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.30 && $4 < 0.35) print $4 }' | wc -l)
range_192_rmse_7=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.35 && $4 < 0.40) print $4 }' | wc -l)
range_192_rmse_8=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.40 && $4 < 0.45) print $4 }' | wc -l)
range_192_rmse_9=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.45 && $4 < 0.50) print $4 }' | wc -l)
range_192_rmse_10=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.50) print $4 }' | wc -l)

range_384_rmse_0=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_384_rmse_1=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_384_rmse_2=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_384_rmse_3=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_384_rmse_4=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.20 && $4 < 0.25) print $4 }' | wc -l)
range_384_rmse_5=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.25 && $4 < 0.30) print $4 }' | wc -l)
range_384_rmse_6=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.30 && $4 < 0.35) print $4 }' | wc -l)
range_384_rmse_7=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.35 && $4 < 0.40) print $4 }' | wc -l)
range_384_rmse_8=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.40 && $4 < 0.45) print $4 }' | wc -l)
range_384_rmse_9=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.45 && $4 < 0.50) print $4 }' | wc -l)
range_384_rmse_10=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.50) print $4 }' | wc -l)

range_768_rmse_0=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_768_rmse_1=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_768_rmse_2=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_768_rmse_3=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_768_rmse_4=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.20 && $4 < 0.25) print $4 }' | wc -l)
range_768_rmse_5=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.25 && $4 < 0.30) print $4 }' | wc -l)
range_768_rmse_6=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.30 && $4 < 0.35) print $4 }' | wc -l)
range_768_rmse_7=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.35 && $4 < 0.40) print $4 }' | wc -l)
range_768_rmse_8=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.40 && $4 < 0.45) print $4 }' | wc -l)
range_768_rmse_9=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.45 && $4 < 0.50) print $4 }' | wc -l)
range_768_rmse_10=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.50) print $4 }' | wc -l)

range_1536_rmse_0=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_1536_rmse_1=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_1536_rmse_2=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_1536_rmse_3=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_1536_rmse_4=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.20 && $4 < 0.25) print $4 }' | wc -l)
range_1536_rmse_5=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.25 && $4 < 0.30) print $4 }' | wc -l)
range_1536_rmse_6=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.30 && $4 < 0.35) print $4 }' | wc -l)
range_1536_rmse_7=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.35 && $4 < 0.40) print $4 }' | wc -l)
range_1536_rmse_8=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.40 && $4 < 0.45) print $4 }' | wc -l)
range_1536_rmse_9=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.45 && $4 < 0.50) print $4 }' | wc -l)
range_1536_rmse_10=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.50) print $4 }' | wc -l)


range_12_mae_0=$(cat $1 | grep "^12" | awk '{ if ($5 >= 0 && $5 < 0.05) print $5 }' | wc -l)
range_12_mae_1=$(cat $1 | grep "^12" | awk '{ if ($5 >= 0.05 && $5 < 0.10) print $5 }' | wc -l)
range_12_mae_2=$(cat $1 | grep "^12" | awk '{ if ($5 >= 0.10 && $5 < 0.15) print $5 }' | wc -l)
range_12_mae_3=$(cat $1 | grep "^12" | awk '{ if ($5 >= 0.15 && $5 < 0.20) print $5 }' | wc -l)
range_12_mae_4=$(cat $1 | grep "^12" | awk '{ if ($5 >= 0.20 && $5 < 0.25) print $5 }' | wc -l)
range_12_mae_5=$(cat $1 | grep "^12" | awk '{ if ($5 >= 0.25 && $5 < 0.30) print $5 }' | wc -l)
range_12_mae_6=$(cat $1 | grep "^12" | awk '{ if ($5 >= 0.30 && $5 < 0.35) print $5 }' | wc -l)
range_12_mae_7=$(cat $1 | grep "^12" | awk '{ if ($5 >= 0.35 && $5 < 0.40) print $5 }' | wc -l)
range_12_mae_8=$(cat $1 | grep "^12" | awk '{ if ($5 >= 0.40 && $5 < 0.45) print $5 }' | wc -l)
range_12_mae_9=$(cat $1 | grep "^12" | awk '{ if ($5 >= 0.45 && $5 < 0.50) print $5 }' | wc -l)
range_12_mae_10=$(cat $1 | grep "^12" | awk '{ if ($5 >= 0.50) print $5 }' | wc -l)

range_24_mae_0=$(cat $1 | grep "^24" | awk '{ if ($5 >= 0 && $5 < 0.05) print $5 }' | wc -l)
range_24_mae_1=$(cat $1 | grep "^24" | awk '{ if ($5 >= 0.05 && $5 < 0.10) print $5 }' | wc -l)
range_24_mae_2=$(cat $1 | grep "^24" | awk '{ if ($5 >= 0.10 && $5 < 0.15) print $5 }' | wc -l)
range_24_mae_3=$(cat $1 | grep "^24" | awk '{ if ($5 >= 0.15 && $5 < 0.20) print $5 }' | wc -l)
range_24_mae_4=$(cat $1 | grep "^24" | awk '{ if ($5 >= 0.20 && $5 < 0.25) print $5 }' | wc -l)
range_24_mae_5=$(cat $1 | grep "^24" | awk '{ if ($5 >= 0.25 && $5 < 0.30) print $5 }' | wc -l)
range_24_mae_6=$(cat $1 | grep "^24" | awk '{ if ($5 >= 0.30 && $5 < 0.35) print $5 }' | wc -l)
range_24_mae_7=$(cat $1 | grep "^24" | awk '{ if ($5 >= 0.35 && $5 < 0.40) print $5 }' | wc -l)
range_24_mae_8=$(cat $1 | grep "^24" | awk '{ if ($5 >= 0.40 && $5 < 0.45) print $5 }' | wc -l)
range_24_mae_9=$(cat $1 | grep "^24" | awk '{ if ($5 >= 0.45 && $5 < 0.50) print $5 }' | wc -l)
range_24_mae_10=$(cat $1 | grep "^24" | awk '{ if ($5 >= 0.50) print $5 }' | wc -l)

range_48_mae_0=$(cat $1 | grep "^48" | awk '{ if ($5 >= 0 && $5 < 0.05) print $5 }' | wc -l)
range_48_mae_1=$(cat $1 | grep "^48" | awk '{ if ($5 >= 0.05 && $5 < 0.10) print $5 }' | wc -l)
range_48_mae_2=$(cat $1 | grep "^48" | awk '{ if ($5 >= 0.10 && $5 < 0.15) print $5 }' | wc -l)
range_48_mae_3=$(cat $1 | grep "^48" | awk '{ if ($5 >= 0.15 && $5 < 0.20) print $5 }' | wc -l)
range_48_mae_4=$(cat $1 | grep "^48" | awk '{ if ($5 >= 0.20 && $5 < 0.25) print $5 }' | wc -l)
range_48_mae_5=$(cat $1 | grep "^48" | awk '{ if ($5 >= 0.25 && $5 < 0.30) print $5 }' | wc -l)
range_48_mae_6=$(cat $1 | grep "^48" | awk '{ if ($5 >= 0.30 && $5 < 0.35) print $5 }' | wc -l)
range_48_mae_7=$(cat $1 | grep "^48" | awk '{ if ($5 >= 0.35 && $5 < 0.40) print $5 }' | wc -l)
range_48_mae_8=$(cat $1 | grep "^48" | awk '{ if ($5 >= 0.40 && $5 < 0.45) print $5 }' | wc -l)
range_48_mae_9=$(cat $1 | grep "^48" | awk '{ if ($5 >= 0.45 && $5 < 0.50) print $5 }' | wc -l)
range_48_mae_10=$(cat $1 | grep "^48" | awk '{ if ($5 >= 0.50) print $5 }' | wc -l)

range_96_mae_0=$(cat $1 | grep "^96" | awk '{ if ($5 >= 0 && $5 < 0.05) print $5 }' | wc -l)
range_96_mae_1=$(cat $1 | grep "^96" | awk '{ if ($5 >= 0.05 && $5 < 0.10) print $5 }' | wc -l)
range_96_mae_2=$(cat $1 | grep "^96" | awk '{ if ($5 >= 0.10 && $5 < 0.15) print $5 }' | wc -l)
range_96_mae_3=$(cat $1 | grep "^96" | awk '{ if ($5 >= 0.15 && $5 < 0.20) print $5 }' | wc -l)
range_96_mae_4=$(cat $1 | grep "^96" | awk '{ if ($5 >= 0.20 && $5 < 0.25) print $5 }' | wc -l)
range_96_mae_5=$(cat $1 | grep "^96" | awk '{ if ($5 >= 0.25 && $5 < 0.30) print $5 }' | wc -l)
range_96_mae_6=$(cat $1 | grep "^96" | awk '{ if ($5 >= 0.30 && $5 < 0.35) print $5 }' | wc -l)
range_96_mae_7=$(cat $1 | grep "^96" | awk '{ if ($5 >= 0.35 && $5 < 0.40) print $5 }' | wc -l)
range_96_mae_8=$(cat $1 | grep "^96" | awk '{ if ($5 >= 0.40 && $5 < 0.45) print $5 }' | wc -l)
range_96_mae_9=$(cat $1 | grep "^96" | awk '{ if ($5 >= 0.45 && $5 < 0.50) print $5 }' | wc -l)
range_96_mae_10=$(cat $1 | grep "^96" | awk '{ if ($5 >= 0.50) print $5 }' | wc -l)

range_192_mae_0=$(cat $1 | grep "^192" | awk '{ if ($5 >= 0 && $5 < 0.05) print $5 }' | wc -l)
range_192_mae_1=$(cat $1 | grep "^192" | awk '{ if ($5 >= 0.05 && $5 < 0.10) print $5 }' | wc -l)
range_192_mae_2=$(cat $1 | grep "^192" | awk '{ if ($5 >= 0.10 && $5 < 0.15) print $5 }' | wc -l)
range_192_mae_3=$(cat $1 | grep "^192" | awk '{ if ($5 >= 0.15 && $5 < 0.20) print $5 }' | wc -l)
range_192_mae_4=$(cat $1 | grep "^192" | awk '{ if ($5 >= 0.20 && $5 < 0.25) print $5 }' | wc -l)
range_192_mae_5=$(cat $1 | grep "^192" | awk '{ if ($5 >= 0.25 && $5 < 0.30) print $5 }' | wc -l)
range_192_mae_6=$(cat $1 | grep "^192" | awk '{ if ($5 >= 0.30 && $5 < 0.35) print $5 }' | wc -l)
range_192_mae_7=$(cat $1 | grep "^192" | awk '{ if ($5 >= 0.35 && $5 < 0.40) print $5 }' | wc -l)
range_192_mae_8=$(cat $1 | grep "^192" | awk '{ if ($5 >= 0.40 && $5 < 0.45) print $5 }' | wc -l)
range_192_mae_9=$(cat $1 | grep "^192" | awk '{ if ($5 >= 0.45 && $5 < 0.50) print $5 }' | wc -l)
range_192_mae_10=$(cat $1 | grep "^192" | awk '{ if ($5 >= 0.50) print $5 }' | wc -l)

range_384_mae_0=$(cat $1 | grep "^384" | awk '{ if ($5 >= 0 && $5 < 0.05) print $5 }' | wc -l)
range_384_mae_1=$(cat $1 | grep "^384" | awk '{ if ($5 >= 0.05 && $5 < 0.10) print $5 }' | wc -l)
range_384_mae_2=$(cat $1 | grep "^384" | awk '{ if ($5 >= 0.10 && $5 < 0.15) print $5 }' | wc -l)
range_384_mae_3=$(cat $1 | grep "^384" | awk '{ if ($5 >= 0.15 && $5 < 0.20) print $5 }' | wc -l)
range_384_mae_4=$(cat $1 | grep "^384" | awk '{ if ($5 >= 0.20 && $5 < 0.25) print $5 }' | wc -l)
range_384_mae_5=$(cat $1 | grep "^384" | awk '{ if ($5 >= 0.25 && $5 < 0.30) print $5 }' | wc -l)
range_384_mae_6=$(cat $1 | grep "^384" | awk '{ if ($5 >= 0.30 && $5 < 0.35) print $5 }' | wc -l)
range_384_mae_7=$(cat $1 | grep "^384" | awk '{ if ($5 >= 0.35 && $5 < 0.40) print $5 }' | wc -l)
range_384_mae_8=$(cat $1 | grep "^384" | awk '{ if ($5 >= 0.40 && $5 < 0.45) print $5 }' | wc -l)
range_384_mae_9=$(cat $1 | grep "^384" | awk '{ if ($5 >= 0.45 && $5 < 0.50) print $5 }' | wc -l)
range_384_mae_10=$(cat $1 | grep "^384" | awk '{ if ($5 >= 0.50) print $5 }' | wc -l)

range_768_mae_0=$(cat $1 | grep "^768" | awk '{ if ($5 >= 0 && $5 < 0.05) print $5 }' | wc -l)
range_768_mae_1=$(cat $1 | grep "^768" | awk '{ if ($5 >= 0.05 && $5 < 0.10) print $5 }' | wc -l)
range_768_mae_2=$(cat $1 | grep "^768" | awk '{ if ($5 >= 0.10 && $5 < 0.15) print $5 }' | wc -l)
range_768_mae_3=$(cat $1 | grep "^768" | awk '{ if ($5 >= 0.15 && $5 < 0.20) print $5 }' | wc -l)
range_768_mae_4=$(cat $1 | grep "^768" | awk '{ if ($5 >= 0.20 && $5 < 0.25) print $5 }' | wc -l)
range_768_mae_5=$(cat $1 | grep "^768" | awk '{ if ($5 >= 0.25 && $5 < 0.30) print $5 }' | wc -l)
range_768_mae_6=$(cat $1 | grep "^768" | awk '{ if ($5 >= 0.30 && $5 < 0.35) print $5 }' | wc -l)
range_768_mae_7=$(cat $1 | grep "^768" | awk '{ if ($5 >= 0.35 && $5 < 0.40) print $5 }' | wc -l)
range_768_mae_8=$(cat $1 | grep "^768" | awk '{ if ($5 >= 0.40 && $5 < 0.45) print $5 }' | wc -l)
range_768_mae_9=$(cat $1 | grep "^768" | awk '{ if ($5 >= 0.45 && $5 < 0.50) print $5 }' | wc -l)
range_768_mae_10=$(cat $1 | grep "^768" | awk '{ if ($5 >= 0.50) print $5 }' | wc -l)

range_1536_mae_0=$(cat $1 | grep "^1536" | awk '{ if ($5 >= 0 && $5 < 0.05) print $5 }' | wc -l)
range_1536_mae_1=$(cat $1 | grep "^1536" | awk '{ if ($5 >= 0.05 && $5 < 0.10) print $5 }' | wc -l)
range_1536_mae_2=$(cat $1 | grep "^1536" | awk '{ if ($5 >= 0.10 && $5 < 0.15) print $5 }' | wc -l)
range_1536_mae_3=$(cat $1 | grep "^1536" | awk '{ if ($5 >= 0.15 && $5 < 0.20) print $5 }' | wc -l)
range_1536_mae_4=$(cat $1 | grep "^1536" | awk '{ if ($5 >= 0.20 && $5 < 0.25) print $5 }' | wc -l)
range_1536_mae_5=$(cat $1 | grep "^1536" | awk '{ if ($5 >= 0.25 && $5 < 0.30) print $5 }' | wc -l)
range_1536_mae_6=$(cat $1 | grep "^1536" | awk '{ if ($5 >= 0.30 && $5 < 0.35) print $5 }' | wc -l)
range_1536_mae_7=$(cat $1 | grep "^1536" | awk '{ if ($5 >= 0.35 && $5 < 0.40) print $5 }' | wc -l)
range_1536_mae_8=$(cat $1 | grep "^1536" | awk '{ if ($5 >= 0.40 && $5 < 0.45) print $5 }' | wc -l)
range_1536_mae_9=$(cat $1 | grep "^1536" | awk '{ if ($5 >= 0.45 && $5 < 0.50) print $5 }' | wc -l)
range_1536_mae_10=$(cat $1 | grep "^1536" | awk '{ if ($5 >= 0.50) print $5 }' | wc -l)


#print deciles
echo -e lookback forecash quantile total RMSE MAE > $output_file
echo -e ----------------------------------------- >> $output_file
echo -e $lookback 12   0.00-0.05 $total_by_forecast $range_12_rmse_0 $range_12_mae_0 >> $output_file
echo -e $lookback 12   0.05-0.10 $total_by_forecast $range_12_rmse_1 $range_12_mae_1 >> $output_file
echo -e $lookback 12   0.10-0.15 $total_by_forecast $range_12_rmse_2 $range_12_mae_2 >> $output_file
echo -e $lookback 12   0.15-0.20 $total_by_forecast $range_12_rmse_3 $range_12_mae_3 >> $output_file
echo -e $lookback 12   0.20-0.25 $total_by_forecast $range_12_rmse_4 $range_12_mae_4 >> $output_file
echo -e $lookback 12   0.25-0.30 $total_by_forecast $range_12_rmse_5 $range_12_mae_5 >> $output_file
echo -e $lookback 12   0.30-0.35 $total_by_forecast $range_12_rmse_6 $range_12_mae_6 >> $output_file
echo -e $lookback 12   0.35-0.40 $total_by_forecast $range_12_rmse_7 $range_12_mae_7 >> $output_file
echo -e $lookback 12   0.40-0.45 $total_by_forecast $range_12_rmse_8 $range_12_mae_8 >> $output_file
echo -e $lookback 12   0.45-0.50 $total_by_forecast $range_12_rmse_9 $range_12_mae_9 >> $output_file
echo -e $lookback 12   0.50-1.00 $total_by_forecast $range_12_rmse_10 $range_12_mae_10 >> $output_file
echo "" >> $output_file
echo -e $lookback 24   0.00-0.05 $total_by_forecast $range_24_rmse_0 $range_24_mae_0 >> $output_file
echo -e $lookback 24   0.05-0.10 $total_by_forecast $range_24_rmse_1 $range_24_mae_1 >> $output_file
echo -e $lookback 24   0.10-0.15 $total_by_forecast $range_24_rmse_2 $range_24_mae_2 >> $output_file
echo -e $lookback 24   0.15-0.20 $total_by_forecast $range_24_rmse_3 $range_24_mae_3 >> $output_file
echo -e $lookback 24   0.20-0.25 $total_by_forecast $range_24_rmse_4 $range_24_mae_4 >> $output_file
echo -e $lookback 24   0.25-0.30 $total_by_forecast $range_24_rmse_5 $range_24_mae_5 >> $output_file
echo -e $lookback 24   0.30-0.35 $total_by_forecast $range_24_rmse_6 $range_24_mae_6 >> $output_file
echo -e $lookback 24   0.35-0.40 $total_by_forecast $range_24_rmse_7 $range_24_mae_7 >> $output_file
echo -e $lookback 24   0.40-0.45 $total_by_forecast $range_24_rmse_8 $range_24_mae_8 >> $output_file
echo -e $lookback 24   0.45-0.50 $total_by_forecast $range_24_rmse_9 $range_24_mae_9 >> $output_file
echo -e $lookback 24   0.50-1.00 $total_by_forecast $range_24_rmse_10 $range_24_mae_10 >> $output_file
echo "" >> $output_file
echo -e $lookback 48   0.00-0.05 $total_by_forecast $range_48_rmse_0 $range_48_mae_0 >> $output_file
echo -e $lookback 48   0.05-0.10 $total_by_forecast $range_48_rmse_1 $range_48_mae_1 >> $output_file
echo -e $lookback 48   0.10-0.15 $total_by_forecast $range_48_rmse_2 $range_48_mae_2 >> $output_file
echo -e $lookback 48   0.15-0.20 $total_by_forecast $range_48_rmse_3 $range_48_mae_3 >> $output_file
echo -e $lookback 48   0.20-0.25 $total_by_forecast $range_48_rmse_4 $range_48_mae_4 >> $output_file
echo -e $lookback 48   0.25-0.30 $total_by_forecast $range_48_rmse_5 $range_48_mae_5 >> $output_file
echo -e $lookback 48   0.30-0.35 $total_by_forecast $range_48_rmse_6 $range_48_mae_6 >> $output_file
echo -e $lookback 48   0.35-0.40 $total_by_forecast $range_48_rmse_7 $range_48_mae_7 >> $output_file
echo -e $lookback 48   0.40-0.45 $total_by_forecast $range_48_rmse_8 $range_48_mae_8 >> $output_file
echo -e $lookback 48   0.45-0.50 $total_by_forecast $range_48_rmse_9 $range_48_mae_9 >> $output_file
echo -e $lookback 48   0.50-1.00 $total_by_forecast $range_48_rmse_10 $range_48_mae_10 >> $output_file
echo "" >> $output_file
echo -e $lookback 96   0.00-0.05 $total_by_forecast $range_96_rmse_0 $range_96_mae_0 >> $output_file
echo -e $lookback 96   0.05-0.10 $total_by_forecast $range_96_rmse_1 $range_96_mae_1 >> $output_file
echo -e $lookback 96   0.10-0.15 $total_by_forecast $range_96_rmse_2 $range_96_mae_2 >> $output_file
echo -e $lookback 96   0.15-0.20 $total_by_forecast $range_96_rmse_3 $range_96_mae_3 >> $output_file
echo -e $lookback 96   0.20-0.25 $total_by_forecast $range_96_rmse_4 $range_96_mae_4 >> $output_file
echo -e $lookback 96   0.25-0.30 $total_by_forecast $range_96_rmse_5 $range_96_mae_5 >> $output_file
echo -e $lookback 96   0.30-0.35 $total_by_forecast $range_96_rmse_6 $range_96_mae_6 >> $output_file
echo -e $lookback 96   0.35-0.40 $total_by_forecast $range_96_rmse_7 $range_96_mae_7 >> $output_file
echo -e $lookback 96   0.40-0.45 $total_by_forecast $range_96_rmse_8 $range_96_mae_8 >> $output_file
echo -e $lookback 96   0.45-0.50 $total_by_forecast $range_96_rmse_9 $range_96_mae_9 >> $output_file
echo -e $lookback 96   0.50-1.00 $total_by_forecast $range_96_rmse_10 $range_96_mae_10 >> $output_file
echo "" >> $output_file
echo -e $lookback 192   0.00-0.05 $total_by_forecast $range_192_rmse_0 $range_192_mae_0 >> $output_file
echo -e $lookback 192   0.05-0.10 $total_by_forecast $range_192_rmse_1 $range_192_mae_1 >> $output_file
echo -e $lookback 192   0.10-0.15 $total_by_forecast $range_192_rmse_2 $range_192_mae_2 >> $output_file
echo -e $lookback 192   0.15-0.20 $total_by_forecast $range_192_rmse_3 $range_192_mae_3 >> $output_file
echo -e $lookback 192   0.20-0.25 $total_by_forecast $range_192_rmse_4 $range_192_mae_4 >> $output_file
echo -e $lookback 192   0.25-0.30 $total_by_forecast $range_192_rmse_5 $range_192_mae_5 >> $output_file
echo -e $lookback 192   0.30-0.35 $total_by_forecast $range_192_rmse_6 $range_192_mae_6 >> $output_file
echo -e $lookback 192   0.35-0.40 $total_by_forecast $range_192_rmse_7 $range_192_mae_7 >> $output_file
echo -e $lookback 192   0.40-0.45 $total_by_forecast $range_192_rmse_8 $range_192_mae_8 >> $output_file
echo -e $lookback 192   0.45-0.50 $total_by_forecast $range_192_rmse_9 $range_192_mae_9 >> $output_file
echo -e $lookback 192   0.50-1.00 $total_by_forecast $range_192_rmse_10 $range_192_mae_10 >> $output_file
echo "" >> $output_file
echo -e $lookback 384   0.00-0.05 $total_by_forecast $range_384_rmse_0 $range_384_mae_0 >> $output_file
echo -e $lookback 384   0.05-0.10 $total_by_forecast $range_384_rmse_1 $range_384_mae_1 >> $output_file
echo -e $lookback 384   0.10-0.15 $total_by_forecast $range_384_rmse_2 $range_384_mae_2 >> $output_file
echo -e $lookback 384   0.15-0.20 $total_by_forecast $range_384_rmse_3 $range_384_mae_3 >> $output_file
echo -e $lookback 384   0.20-0.25 $total_by_forecast $range_384_rmse_4 $range_384_mae_4 >> $output_file
echo -e $lookback 384   0.25-0.30 $total_by_forecast $range_384_rmse_5 $range_384_mae_5 >> $output_file
echo -e $lookback 384   0.30-0.35 $total_by_forecast $range_384_rmse_6 $range_384_mae_6 >> $output_file
echo -e $lookback 384   0.35-0.40 $total_by_forecast $range_384_rmse_7 $range_384_mae_7 >> $output_file
echo -e $lookback 384   0.40-0.45 $total_by_forecast $range_384_rmse_8 $range_384_mae_8 >> $output_file
echo -e $lookback 384   0.45-0.50 $total_by_forecast $range_384_rmse_9 $range_384_mae_9 >> $output_file
echo -e $lookback 384   0.50-1.00 $total_by_forecast $range_384_rmse_10 $range_384_mae_10 >> $output_file
echo "" >> $output_file
echo -e $lookback 768   0.00-0.05 $total_by_forecast $range_768_rmse_0 $range_768_mae_0 >> $output_file
echo -e $lookback 768   0.05-0.10 $total_by_forecast $range_768_rmse_1 $range_768_mae_1 >> $output_file
echo -e $lookback 768   0.10-0.15 $total_by_forecast $range_768_rmse_2 $range_768_mae_2 >> $output_file
echo -e $lookback 768   0.15-0.20 $total_by_forecast $range_768_rmse_3 $range_768_mae_3 >> $output_file
echo -e $lookback 768   0.20-0.25 $total_by_forecast $range_768_rmse_4 $range_768_mae_4 >> $output_file
echo -e $lookback 768   0.25-0.30 $total_by_forecast $range_768_rmse_5 $range_768_mae_5 >> $output_file
echo -e $lookback 768   0.30-0.35 $total_by_forecast $range_768_rmse_6 $range_768_mae_6 >> $output_file
echo -e $lookback 768   0.35-0.40 $total_by_forecast $range_768_rmse_7 $range_768_mae_7 >> $output_file
echo -e $lookback 768   0.40-0.45 $total_by_forecast $range_768_rmse_8 $range_768_mae_8 >> $output_file
echo -e $lookback 768   0.45-0.50 $total_by_forecast $range_768_rmse_9 $range_768_mae_9 >> $output_file
echo -e $lookback 768   0.50-1.00 $total_by_forecast $range_768_rmse_10 $range_768_mae_10 >> $output_file
echo "" >> $output_file
echo -e $lookback 1536   0.00-0.05 $total_by_forecast $range_1536_rmse_0 $range_1536_mae_0 >> $output_file
echo -e $lookback 1536   0.05-0.10 $total_by_forecast $range_1536_rmse_1 $range_1536_mae_1 >> $output_file
echo -e $lookback 1536   0.10-0.15 $total_by_forecast $range_1536_rmse_2 $range_1536_mae_2 >> $output_file
echo -e $lookback 1536   0.15-0.20 $total_by_forecast $range_1536_rmse_3 $range_1536_mae_3 >> $output_file
echo -e $lookback 1536   0.20-0.25 $total_by_forecast $range_1536_rmse_4 $range_1536_mae_4 >> $output_file
echo -e $lookback 1536   0.25-0.30 $total_by_forecast $range_1536_rmse_5 $range_1536_mae_5 >> $output_file
echo -e $lookback 1536   0.30-0.35 $total_by_forecast $range_1536_rmse_6 $range_1536_mae_6 >> $output_file
echo -e $lookback 1536   0.35-0.40 $total_by_forecast $range_1536_rmse_7 $range_1536_mae_7 >> $output_file
echo -e $lookback 1536   0.40-0.45 $total_by_forecast $range_1536_rmse_8 $range_1536_mae_8 >> $output_file
echo -e $lookback 1536   0.45-0.50 $total_by_forecast $range_1536_rmse_9 $range_1536_mae_9 >> $output_file
echo -e $lookback 1536   0.50-1.00 $total_by_forecast $range_1536_rmse_10 $range_1536_mae_10 >> $output_file
echo -e File $output_file has been created!
