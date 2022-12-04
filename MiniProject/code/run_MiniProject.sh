#!/bin/sh
# Author: Bikem Pastine bp222@ic.ac.uk
# Script: run_MiniProject.sh.sh
# Desc: Run data manipulation, model building, plotting, and the creation of the final csv scripts
# Arguments: none
# Date: Nov 2022


echo -e "\nBegin running Miniprojct! \n"

Rscript --verbose data_massage.R #cleans data and produces a key for ID's and experiment atributes

#fitting the models
Rscript --verbose linear_model.R #runs linear model
Rscript --verbose quadratic_model.R #runs quadratic model
Rscript --verbose cubic_model.R # runs cubic model
Rscript --verbose gompertz_model.R #runs gompertz model

#producing the required csv
Rscript --verbose create_final_csv.R #produce the csv

#creating the figures
Rscript --verbose dougnut_two_sections.R #produce the doughnut plot 
Rscript --verbose violin_plot.R #produce the violin plot
Rscript --verbose plot_poor_gompertz.R # produce example plot of cubic better

#Compile the writeup
bash wordcount.sh # run script to get the wordcount
bash CompileLaTex.sh Writeup_Pastine.tex #run the actual LaTeX document 


echo -e "\nDone! \n"
#exit