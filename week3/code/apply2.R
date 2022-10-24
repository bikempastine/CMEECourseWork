## Script: apply2.R
## Demonstrates the use own functions within apply functions

SomeOperation <- function(v) { #returns 100* the matrix if the sum of a matrix is positive
    if (sum(v) > 0) {
        return (v * 100)
    } else{
        return (v) 
    }
}

m <- matrix(rnorm(1000), 100 , 100)
print(apply(m,1,SomeOperation))

print(m)