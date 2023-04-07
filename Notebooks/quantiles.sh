# Author "Jesus Camacho Villanueva <jcamacho@redhat.com>"

#!/bin/bash

#get file information
arg=$1
lines_in_file=$(wc $arg)
total_with_head=$(echo $lines_in_file | cut -d ' ' -f1)
total=$(expr $total_with_head - 2)
total_by_forecast=$(expr $total / 8)
file=${arg::-6}
output_file=$(echo $file".quintiles")
lookback="${file: -2}"

#get quintiles
range_12_1=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_12_2=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_12_3=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_12_4=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_12_5=$(cat $1 | grep "^12" | awk '{ if ($4 >= 0.20) print $4 }' | wc -l)

range_24_1=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_24_2=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_24_3=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_24_4=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_24_5=$(cat $1 | grep "^24" | awk '{ if ($4 >= 0.20) print $4 }' | wc -l)

range_48_1=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_48_2=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_48_3=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_48_4=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_48_5=$(cat $1 | grep "^48" | awk '{ if ($4 >= 0.20) print $4 }' | wc -l)

range_96_1=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_96_2=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_96_3=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_96_4=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_96_5=$(cat $1 | grep "^96" | awk '{ if ($4 >= 0.20) print $4 }' | wc -l)

range_192_1=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_192_2=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_192_3=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_192_4=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_192_5=$(cat $1 | grep "^192" | awk '{ if ($4 >= 0.20) print $4 }' | wc -l)

range_384_1=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_384_2=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_384_3=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_384_4=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_384_5=$(cat $1 | grep "^384" | awk '{ if ($4 >= 0.20) print $4 }' | wc -l)

range_768_1=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_768_2=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_768_3=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_768_4=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_768_5=$(cat $1 | grep "^768" | awk '{ if ($4 >= 0.20) print $4 }' | wc -l)

range_1536_1=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0 && $4 < 0.05) print $4 }' | wc -l)
range_1536_2=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.05 && $4 < 0.10) print $4 }' | wc -l)
range_1536_3=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.10 && $4 < 0.15) print $4 }' | wc -l)
range_1536_4=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.15 && $4 < 0.20) print $4 }' | wc -l)
range_1536_5=$(cat $1 | grep "^1536" | awk '{ if ($4 >= 0.20) print $4 }' | wc -l)

#print quintiles
echo -e lookback forecash quantile total matches > $output_file
echo -e ---------------------------------------- >> $output_file
echo -e $lookback 12   0.00-0.05 $total_by_forecast $range_12_1 >> $output_file
echo -e $lookback 12   0.05-0.10 $total_by_forecast $range_12_2 >> $output_file
echo -e $lookback 12   0.10-0.15 $total_by_forecast $range_12_3 >> $output_file
echo -e $lookback 12   0.15-0.20 $total_by_forecast $range_12_4 >> $output_file
echo -e $lookback 12   0.20-1.00 $total_by_forecast $range_12_5 >> $output_file
echo "" >> $output_file
echo -e $lookback 24   0.00-0.05 $total_by_forecast $range_24_1 >> $output_file
echo -e $lookback 24   0.05-0.10 $total_by_forecast $range_24_2 >> $output_file
echo -e $lookback 24   0.10-0.15 $total_by_forecast $range_24_3 >> $output_file
echo -e $lookback 24   0.15-0.20 $total_by_forecast $range_24_4 >> $output_file
echo -e $lookback 24   0.20-1.00 $total_by_forecast $range_24_5 >> $output_file
echo "" >> $output_file
echo -e $lookback 48   0.00-0.05 $total_by_forecast $range_48_1 >> $output_file
echo -e $lookback 48   0.05-0.10 $total_by_forecast $range_48_2 >> $output_file
echo -e $lookback 48   0.10-0.15 $total_by_forecast $range_48_3 >> $output_file
echo -e $lookback 48   0.15-0.20 $total_by_forecast $range_48_4 >> $output_file
echo -e $lookback 48   0.20-1.00 $total_by_forecast $range_48_5 >> $output_file
echo "" >> $output_file
echo -e $lookback 96   0.00-0.05 $total_by_forecast $range_96_1 >> $output_file
echo -e $lookback 96   0.05-0.10 $total_by_forecast $range_96_2 >> $output_file
echo -e $lookback 96   0.10-0.15 $total_by_forecast $range_96_3 >> $output_file
echo -e $lookback 96   0.15-0.20 $total_by_forecast $range_96_4 >> $output_file
echo -e $lookback 96   0.20-1.00 $total_by_forecast $range_96_5 >> $output_file
echo "" >> $output_file
echo -e $lookback 192  0.00-0.05 $total_by_forecast $range_192_1 >> $output_file
echo -e $lookback 192  0.05-0.10 $total_by_forecast $range_192_2 >> $output_file
echo -e $lookback 192  0.10-0.15 $total_by_forecast $range_192_3 >> $output_file
echo -e $lookback 192  0.15-0.20 $total_by_forecast $range_192_4 >> $output_file
echo -e $lookback 192  0.20-1.00 $total_by_forecast $range_192_5 >> $output_file
echo "" >> $output_file
echo -e $lookback 384  0.00-0.05 $total_by_forecast $range_384_1 >> $output_file
echo -e $lookback 384  0.05-0.10 $total_by_forecast $range_384_2 >> $output_file
echo -e $lookback 384  0.10-0.15 $total_by_forecast $range_384_3 >> $output_file
echo -e $lookback 384  0.15-0.20 $total_by_forecast $range_384_4 >> $output_file
echo -e $lookback 384  0.20-1.00 $total_by_forecast $range_384_5 >> $output_file
echo "" >> $output_file
echo -e $lookback 768  0.00-0.05 $total_by_forecast $range_768_1 >> $output_file
echo -e $lookback 768  0.05-0.10 $total_by_forecast $range_768_2 >> $output_file
echo -e $lookback 768  0.10-0.15 $total_by_forecast $range_768_3 >> $output_file
echo -e $lookback 768  0.15-0.20 $total_by_forecast $range_768_4 >> $output_file
echo -e $lookback 768  0.20-1.00 $total_by_forecast $range_768_5 >> $output_file
echo "" >> $output_file
echo -e $lookback 1536 0.00-0.05 $total_by_forecast $range_1536_1 >> $output_file
echo -e $lookback 1536 0.05-0.10 $total_by_forecast $range_1536_2 >> $output_file
echo -e $lookback 1536 0.10-0.15 $total_by_forecast $range_1536_3 >> $output_file
echo -e $lookback 1536 0.15-0.20 $total_by_forecast $range_1536_4 >> $output_file
echo -e $lookback 1536 0.20-1.00 $total_by_forecast $range_1536_5 >> $output_file
echo -e File $output_file has been created!
