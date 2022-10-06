#!/bin/bash
# Author: Bikem bp222@ic.ac.uk
# Script: Substitute the tabs in files for commas
# Script: saves txt as csv
# Arguments: 1 -> txt file
# Date: Oct 2022

echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "/t" "," >> $1.csv
echo "Done!"


#exit