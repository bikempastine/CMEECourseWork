#!/usr/bin/Rscript
#Skipping itterations of a loop

for (i in 1:10) { #for 1 through 10
    if ((i %% 2) == 0) #if i is divisable by two
     next # skip that itteration 
    print(i) # print i otherwise
}