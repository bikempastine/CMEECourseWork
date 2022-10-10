#!/bin/bash
# Author: Bikem bp222@ic.ac.uk
# Script: Merge two files to produce a third
# Arguments: 3 -> 2 files to be merged and the new path for the output
# Date: Oct 2022

if [ $# -ne 3 ] #check if the number of arguments supplied is 3
then 
#return this message if incorrect number of files are supplied
    echo "Incorrect number of files supplied. Please supply the paths for the two files to be merged and the desired name and path of the output file." 
else
    echo "First file is $1, Second file is $2"
    echo "Merged file is saved as $3"
    cat $1 > $3 #copy contents of file 1 to new file
    cat $2 >> $3 #add file 2 to the end of the newly created file 3, after file 1
    echo "Merged File:"
    cat $3 
    fi


#exit