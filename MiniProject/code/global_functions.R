
# R2 function 
calc_R2 <- function(model_input, data_input ){    
    RSS <- sum(resid(model_input)^2) # Residual sum of squares
    TSS <- sum((data_input - mean(data_input))^2) # Total sum of squares
    R2 <- 1 - (RSS/TSS) # R-squared value
    
    return(R2)
}

#AIC function
calc_AIC <- function(model_input, data_input){
    n <- length(data_input) #set sample size
    p_n<- length(coef(model_input)) # get number of parameters
    RSS <- sum(resid(model_input)^2) # Residual sum of squares
    AIC <- n + 2 + n * log((2 * pi) / n) + n * log(RSS) + 2 * p_n
    return(AIC)
}

#AICc function
calc_AICc <- function(model_input, data_input){
    n <- length(data_input) #set sample size
    p_n<- length(coef(model_input)) # get number of parameters
    RSS <- sum(resid(model_input)^2) # Residual sum of squares
    AIC <- n + 2 + n * log((2 * pi) / n) + n * log(RSS) + 2 * p_n
    AICc <- AIC + (2 * p_n * (p_n + 1))/(n - p_n - 1)
    return(AICc)
}

