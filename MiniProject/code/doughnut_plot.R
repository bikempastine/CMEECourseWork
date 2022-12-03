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
highly_plausable <- data.frame(matrix(0, ncol=7))
colnames(highly_plausable) <- c('ID', 'model', 'Akaike_weight_top_model', 
                        'less_0.5', 'greater_0.5','greater_0.95','greater_0.99')

#fill the dataframe
for(i in 1:nrow(comp)){
  highly_plausable[i,1] <- ordered_AICc[[i]]$X1[1] #ID of data
  highly_plausable[i,2] <- ordered_AICc[[i]]$X2[1] #name of the top model
  highly_plausable[i,3] <- ordered_AICc[[i]]$Akaike_weight[1] #Alaike wieigt of the top model
  highly_plausable[i,4] <- if(ordered_AICc[[i]]$Akaike_weight[1] <= 0.5 )(1)else(0) #less than or equal to 50%
  highly_plausable[i,5] <- if(ordered_AICc[[i]]$Akaike_weight[1] > 0.5 && ordered_AICc[[i]]$Akaike_weight[1] < 0.95)(1)else(0) #more than 50% but less than 0.95
  highly_plausable[i,6] <- if(ordered_AICc[[i]]$Akaike_weight[1] > 0.95 && ordered_AICc[[i]]$Akaike_weight[1] < 0.99)(1)else(0) #more than  95%
  highly_plausable[i,7] <- if(ordered_AICc[[i]]$Akaike_weight[1] > 0.99)(1)else(0) #more than 99%
}

#number of best fits bt confience bound
model_compare <- highly_plausable %>% group_by(model) %>% summarize(sum_lessthan_50= sum(less_0.5), sum_50 = sum(greater_0.5), sum_95 = sum(greater_0.95), sum_99 = sum(greater_0.99))
colnames(model_compare) <- c('model',"<50%","50-95%", "95-99%", ">99%")

#total best fits by model
just_counts <- highly_plausable %>% group_by(model)%>%count()

#pivot the model_compae dataframe into long from for plotting
long <- model_compare %>%
  pivot_longer(
    cols = `<50%`:`>99%`, 
    names_to = "confidence",
    values_to = "count",
    values_transform = ~ as.numeric(gsub(",", "", .x))
  )

#Arrange long by size in each group
long <- long %>% group_by(model) %>% arrange(desc(count), .by_group= TRUE)

# For plotting Compute the cumulative percentages (top of each rectangle)
long$ymax <- cumsum(long$count)

# For plotting Compute the bottom of each rectangle
long$ymin <- c(0, head(long$ymax, n=-1))


# For plotting Compute the cumulative percentages (top of each rectangle)
long$lab_pos <- (long$ymax + long$ymin)/2


#create the labels
long$label_outside <- paste0(long$confidence, '\n(',format(round(long$count/sum(long$count) * 100, 1), nsmall=1), '% )' ) #split up
just_counts$label_inside <-  paste0(just_counts$model, "\n(", format(round(just_counts$n/sum(just_counts$n) * 100, 1), nsmall=1), '% )') #overall

just_counts$ymin<- c(long$ymin[1] ,long$ymin[5], long$ymin[9] ,long$ymax[13])
just_counts$ymax<- c(long$ymin[4] ,long$ymin[8], long$ymin[12] ,long$ymax[16])
just_counts$lab_pos <- (just_counts$ymin + just_counts$ymax)/2
# Plot the results

