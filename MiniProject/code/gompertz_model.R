# packages
library(dplyr)
library(minpack.lm) 

#load the base plotting function
source("global_functions.R")


#load your data
d <- readRDS("../data/clean_list.RData") #data is logged : this is what the model is expecting

#Define the model
gompertz_model <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering, 1990)
 return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}   

#Run the model
model_plot <- list() #define empty list to fill 
model_fit <- data.frame(matrix(ncol = 10, nrow = 0))
colnames(model_fit) <- c('ID', 'sample_size', 'AIC', 'r_max', 'K','N_0', 't_lag', 'fit_sucsess', 'R2', 'AICc')

set.seed(222)

for (i in 1:length(d)){

      # Empty data frame to fill with the resampling of starting values
      a <- data.frame(matrix(0,  ncol= 12))
      colnames(a) <- c('run', 'N_0_start', 'K_start', 'r_max_start','t_lag_start', 'AIC', 'r_max', 'K', 'N_0','t_lag', 'R2', 'AICc')
      
      
      for (j in 1:150){
            # Define the starting values
            N_0_start <- rnorm(1, mean=min(d[[i]]$PopBio) , sd=0.2)  #lowest population level as the start point
            K_start <- rnorm(1, mean= max(d[[i]]$PopBio), sd=5) #carrying capacity assumed to be highest population level
            r_max_start <- rnorm(1, mean= max(diff((d[[i]]$PopBio))/2), sd=0.01) #highest slope between two points used as first estimate of the growth rate
            t_lag_start <-rnorm(1, mean= d[[i]]$Time[which.max(diff(diff(d[[i]]$PopBio)))], sd=0.01)  # find last timepoint of lag phase


            #Run the model
            fit_gompertz <- tryCatch(nlsLM(PopBio ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), d[[i]], list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, K = K_start), lower=c(0,0,-Inf,-Inf)),
                                                error = function(e) return(NA) ) #getting fits for 90%
            
            
            #Fill model results into a dataframe for each resampling
            a[j,1] <- j
            a[j,2] <- N_0_start
            a[j,3] <- K_start
            a[j,4] <- r_max_start
            a[j,5] <- t_lag_start
            a[j,6] <- tryCatch(calc_AIC(fit_gompertz, d[[i]]$PopBio), error = function(e) return(NA))
            a[j,7] <- tryCatch(coef(fit_gompertz)["r_max"], error = function(e) return(NA))
            a[j,8] <- tryCatch(coef(fit_gompertz)["K"], error = function(e) return(NA))
            a[j,9] <- tryCatch(coef(fit_gompertz)["N_0"], error = function(e) return(NA))
            a[j,10] <- tryCatch(coef(fit_gompertz)["t_lag"], error = function(e) return(NA))          
            a[j,11] <- tryCatch(calc_R2(fit_gompertz, d[[i]]$PopBio ), error = function(e) return(NA))
            a[j,12] <- tryCatch(calc_AICc(fit_gompertz, d[[i]]$PopBio), error = function(e) return(NA))
            
      }
      
      # get the model results from the sampling that has the lowest AIC
      best_fit <- if (all(is.na(a$AICc))){a[1, ]} else {a[which.min(a$AICc),]}
    
      #Fill model results into a dataframe
      model_fit[i,1] <- d[[i]][1,]$ID
      model_fit[i,2] <- nrow(d[[i]]) #sample size 
      model_fit[i,3] <- best_fit$AIC
      model_fit[i,4] <- best_fit$r_max
      model_fit[i,5] <- best_fit$K
      model_fit[i,6] <- best_fit$N_0
      model_fit[i,7] <- best_fit$t_lag
      model_fit[i,8] <- if(is.na(best_fit$AIC) == TRUE){0}else{1} #did the model produce AIC values sucsessfully
      model_fit[i,9] <- best_fit$R2
      model_fit[i,10] <- best_fit$AICc

      #define timepoints to run the model on for plotting purposes
      timepoints <- seq(min(d[[i]]$Time), max(d[[i]]$Time), length.out=300)

      #run the model with given points 
      gompertz_points <- tryCatch(gompertz_model(
         t = timepoints, 
         r_max = best_fit$r_max,
         K = best_fit$K, 
         t_lag = best_fit$t_lag, 
         N_0 = best_fit$N_0), 
         error = function(e) return(rep(NA, length.out=10)))


      df1 <- data.frame(timepoints, gompertz_points) #save the data as a data.frame
      df1$model <- "Gompertz equation" #name the model
      names(df1) <- c("Time", "N", "model") # give the data titles

      #fill in the results to a list
      model_plot[[i]] <- df1

}

#Print to terminal how many fits were produced
paste("Number of models fit:", sum(model_fit[,8]),"/ 210")

#save the results
saveRDS(model_plot, file="../data/model_plot_data_gompertz.RData")
saveRDS(model_fit, file="../data/model_fit_gompertz.RData")



      