# Script: preallocate.R
# Demonstrates how pre-allocation of memmory can speed up R code

## By appending (no pre-allocation)
NoPrealloFun <- function(x) {
    a <- vector() #empty vector
    for (i in 1:x) {
        a <- c(a, i) #append i to existing vector 'a'
        #print(a)
        #print(object.size(a))
    }
}

print(system.time(NoPrealloFun(1000)))

## By pre-allocating
PreallocFun <- function(x) {
    a <- rep(NA, x) #vector of 'x' size, filled with NAs
    for (i in 1:x){
        a[i] <- i #assign 'i' into the 'i'th space
        #print(a)
        #print(object.size(a))
    }
}

print(system.time(PreallocFun(1000)))