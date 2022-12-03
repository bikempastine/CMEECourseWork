#load libraries
library(dplyr)
library(ggplot2)
library(ggsci) # the colour for the plot


#read in model results csv
r <- read.csv( "../results/results_table.csv")


#keep the columns of interest
comp <- r %>% select('ID', 'Medium', 'Species', 'Temp', 'PopBio_units', 'linear_sample_size',
             'linear_AIC', 'linear_r_squared', 'linear_AICc',
             'quadratic_AIC', 'quadratic_r_squared', 'quadratic_AICc', 
             'cubic_AIC', 'cubic_r_squared', 'cubic_AICc',
             'gompertz_AIC', 'gompertz_R2', 'gompertz_AICc')

#remove cases where gompertz did not fit 
comp<- comp[complete.cases(comp),]


##Make ordered lists of the AICc values
#empty object to fill in upcoming loop
ordered_AICc <- list()

#loop to compare the aicc values for each model 
for(i in 1:nrow(comp)){
    x <- data.frame(cbind(rep(comp$ID[i],4), c('linear', 'quadratic', 'cubic', 'gompertz'),
                            c(comp$linear_AICc[i],comp$quadratic_AICc[i], comp$cubic_AICc[i], comp$gompertz_AICc[i])))
    x[,3] <- as.numeric(x[,3])
    ordered_AICc[[i]] <- x[order(x[,3]), ]
    ordered_AICc[[i]]$diff_AICc <- ordered_AICc[[i]][,3] - min(ordered_AICc[[i]][,3]) #difference between AICci and AICcbest
    ordered_AICc[[i]]$relative_likelihood <- exp(-ordered_AICc[[i]][,4]/2) #Relative likelihood
    ordered_AICc[[i]]$Akaike_weight <-ordered_AICc[[i]][,5]/sum(ordered_AICc[[i]][,5]) #Akaike weights

}


##Akaike weight
#make dataframe to fill with plausabilities of the best fit model bounded by probability bounds

#empty frames
highly_plausable <- data.frame(matrix(0, ncol=3))
colnames(highly_plausable) <- c('ID', 'model', 'Akaike_weight_top_model')

#fill the dataframe
for(i in 1:nrow(comp)){
  highly_plausable[i,1] <- ordered_AICc[[i]]$X1[1] #ID of data
  highly_plausable[i,2] <- ordered_AICc[[i]]$X2[1] #name of the top model
  highly_plausable[i,3] <- ordered_AICc[[i]]$Akaike_weight[1] #Alaike wieigt of the top model
}

#get the totals to annotate the graph with total number of growth curves
tots <- highly_plausable %>% group_by(model) %>% count()


#plot the results
p <- ggplot(highly_plausable, aes(model, Akaike_weight_top_model, fill = model))
p+ geom_violin(alpha= 0.3)+ 
   coord_flip()+ 
   geom_jitter(width=0.05, colour= 'black', alpha = 0.4, pch= 19, size= 0.4)+
   theme_minimal()+
   theme(legend.position='none', axis.text=element_text(size=9), axis.title.x = element_text(size = 9))+
   scale_fill_npg()+
   annotate(geom= 'text',label= paste('n =',tots$n), x= c(1.2,2.2,3.2,4.2), y= 0.45, size= 2.8)+
   labs(x='', y= 'Akaike weight distribution')


#save the graph to results
ggsave("../results/model_compare_violin.png", width = 9, height = 10, units = "cm")
