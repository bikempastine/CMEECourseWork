#!/bin/bash
# Author: Bikem bp222@ic.ac.uk
# Script: Substitute the tabs in files for commas and saves as csv
# Arguments: 1 -> txt file
# Date: Oct 2022

if [[ $1 == *.txt ]] #check if argument suplied is a txt file
then 
    echo "Creating a comma delimited version of $1 ..."
    cat $1 | tr -s "/t" "," >> $1.csv #change tabs to commas and save as csv 
    echo "Done!"
else
    echo "no .txt file supplied. Please supply .txt file for conversion to .csv" #if argument is not a txt file then return this message
fi


#exit