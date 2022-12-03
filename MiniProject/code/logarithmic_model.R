# packages
library(dplyr)
library(minpack.lm) 
library(ggplot2)

#load your data
d <- readRDS("../data/clean_list.RData") ######ISSUE!!!!! Should be in linear scale, right now data is logged. 

#Define the model
logistic_model <- function(t, r_max, K, N_0){ # The classic logistic equation
 return((N_0 * K * (r_max * t)/(K + N_0 * ((r_max * t) - 1))))
}

#Run the model
model_plot <- list() #define empty list to fill 
model_fit <- data.frame(matrix(ncol = 4, nrow = 0))
colnames(model_fit) <- c('ID', 'AIC', 'sample_size', 'fit_sucsess')

for (i in 1:length(d)){
      # Define the starting values
      N_0_start <- min(d[[i]]$PopBio) #lowest population level as the start point
      K_start <- max(d[[i]]$PopBio) #carrying capacity assumed to be highest population level
      r_max_start <- rnorm(1, mean=max(diff((d[[i]]$PopBio))/2) , sd=2)  #sample arround my estimate, sd = 2 #max(diff((d[[i]]$PopBio))/2) 
      
            
      #Run the model
      #added lower bound of zero  for biological meaning
      fit_logistic <- tryCatch(nlsLM(PopBio ~ logistic_model(t = Time, r_max, K, N_0), d[[i]], list(r_max=r_max_start, N_0 = N_0_start, K = K_start), lower=c(0,0,0)),
                        error = function(e) print(NA) )

      #Fill model results into a dataframe
      model_fit[i,1] <- d[[i]][1,]$ID
      model_fit[i,2] <- tryCatch(AIC(fit_logistic), error = function(e) print(NA))
      model_fit[i,3] <- nrow(d[[i]]) #sample size 
      model_fit[i,4] <- if(is.na(fit_logistic) == TRUE){0}else{1}
    

      #define timepoints to run the model on for plotting purposes
      timepoints <- seq(min(d[[i]]$Time), max(d[[i]]$Time), length.out=300)

      #run the model with given points 
      logistic_points <- tryCatch(logistic_model(
         t = timepoints, 
         r_max = coef(fit_logistic)["r_max"], 
         K = coef(fit_logistic)["K"], 
         N_0 = coef(fit_logistic)["N_0"]), error = function(e) print(rep(NA, length.out=10)))

model_fit
      df1 <- data.frame(timepoints, logistic_points) #save the data as a data.frame
      df1$model <- "Logistic equation" #name the model
      names(df1) <- c("Time", "N", "model") # give the data titles

      #fill in the results to a list
      model_plot[[i]] <- df1
      
            
}

sum(model_fit[,4])



#load the base plotting function
source("plotting.R")

#save the results and add the model fit line to the plot, with text containing info about the graphs
pdf(width = 12, height = 8, "../results/log_model.pdf")
for (ID in 1:length(d)){
      a <- plot_by_id(d, ID)
      a <- if(model_fit[ID,4] == 1){a <- a + geom_line(data = model_plot[[ID]], aes(x = Time, y = N, col = model), size = 1)+  
                                             annotate("text", x = Inf, y = Inf, label = paste("AIC:", model_fit[ID,2]), vjust = 25, hjust = 1)}else{a}
      print(a)
}
dev.off()