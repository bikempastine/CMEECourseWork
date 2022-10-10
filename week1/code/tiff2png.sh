#!/bin/bash
# Author: Bikem bp222@ic.ac.uk
# Script: Change tiff files to png files
# Arguments: 0
# Date: Oct 2022

for f in *.tiff;
    do 
    echo "Converting $f";
    convert "$f"  "$(basename "$f" .tiff).png";
    done

#exit