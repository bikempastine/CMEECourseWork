# Script: Vectorize1.R
# sums all elements of a matrix

m<- matrix(runif(1000000), 1000, 1000)


SumAllElements <- function(m){
    Dimentions <- dim(m)
    Tot <- 0
    for (i in 1:Dimentions[1]) {
        for (j in 1:Dimentions[2]){
            Tot <- Tot + m[i,j]
        }
    }
    return(Tot)
}

print("Using loops, the time taken is:")
print(system.time(SumAllElements(m)))

print("Using the in-built vectorised function, the time taken is:")
print(system.time(sum(m)))