#!/bin/bash
# Author: Bikem bp222@ic.ac.uk
# Script: Substitute the tabs in files for commas and saves as csv
# Arguments: 1 -> txt file
# Date: Oct 2022

if [ $# -eq 1 ] && [[ $1 == *.txt ]] #check if only one argument is suplied and is a txt file
then 
    echo "Creating a comma delimited version of $1 ..."
    cat $1 | tr -s "/t" "," >> $1.csv #change tabs to commas and save as csv 
    echo "Done!"
else
    echo "Please supply one .txt file for conversion into .csv"
    
    fi


#exit