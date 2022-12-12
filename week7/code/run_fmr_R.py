"""Runs fmr.R in python, expresses if the run was sucsessful, and prints the outputs on to the R console in the python console"""

import subprocess
p = subprocess.Popen("Rscript --verbose fmr.R > ../results/fmr_console.Rout 2> ../results/fmr_errFile.Rout", shell=True).wait()

# print if run is sucsessful
if p == 0:
    print("R code fmr.R sucsessfully run in python!\n")

print("Contents of the R console output: \n")

# open ouptput file and read lines and print to the console
a_file = open("../results/fmr_console.Rout")
lines = a_file. readlines()
for line in lines:
    print(line)
a_file. close()