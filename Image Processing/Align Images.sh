#!/bin/bash

# Specify the directory where your folders are located
directory="/mnt/hgfs/work/Processed_PIB/3.Normalise"
standard="/home/jamie/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz"
# Specify the output directory where aligned images will be saved
output_directory="/mnt/hgfs/work/Processed_PIB/4.MNI_Registered"

# Iterate over files in the input directory
for file in "$directory"/*; do
    # Extract file name without the path
    filename=$(basename "$file")

    # Extract file extension
    extension="${filename##*.}"

    # Remove extension from filename
    filename_no_ext="${filename%.*}"

    flirt -in "$file" -ref $standard -cost corratio -searchcost corratio -out "$output_directory/${filename_no_ext}.$extension"
done