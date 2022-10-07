#!/bin/bash
# CODE: script to compile pdf

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
