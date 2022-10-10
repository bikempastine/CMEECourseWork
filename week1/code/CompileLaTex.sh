#!/bin/bash
# Author: Bikem bp222@ic.ac.uk
# Script: compile LaTeX files
# Arguments: 1 -> LaTeX file
# Date: Oct 2022

filename=`echo "${1%.*}"`
echo "$filename"

pdflatex $filename.tex
bibtex $filename
pdflatex $filename.tex
pdflatex $filename.tex
evince $filename.pdf &

##Cleanup
rm *.aux
rm *.log
rm *.bbl
rm *.blg

#exit