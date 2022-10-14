#!/bin/bash
# Author: Bikem bp222@ic.ac.uk
# Script: Substitute the commas in files for spaces and saves csv as txt file
# Arguments: 1 -> file path for folder holding temperature csv files
# Date: Oct 2022


if [ -d "$1" ] #check if argument suplied is a directory
then 
    for FILE in $1/*.csv #run for all files in the spesified file path with a csv file path
        do 
        echo "Converting $FILE to .txt file" #print file names that will be converted
        cat $FILE | tr "," " " >> "${FILE%.csv}.txt"; #for each file replace commas with spaces and save file with txt file path rathr than csv path
        mv "${FILE%.csv}.txt" ../results
    done
    echo
    echo "Files converted and saved in results!"
else
    echo "Error: incorrect argument supplied. Please enter the directory path containing .csv files to be converted." #if argument is not a directory then return this message
fi


#exit