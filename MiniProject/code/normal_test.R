# Fitting a linear model to the data
#load your data
d <- readRDS("../data/clean_list.RData")


no_normal_logged <- function(x){
    residual_normality_logged <- list()

    for (i in 1:length(d)){
        m<- (lm(data=d[[i]], PopBio ~ poly(Time, x, raw =T)))
        residual_normality_logged[[i]]<- resid(m)   
    }

    n_logged <- data.frame(matrix(ncol = 2, nrow = 0))

    for (i in 1:length(d)){
        a<- shapiro.test(residual_normality_logged[[i]])
        n_logged[i, 1] <- i
        n_logged[i, 2] <- if(a[2] < 0.05)(1)else(0) #zero if normal, one if not normal
        }

return(sum(n_logged[,2]))
}

no_normal <- function(x){
    residual_normality_logged <- list()

    for (i in 1:length(d)){
        m<- (lm(data=d[[i]], exp(PopBio) ~ poly(Time, x, raw =T)))
        residual_normality_logged[[i]]<- resid(m)   
    }

    n_nl <- data.frame(matrix(ncol = 2, nrow = 0))

    for (i in 1:length(d)){
        a<- shapiro.test(residual_normality_logged[[i]])
        n_nl[i, 1] <- i
        n_nl[i, 2] <- if(a[2] < 0.05)(1)else(0) #zero if normal, one if not normal
        }

return(sum(n_nl[,2]))
}

#number of non-normal residiuals
l_logged <- no_normal_logged(1)
q_logged <- no_normal_logged(2)
c_logged <- no_normal_logged(3)


l_nl <- no_normal(1)
q_nl <- no_normal(2)
c_nl <- no_normal(3)

#more normal residuals 
non_normal_count <- rbind(c('linear',l_nl, l_logged),
                     c('quadratic',q_nl, q_logged),
                     c('cubic',c_nl, c_logged))


colnames(non_normal_count) <- c('model', 'linear_scale', 'log_transformed')

write.csv(non_normal_count, file= '../results/residual_normality.csv')


#commented out for time, one number in report 83% produced with this code
# #######Residiuals Gompertz

# # packages
# library(dplyr)
# library(minpack.lm) 
# library(ggplot2)
# #load the base plotting function
# source("../code/global_functions.R")


# #load your data
# d <- readRDS("../data/clean_list.RData") #data is logged : this is what the model is expecting

# #Define the model
# gompertz_model <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering, 1990)
#  return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
# }   

# #Run the model
# model_plot <- list() #define empty list to fill 
# model_fit <- data.frame(matrix(ncol = 4, nrow = 0))
# colnames(model_fit) <- c('ID',  'fit_sucsess', 'AICc', 'normal')

# set.seed(222)

# for (i in 1:length(d)){

#       # Empty data frame to fill with the resampling of starting values
#       a <- data.frame(matrix(0,  ncol= 3))
#       colnames(a) <- c('run', 'AICc', 'shap_result')
      
      
#       for (j in 1:150){
#             # Define the starting values
#             N_0_start <- rnorm(1, mean=min(d[[i]]$PopBio) , sd=0.2)  #lowest population level as the start point
#             K_start <- rnorm(1, mean= max(d[[i]]$PopBio), sd=5) #carrying capacity assumed to be highest population level
#             r_max_start <- rnorm(1, mean= max(diff((d[[i]]$PopBio))/2), sd=0.01) #highest slope between two points used as first estimate of the growth rate
#             t_lag_start <-rnorm(1, mean= d[[i]]$Time[which.max(diff(diff(d[[i]]$PopBio)))], sd=0.01)  # find last timepoint of lag phase


#             #Run the model
#             fit_gompertz <- tryCatch(nlsLM(PopBio ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), d[[i]], list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, K = K_start), lower=c(0,0,-Inf,-Inf)),
#                                                 error = function(e) return(NA) ) #getting fits for 90%
            
            
#             #Fill model results into a dataframe for each resampling
#             resids_per_run <- tryCatch(resid(fit_gompertz), error = function(e) return(NA))
#             shap_result<- tryCatch(shapiro.test(resids_per_run),error = function(e) return(NA))


#             a[j,1] <- j       
#             a[j,2] <- tryCatch(calc_AICc(fit_gompertz, d[[i]]$PopBio), error = function(e) return(NA))
#             a[j,3] <- tryCatch(shap_result[2],error = function(e) return(NA))
            
#       }
      
#       # get the model results from the sampling that has the lowest AIC
#       best_fit <- if (all(is.na(a$AICc))){a[1, ]} else {a[which.min(a$AICc),]}
    
#       #Fill model results into a dataframe
#       model_fit[i,1] <- d[[i]][1,]$ID
#       model_fit[i,2] <- if(is.na(best_fit$AIC) == TRUE){0}else{1}
#       model_fit[i,3] <- best_fit$AICc
#       model_fit[i,4] <- tryCatch(if(best_fit$shap_result < 0.05)(1)else(0), error = function(e) return(NA) )

# }

# #Print to terminal how many fits were produced
# paste("Number of models fit:", sum(model_fit[,2]),"/ 210")

# 1 - sum(model_fit$normal, na.rm=TRUE)/210