ggplot(long, aes(y=count)) +
  
  # Bars
  #inside bar : summerative of all models
  geom_bar(aes(x=2),stat="identity", width=1, colour = c('white',rep('#ED0000',3),'white',rep('#5172BA',3),'white',rep('#5C156F',3),'white',rep('#33897C',3)),
          fill=c(rep('#ED0000',4), rep("#5172BA", 4), rep("#5C156F",4), rep("#33897C",4))) +
  #outside bar : broken down by confidence
  geom_bar(aes(x=3),stat="identity", width=1, colour= 'white', fill=c('#ED0000', '#FF3333', '#FF6666','#FF9999','#5172BA','#6B8CD4','#84A5ED','#9EBFFF','#5C156F','#8F48A2','#8F48A2','#8F48A2','#33897C','#4DA396','#4DA396','#4DA396')) +
  #bars to make doughnut
  geom_bar(aes(x=0), stat="identity", width= 1, fill= 'white', colour= 'white')+
  geom_bar(aes(x=1), stat="identity", width= 1, fill= 'white', colour= 'white')+
  #outside bars for annotation
  geom_bar(aes(x=4), stat="identity", width= 1, fill= 'white', colour= 'white')+
  geom_bar(aes(x=5), stat="identity", width= 1, fill= 'white', colour= 'white')+
  
  #make into a circle
  coord_polar("y", start=0)+
  #get rid of axis etc.
  theme_void() +

  # labels inside doughnut
  #linear model annotate
  annotate("text", x=0.8, y=just_counts$lab_pos[3]-4.5, label= just_counts$label_inside[3], colour= 'black',size=1.8, fontface = "bold")+
  #quadratic
  annotate("text", x=0.9, y=just_counts$lab_pos[4]+2, label= just_counts$label_inside[4], colour= 'black',size=1.8,fontface = "bold")+
  #cubic
  annotate("text", x=0.7, y= just_counts$lab_pos[1]+25, label= just_counts$label_inside[1], colour= 'black',size=1.8,fontface = "bold")+
  annotate(geom = "segment", x = 1.1, y = just_counts$lab_pos[1]+18, xend = 1.6, yend = just_counts$lab_pos[1]+10, size = 0.25)+
  #gompertz
  annotate("text", x=1, y=just_counts$lab_pos[2]+3, label= just_counts$label_inside[2], colour= 'black',size=1.8, fontface = "bold")+


  #labels outside doughnut
  # CUBIC
  #50-95%
  annotate("text", x=4, y=long$lab_pos[1]+1, label= long$label_outside[1], colour= 'black',size=1.8)+
  #95-99%
  annotate("text", x=4.1, y=long$lab_pos[2] +1, label= long$label_outside[2], colour= 'black',size=1.8)+
  # >99%
  annotate("text", x=4.3, y=long$lab_pos[3]+7, label= long$label_outside[3], colour= 'black',size=1.8)+
  annotate(geom = "segment", x=3.6, y=long$lab_pos[3] +5, xend = 3, yend = long$lab_pos[3], size = 0.25)+
  #<50%
  annotate("text", x=4.2, y=long$lab_pos[4]+12, label= long$label_outside[4], colour= 'black',size=1.8)+
  annotate(geom = "segment", x=3.5, y=long$lab_pos[4] +9, xend = 3, yend = long$lab_pos[4], size = 0.25)+

  # GOMPERTZ
  #>99%
  annotate("text", x=4.2, y=long$lab_pos[5], label= long$label_outside[5], colour= 'black',size=1.8)+
  #50-95%
  annotate("text", x=4.2, y=long$lab_pos[6], label= long$label_outside[6], colour= 'black',size=1.8)+
  #95-99%
  annotate("text", x=4.2, y=long$lab_pos[7]-11, label= long$label_outside[7], colour= 'black',size=1.8)+
  annotate(geom = "segment", x=3.6, y=long$lab_pos[7] -9, xend = 3, yend = long$lab_pos[7], size = 0.25)+
  #<50%
  annotate("text", x=4.2, y=long$lab_pos[8]-9, label= long$label_outside[8], colour= 'black',size=1.8)+
  annotate(geom = "segment", x=3.5, y=long$lab_pos[8] -7, xend = 3, yend = long$lab_pos[8], size = 0.25)+

  #LINEAR
  #50-95%
  annotate("text", x=4.2, y=long$lab_pos[9]-10, label= long$label_outside[9], colour= 'black',size=1.8)+
  annotate(geom = "segment", x=3.5, y=long$lab_pos[9] -8, xend = 3, yend = long$lab_pos[9], size = 0.25)+
  #<50%
  annotate("text", x=4.4, y=long$lab_pos[10]-12, label= long$label_outside[10], colour= 'black',size=1.8)+
  annotate(geom = "segment", x=3.9, y=long$lab_pos[10] -9, xend = 3, yend = long$lab_pos[10], size = 0.25)+
  #95-99%
  annotate("text", x=4.4, y=long$lab_pos[11]-5, label= long$label_outside[11], colour= 'black',size=1.8)+
  annotate(geom = "segment", x=3.9, y=long$lab_pos[11] -3, xend = 3, yend = long$lab_pos[11], size = 0.25)+

  #QUADRATIC
  #50-95%
  annotate("text", x=4.4, y=long$lab_pos[13]-4, label= long$label_outside[13], colour= 'black',size=1.8)+
  annotate(geom = "segment", x=3.9, y=long$lab_pos[13] -2, xend = 3, yend = long$lab_pos[13], size = 0.25)+
  #<50%
  annotate("text", x=4.4, y=long$lab_pos[14]-3.5, label= long$label_outside[14], colour= 'black',size=1.8)+
  annotate(geom = "segment", x=3.9, y=long$lab_pos[14] -2, xend = 3, yend = long$lab_pos[14], size = 0.25)+
  #99-95%
  annotate("text", x=4.7, y=long$lab_pos[15]- long$lab_pos[15] +4, label= long$label_outside[15], colour= 'black',size=1.8)+
  annotate(geom = "segment", x=4.3, y=long$lab_pos[15] +2, xend = 3, yend = long$lab_pos[15], size = 0.25)


  
#save the result
ggsave("../results/model_compare_doughnut.png", width = 10, height = 10, units = "cm")




