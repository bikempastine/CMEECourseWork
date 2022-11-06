rm(list = ls())

stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{
    N<- matrix(NA, numyears, length(p0))
    N[1,]<- p0
    
    for (x in 2:numyears){
        N[x, ] <- N[x-1, ] * exp(r * (1 - N[x-1,] / K)+ rnorm(1, 0, sigma))
    }


    return(N)
}



stochrick(numyears=10)

print(system.time(res2<-stochrick()))

library(data.table)

x<- 1:5
shift(x, n=1, fill=NA, type="lag")

N<- matrix(NA, 10, 1)
N[1,]<- runif(1, .5, 1.5)
N[2,]<- 3

trial<- function(data){
    data<- shift(data, n=1, fill=NA, type="lag")+ 1
    return(data)
}
function(N){
    shift(N, fill=0, type='lag') * exp(r * (1 - shift(N, fill=0, type='lag') / K)+ rnorm(1, 0, sigma))
}


N + shift(N, fill=0, type='lag')

trial(data = N)

N[1,]+ shift(N, n=1, fill=0, type="lag")[2]