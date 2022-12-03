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
#empty objects to fill in upcoming loop
ordered_AICc <- list()
best_model<- data.frame(matrix(NA, ncol=2))
colnames(best_model) <- c('ID', 'model')

#loop to compare the aicc values for each model 
for(i in 1:nrow(comp)){
    x <- data.frame(cbind(rep(comp$ID[i],4), c('linear', 'quadratic', 'cubic', 'gompertz'),
                            c(comp$linear_AICc[i],comp$quadratic_AICc[i], comp$cubic_AICc[i], comp$gompertz_AICc[i])))
    x[,3] <- as.numeric(x[,3])
    ordered_AICc[[i]] <- x[order(x[,3]), ]
    ordered_AICc[[i]]$diff_AICc <- ordered_AICc[[i]][,3] - min(ordered_AICc[[i]][,3]) #difference between AICci and AICcbest
    ordered_AICc[[i]]$relative_likelihood <- exp(-ordered_AICc[[i]][,4]/2) #Relative likelihood
    ordered_AICc[[i]]$Akaike_weight <-ordered_AICc[[i]][,5]/sum(ordered_AICc[[i]][,5]) #Akaike weights
    
    ~get a list of the best models by Akakie weight for each ID
    best_model[i,1] <- ordered_AICc[[i]]$X1[1]
    best_model[i,2] <- ordered_AICc[[i]]$X2[1]
}

#get a summery of the best model overall counts
best_m_counts <- best_model %>% group_by(model) %>% count()


# Compute percentages
best_m_counts$fraction <- best_m_counts$n / sum(best_m_counts$n )

# Compute the cumulative percentages (top of each rectangle)
best_m_counts$ymax <- cumsum(best_m_counts$fraction)

# Compute the bottom of each rectangle
best_m_counts$ymin <- c(0, head(best_m_counts$ymax, n=-1))

# Compute label position
best_m_counts$labelPosition <- (best_m_counts$ymax + best_m_counts$ymin) / 2

# Compute a good label
best_m_counts$label <- paste0(best_m_counts$model, "\n( ", format(round(best_m_counts$fraction*100, 1), nsmall = 1), "% )")



# Make the plot
ggplot(best_m_counts, aes(ymax=ymax, ymin=ymin, xmax=1, xmin=3, fill=model)) +
  geom_rect() +
  geom_text( x=4, aes(y=labelPosition, label=label), colour = 'black', size=2.5) + 
  annotate('text',x= -1, y=0.25 , label= 'Best fitting\nmodel', size =3, fontface = "bold")+
  scale_fill_npg()+
  coord_polar(theta="y") +
  xlim(c(-1, 4)) +
  theme_void() +
  theme(legend.position = "none")

#save the graph to results
ggsave("../results/model_compare_single_dougnut.png", width = 9, height = 9, units = "cm")

