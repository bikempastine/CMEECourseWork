% CMEECourseWork - Groupwork

# Author Name

Chuxinyao Wang

Bikem Pastine

Mingji Zhang

Prayoonrat Pasith

Sirui(Cici) Ye

# Brief description

Complete groupwork practicals for Python 1, R and Python 2

# Languages

iPython3, R, Bash

# Installation

No Installation needed. 

# Project structure and Usage

## Align DNA Sequences
Align_seqs_fasta.py
Align_seqs_better.py

Python command is written to align all the .fasta sequences from the Unix chapter. The first script take any two fasta sequences (in separate files) to be aligned as input. The second script have all the equally-best alignmentsrecorded and saved to the results directory in an appropriate file format 


## Missing Oaks Problem
Oaks_debugme.py
Python command is written to modify the script so that it excludes the header row (if it exists) in its search for oaks in a given dataset. Include the column headers (“Genus”, “species”) for the output of the program that just containing the names of oaks.

## Autocorrelation in Florida Weather
TAutoCorr.R
TAutoCorr.bib
TAutoCorr.tex
TAutoCorr.pdf

R command is written to answer the question: Are temperatures of one year significantly correlated with the next year (successive years), across years in a given location? We calculate the correlation between (n-1) pairs of years.Resuls and interpretation is present in a pdf document written in Latex.

## Tree Heights
get_TreeHeight.R
run_get_TreeHeight.sh

R command is written to take a csv file name from the command line (e.g., get_TreeHeight.R Trees.csv) to calculate tree heights and output the result to a file including the input file name in the output file name as InputFileName_treeheights.csv. 
Unix shell command is written called run_get_TreeHeight.sh that tests get_TreeHeight.R.


## Regression Analysis
PP_Regress.R

R command is written to analysis the relationship between prey and predator mass. The analysis is separated by the dataset's location field. The result is saved as a .csv file.

## Compare R and Python Vectorization
Vectorize1.py
Vectorize2.py
run_Vectorised.sh

Python command is written to implement the python version of Vectorize1.R and Vectorize2.R. The shell command is written to compares the computational speed of the four scripts. The shell script print the timings of the equivalent R and Python functions.
