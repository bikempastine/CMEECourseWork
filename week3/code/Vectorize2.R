# Runs the stochastic Ricker equation with gaussian fluctuations

rm(list = ls())

stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{

  N <- matrix(NA, numyears, length(p0))  #initialize empty matrix

  N[1, ] <- p0

  for (pop in 1:length(p0)) { #loop through the populations

    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr, pop] <- N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K)+ rnorm(1, 0, sigma)) # add one fluctuation from normal distribution
    
     }
  
 }
 return(N)

}


# Now write another function called stochrickvect that vectorizes the above to
# the extent possible, with improved performance: (currently sme speed or slower :( )

stochrickvect<- function(x, p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{
  N <- matrix(NA, numyears, length(p0)) 
  N[1, ] <- p0

  recurssive <- function(x){
    for (yr in 2:numyears){# loop through years, can't get rid of this becuase uses previous val
      x[yr] <- x[yr-1] * exp(r * (1 - x[yr - 1] / K)+ rnorm(1, 0, sigma)) # add one fluctuation from normal distribution
    }
    return(x)}

  test_val <- apply(N, 2, recurssive)
  return(test_val)

  }
 

  
print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrickvect()))
