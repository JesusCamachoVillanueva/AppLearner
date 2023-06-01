#!/usr/bin/env python3
import sys
import subprocess

# get file information
arg = sys.argv[1]
lines_in_file = subprocess.check_output(["wc", arg]).decode().split()
total_with_head = int(lines_in_file[0])
total = total_with_head - 2
total_by_forecast = total // 8
file = arg[:-6]
output_file = file + ".quintiles"
lookback = file[-2:]

# function to get range count
def get_range_count(file, forecast, lower, upper):
    cmd = f"cat {file} | grep '^{forecast}' | awk '{{ if ($4 >= {lower} && $4 < {upper}) print $4 }}' | wc -l"
    result = subprocess.check_output(cmd, shell=True).decode().strip()
    return int(result)

# get quintiles
range_12_1 = get_range_count(arg, "12", 0, 0.05)
range_12_2 = get_range_count(arg, "12", 0.05, 0.10)
range_12_3 = get_range_count(arg, "12", 0.10, 0.15)
range_12_4 = get_range_count(arg, "12", 0.15, 0.20)
range_12_5 = get_range_count(arg, "12", 0.20, 1.00)

range_24_1 = get_range_count(arg, "24", 0, 0.05)
range_24_2 = get_range_count(arg, "24", 0.05, 0.10)
range_24_3 = get_range_count(arg, "24", 0.10, 0.15)
range_24_4 = get_range_count(arg, "24", 0.15, 0.20)
range_24_5 = get_range_count(arg, "24", 0.20, 1.00)

range_48_1 = get_range_count(arg, "48", 0, 0.05)
range_48_2 = get_range_count(arg, "48", 0.05, 0.10)
range_48_3 = get_range_count(arg, "48", 0.10, 0.15)
range_48_4 = get_range_count(arg, "48", 0.15, 0.20)
range_48_5 = get_range_count(arg, "48", 0.20, 1.00)

range_96_1 = get_range_count(arg, "96", 0, 0.05)
range_96_2 = get_range_count(arg, "96", 0.05, 0.10)
range_96_3 = get_range_count(arg, "96", 0.10, 0.15)
range_96_4 = get_range_count(arg, "96", 0.15, 0.20)
range_96_5 = get_range_count(arg, "96", 0.20, 1.00)

range_192_1 = get_range_count(arg, "192", 0, 0.05)
range_192_2 = get_range_count(arg, "192", 0.05, 0.10)
range_192_3 = get_range_count(arg, "192", 0.10, 0.15)
range_192_4 = get_range_count(arg, "192", 0.15, 0.20)
range_192_5 = get_range_count(arg, "192", 0.20, 1.00)

range_384_1 = get_range_count(arg, "384", 0, 0.05)
range_384_2 = get_range_count(arg, "384", 0.05, 0.10)
range_384_3 = get_range_count(arg, "384", 0.10, 0.15)
range_384_4 = get_range_count(arg, "384", 0.15, 0.20)
range_384_5 = get_range_count(arg, "384", 0.20, 1.00)

range_768_1 = get_range_count(arg, "768", 0, 0.05)
range_768_2 = get_range_count(arg, "768", 0.05, 0.10)
range_768_3 = get_range_count(arg, "768", 0.10, 0.15)
range_768_4 = get_range_count(arg, "768", 0.15, 0.20)
range_768_5 = get_range_count(arg, "768", 0.20, 1.00)

range_1536_1 = get_range_count(arg, "1536", 0, 0.05)
range_1536_2 = get_range_count(arg, "1536", 0.05, 0.10)
range_1536_3 = get_range_count(arg, "1536", 0.10, 0.15)
range_1536_4 = get_range_count(arg, "1536", 0.15, 0.20)
range_1536_5 = get_range_count(arg, "1536", 0.20, 1.00)

