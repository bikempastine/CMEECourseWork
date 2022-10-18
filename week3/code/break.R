#!/usr/bin/Rscript
#Breaking out of loops

i<- 0 #initialising i

while(i < Inf){
    if (i == 10){
        break
    }else{
        cat("i equals", i, "\n")
        i <- i +1 #updating i to the next itteration 
    }
}