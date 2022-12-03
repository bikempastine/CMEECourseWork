#load libraries
library(dplyr)
library(ggplot2)
library(tidyr)


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
highly_plausable <- data.frame(matrix(0, ncol=5))
colnames(highly_plausable) <- c('ID', 'model', 'Akaike_weight_top_model', 
                        'less_0.99', 'greater_0.99')

#fill the dataframe
for(i in 1:nrow(comp)){
  highly_plausable[i,1] <- ordered_AICc[[i]]$X1[1] #ID of data
  highly_plausable[i,2] <- ordered_AICc[[i]]$X2[1] #name of the top model
  highly_plausable[i,3] <- ordered_AICc[[i]]$Akaike_weight[1] #Alaike wieigt of the top model
  highly_plausable[i,4] <- if(ordered_AICc[[i]]$Akaike_weight[1] < 0.99 )(1)else(0) #less than to 99%
  highly_plausable[i,5] <- if(ordered_AICc[[i]]$Akaike_weight[1] >= 0.99)(1)else(0) #more than 99%
}

#take highly plausable: for further analysis
A_weights <- highly_plausable[,1:4]
key <- readRDS("../data/key.RData")
merged_A_weights <- merge(key, A_weights, by = 'ID')
write.csv(merged_A_weights, "../data/Alaike_weigth_top.csv")

highly_plausable %>% filter(model == 'cubic')

#number of best fits bt confience bound
model_compare <- highly_plausable %>% group_by(model) %>% summarize(sum_less_0.99= sum(less_0.99), sum_99 = sum(greater_0.99))
colnames(model_compare) <- c('model',"<99%", ">99%")

model_compare[,2]+model_compare[,3]
#total best fits by model
just_counts <- highly_plausable %>% group_by(model)%>%count()

#pivot the model_compae dataframe into long from for plotting
long <- model_compare %>%
  pivot_longer(
    cols = `<99%`:`>99%`, 
    names_to = "confidence",
    values_to = "count",
    values_transform = ~ as.numeric(gsub(",", "", .x))
  )


# For plotting Compute the cumulative percentages (top of each rectangle)
long$ymax <- cumsum(long$count)
just_counts$ymax <- cumsum(just_counts$n)

# For plotting Compute the bottom of each rectangle
long$ymin <- c(0, head(long$ymax, n=-1))
just_counts$ymin <- c(0, head(just_counts$ymax, n=-1))

# For plotting Compute the cumulative percentages (top of each rectangle)
just_counts$lab_pos <- (just_counts$ymax + just_counts$ymin)/2

# Compute a good label
just_counts$label <- paste0(just_counts$model, "\n( ", format(round((just_counts$n/sum(just_counts$n))*100, 1), nsmall = 1), "% )")


colours <- c('#FF3333','#ED0000','#6B8CD4','#5172BA', '#8F48A2','#5C156F', '#4DA396','#33897C')
# Make the plot
ggplot(long, aes(ymax=ymax, ymin=ymin, xmax=1, xmin=3)) +
  geom_rect(fill= colours) +
  geom_rect(data= just_counts, aes(ymax=ymax, ymin=ymin, xmax=1, xmin=3 ), alpha= 0.001, colour= 'white')+
  geom_text(data =just_counts, x=3.8, aes(y=lab_pos, label=label), colour = 'black', size=2.5) + 
  annotate('text',x= -1, y=0.25 , label= 'Best fitting\nmodel', size =3, fontface = "bold")+
  coord_polar(theta="y") +
  xlim(c(-1, 4)) +
  theme_void() +
  theme(legend.position = "none")

#save the graph to results
ggsave("../results/model_compare_single_dougnut_99.png", width = 9, height = 9, units = "cm")