# print quintiles
with open(output_file, "w") as file:
    file.write("lookback forecast quantile total matches\n")
    file.write("----------------------------------------\n")
    file.write(f"{lookback} 12 0.00-0.05 {total_by_forecast} {range_12_1}\n")
    file.write(f"{lookback} 12 0.05-0.10 {total_by_forecast} {range_12_2}\n")
    file.write(f"{lookback} 12 0.10-0.15 {total_by_forecast} {range_12_3}\n")
    file.write(f"{lookback} 12 0.15-0.20 {total_by_forecast} {range_12_4}\n")
    file.write(f"{lookback} 12 0.20-1.00 {total_by_forecast} {range_12_5}\n")
    file.write("\n")
    file.write(f"{lookback} 24 0.00-0.05 {total_by_forecast} {range_24_1}\n")
    file.write(f"{lookback} 24 0.05-0.10 {total_by_forecast} {range_24_2}\n")
    file.write(f"{lookback} 24 0.10-0.15 {total_by_forecast} {range_24_3}\n")
    file.write(f"{lookback} 24 0.15-0.20 {total_by_forecast} {range_24_4}\n")
    file.write(f"{lookback} 24 0.20-1.00 {total_by_forecast} {range_24_5}\n")
    file.write("\n")
    file.write(f"{lookback} 48 0.00-0.05 {total_by_forecast} {range_48_1}\n")
    file.write(f"{lookback} 48 0.05-0.10 {total_by_forecast} {range_48_2}\n")
    file.write(f"{lookback} 48 0.10-0.15 {total_by_forecast} {range_48_3}\n")
    file.write(f"{lookback} 48 0.15-0.20 {total_by_forecast} {range_48_4}\n")
    file.write(f"{lookback} 48 0.20-1.00 {total_by_forecast} {range_48_5}\n")
    file.write("\n")
    file.write(f"{lookback} 96 0.00-0.05 {total_by_forecast} {range_96_1}\n")
    file.write(f"{lookback} 96 0.05-0.10 {total_by_forecast} {range_96_2}\n")
    file.write(f"{lookback} 96 0.10-0.15 {total_by_forecast} {range_96_3}\n")
    file.write(f"{lookback} 96 0.15-0.20 {total_by_forecast} {range_96_4}\n")
    file.write(f"{lookback} 96 0.20-1.00 {total_by_forecast} {range_96_5}\n")
    file.write("\n")
    file.write(f"{lookback} 192 0.00-0.05 {total_by_forecast} {range_192_1}\n")
    file.write(f"{lookback} 192 0.05-0.10 {total_by_forecast} {range_192_2}\n")
    file.write(f"{lookback} 192 0.10-0.15 {total_by_forecast} {range_192_3}\n")
    file.write(f"{lookback} 192 0.15-0.20 {total_by_forecast} {range_192_4}\n")
    file.write(f"{lookback} 192 0.20-1.00 {total_by_forecast} {range_192_5}\n")
    file.write("\n")
    file.write(f"{lookback} 384 0.00-0.05 {total_by_forecast} {range_384_1}\n")
    file.write(f"{lookback} 384 0.05-0.10 {total_by_forecast} {range_384_2}\n")
    file.write(f"{lookback} 384 0.10-0.15 {total_by_forecast} {range_384_3}\n")
    file.write(f"{lookback} 384 0.15-0.20 {total_by_forecast} {range_384_4}\n")
    file.write(f"{lookback} 384 0.20-1.00 {total_by_forecast} {range_384_5}\n")
    file.write("\n")
    file.write(f"{lookback} 768 0.00-0.05 {total_by_forecast} {range_768_1}\n")
    file.write(f"{lookback} 768 0.05-0.10 {total_by_forecast} {range_768_2}\n")
    file.write(f"{lookback} 768 0.10-0.15 {total_by_forecast} {range_768_3}\n")
    file.write(f"{lookback} 768 0.15-0.20 {total_by_forecast} {range_768_4}\n")
    file.write(f"{lookback} 768 0.20-1.00 {total_by_forecast} {range_768_5}\n")
    file.write("\n")
    file.write(f"{lookback} 1536 0.00-0.05 {total_by_forecast} {range_1536_1}\n")
    file.write(f"{lookback} 1536 0.05-0.10 {total_by_forecast} {range_1536_2}\n")
    file.write(f"{lookback} 1536 0.10-0.15 {total_by_forecast} {range_1536_3}\n")
    file.write(f"{lookback} 1536 0.15-0.20 {total_by_forecast} {range_1536_4}\n")
    file.write(f"{lookback} 1536 0.20-1.00 {total_by_forecast} {range_1536_5}\n")
