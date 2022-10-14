#!/bin/bash
# Author: Bikem bp222@ic.ac.uk
# Script: Count the number of lines in a file
# Arguments: 1 -> file
# Date: Oct 2022

if [ $# -eq 1 ] #check if an argument is supplied
then 
    NumLines=`wc -l < $1`  #count number of lines in the file suplied in the argument
    echo "The file $1 has $NumLines lines" #print the number of lines in file
else

    echo "incorrect number of files supplied. Please supply one file at a time to count the number of lines." #if argument is not supplied print this message
fi


#exit
