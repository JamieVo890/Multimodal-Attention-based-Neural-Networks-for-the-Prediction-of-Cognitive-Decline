#!/bin/bash

# This script is used to run FSL flirt to align images to MNI space. 

# Directory of PIB PET images
directory="/mnt/hgfs/work/Processed_PIB/3.Normalise"
# Directory of MNI template
standard="/home/jamie/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz"
# MNI aligned images output directory
output_directory="/mnt/hgfs/work/Processed_PIB/4.MNI_Registered"


for file in "$directory"/*; do
    filename=$(basename "$file")

    extension="${filename##*.}"

    filename_no_ext="${filename%.*}"

    flirt -in "$file" -ref $standard -cost corratio -searchcost corratio -out "$output_directory/${filename_no_ext}.$extension"
done
