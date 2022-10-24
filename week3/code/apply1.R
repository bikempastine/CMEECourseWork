# Script: apply1.R
# Learning about the apply family of functions in R

## Build a random matrix
m <- matrix(rnorm(100), 10, 10)

## Take the means of each row
RowMeans <- apply(m, 1, mean)
print(RowMeans)

## Take the variance of each row
RowVars <- apply(m, 1, var)
print(RowVars)

## Take the means of each column
ColMeans <- apply(m,2,mean)
print(ColMeans)