#!/bin/bash
# Author: Bikem bp222@ic.ac.uk
# Script: compile LaTeX files
# Arguments: 1 -> LaTeX file
# Date: Oct 2022

#allow imput to be full filename including extension
filename=`echo "${1%.*}"`
echo "$filename"

#Compile file
pdflatex $filename.tex
bibtex $filename
pdflatex $filename.tex
pdflatex $filename.tex

#move output to the results section and open file
mv $filename.pdf ../results/$filename.pdf
evince ../results/$filename.pdf &


##Cleanup
rm *.aux
rm *.log
rm *.bbl
rm *.blg

#exit
