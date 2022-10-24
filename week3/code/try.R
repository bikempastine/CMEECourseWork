# Script: try.R
# practicing the try keyword

doit <- function(x) {
    temp_x <- sample(x, replace = TRUE)
    if(length(unique(temp_x)) > 30){#take mean if number of unique values in the sample is over 30
        print(paste("Mean of this sample was:", as.character(mean(temp_x))))

    }
    else{
        stop("Couldn't calculate mean: too few unique values")
    }
}

set.seed(1345)
popn <- rnorm(50)
hist(popn)

# lapply(1:15, function(i) doit(popn)) #returns an error

result<- lapply(1:15, function(i) try(doit(popn), FALSE))
class(result)

## Use a loop to do the same
result <- vector("list", 15)
for(i in 1:15){
    result[[i]] <- try(doit(popn), FALSE)
}