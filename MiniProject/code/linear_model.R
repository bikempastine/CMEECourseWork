#load libraries
source("global_functions.R")
 
# Fitting a linear model to the data
#load your data
d <- readRDS("../data/clean_list.RData")

model_plot <- list() #empty list to fill with model predictions for future plotting
model_fit <- data.frame(matrix(ncol = 7, nrow = 0)) #dataframe to store your results from the linear model, each row is another curve
colnames(model_fit) <- c('ID', 'AIC', 'intercept', 'polly1', 'sample_size', 'r_squared', 'AICc')

residual_normality <- list()

for (i in 1:length(d)){
    m<- (lm(data=d[[i]], PopBio ~ Time))

    model_fit[i,1] <- d[[i]][1,]$ID #ID
    model_fit[i,2] <- calc_AIC(m, d[[i]]$PopBio) #AIC
    model_fit[i,3] <- m$coefficients[1] #Intercept
    model_fit[i,4] <- m$coefficients[2] #polly1
    model_fit[i,5] <- nrow(d[[i]]) #sample size
    model_fit[i,6] <- calc_R2(m, d[[i]]$PopBio) #r_squared
    model_fit[i,7] <- calc_AICc(m, d[[i]]$PopBio) # AICc


    #define timepoints to run the model on for plotting purposes
    timepoints <- seq(min(d[[i]]$Time), max(d[[i]]$Time), length.out=300) #points for the graph, 10
    time_df <- data.frame(Time = timepoints) #as data frame to be used in predict lm, timepoints set to time as the names need to be the same between this and the og data

    model_plot[[i]] <- data.frame(cbind(d[[i]][1,]$ID,timepoints, predict(m, time_df))) #run the prediction of the model and save in a list
    colnames(model_plot[[i]])<- c("ID", "Time", "PopBio")
}


#save the results
saveRDS(model_plot, file="../data/model_plot_data_linear.RData")
saveRDS(model_fit, file="../data/model_fit_linear.RData")
