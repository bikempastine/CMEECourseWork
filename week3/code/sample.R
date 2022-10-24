## Script: sample.R

#######Functions##########

## Take the sample of size 'n' from a population 'popn' and return its mean
myexperiment <- function(popn, n) {
    pop_sample <- sample(popn, n , replace = FALSE)
    return(mean(pop_sample))
}

## Calculate means using a FOR loop on a vector without preallocation
loopy_sample1 <- function(popn,n,num){
    result1<- vector()
    for(i in 1:num){
        result1<- c(result1, myexperiment(popn, n))
    }
    return(result1)
}

## Run 'num' iterations of the experiment using FOR loop on vector with preallocation
loopy_sample2 <- function(popn, n, num) {
    result2 <- vector(,num) #preallocate
    for(i in 1:num){
        result2[i] <- myexperiment(popn,n)
    }
    return(result2)
}

## Run "num" iterations of the experiment using a FOR loop on a list with preallocation
loopy_sample3<- function(popn, n, num){
    result3<- vector('list', num) #preallocate 
    for(i in 1:num){
        result3[[i]]<- myexperiment(popn,n)
    }
    return(result3)
}

## Use vectorisation with lapply
lapply_sample <- function(popn, n, num){
    result4 <- lapply(1:num, function(i) myexperiment(popn, n))
    return(result4)
}

## Use vectorisation wih sapply
sapply_sample <- function(popn, n, num){
    result5<- sapply(1:num, function(i) myexperiment(popn, n ))
    return(result5)
}

#######Generate a population########
set.seed(12345)
popn <- rnorm(10000)
hist(popn)

n<- 100
num<- 10000

#######Running and time different functions##########

print("Using loops without preallocation on a vector:")
print(system.time(loopy_sample1(popn, n, num)))

print("Using loops with preallocation on a vector:")
print(system.time(loopy_sample2(popn, n, num)))

print("Using loops with preallocation on a list:")
print(system.time(loopy_sample3(popn, n, num)))

print("Using the vectorised sapply function on a list:")
print(system.time(sapply_sample(popn, n, num)))

print("Using the vectorised lapply function on a list:")
print(system.time(lapply_sample(popn, n, num)))