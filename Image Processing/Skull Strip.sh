#!/bin/bash

# Specify input and output directories
input_dir="/mnt/hgfs/work/Processed_PIB/1.Mean_AVG_Smooth"
output_dir1="/mnt/hgfs/work/Processed_PIB/2.Skull_Strip/1.TEMP"
output_dir2="/mnt/hgfs/work/Processed_PIB/2.Skull_Strip/2.FINAL"

# Iterate over files in the input directory
for file in "$input_dir"/*; do
    # Extract file name without the path
    filename=$(basename "$file")

    # Extract file extension
    extension="${filename##*.}"

    # Remove extension from filename
    filename_no_ext="${filename%.*}"

    # Run bet command
    bet "$file" "$output_dir1/${filename_no_ext}.$extension" -f 0.5 -g 0.1

    # Run mri_synthstrip command
    mri_synthstrip -i "$output_dir1/${filename_no_ext}.$extension" -o "$output_dir2/${filename_no_ext}.$extension" -b 4
done
