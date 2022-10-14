#!/bin/bash
# Author: Bikem bp222@ic.ac.uk
# Script: Merge two files to produce a third
# Arguments: 3 -> 2 files to be merged and the new path for the output
# Date: Oct 2022

if [ $# -eq 2 ]  #check if the number of arguments supplied is 2
then 
    if [[ "${1: -3}" == "${2: -3}" ]] #check if the file types are the same by comparing the final 3 characters of the file
    then
        echo "First file is $1, Second file is $2"
        echo "Please enter the filepath and name of the new merged file."
        read outputname
        echo 
        echo "Merged file will be saved as $outputname"
        echo
        cat $1 > $outputname #copy contents of file 1 to new file
        cat $2 >> $outputname  #add file 2 to the end of the newly created file 3, after file 1
        echo "Merged File:"
        cat $outputname
        echo
        echo "Merged!"
    else
        echo "Error: file types are different, please enter files of the same type."
        fi
else
    echo "Error: incorrect number of files supplied, please supply only two files to merge." 
    fi


#exit