#load required packages
library(tidyverse)

#clean workspace
rm(list=ls())

#load the data
Pred_data <- as.data.frame(read.csv("../data/EcolArchives-E089-51-D1.csv"))

## Cleaning
#making prey mass data to be all in mg
mg<- filter(Pred_data, Prey.mass.unit == "mg") #get rows where prey mass unit is mg
mg$Prey.mass<- mg$Prey.mass *0.001 #multiply prey mass in these rows by 0.001 to convert to grams

# Join rows that had prey mass in g and ones that were originally in mg
Pred_data_g <- rbind(mg, filter(Pred_data, Prey.mass.unit == "g"))


#Make dataframe for plotting
DF <- Pred_data_g %>% 
                group_by(Type.of.feeding.interaction)%>% #groups
                select(Type.of.feeding.interaction, #select ony required columns to avoid confusion  
                        Predator.mass, Prey.mass)


#add column for size ratio
DF$Size.ratio <- DF$Predator.mass / DF$Prey.mass

#Spliteach group into its own tibble, stored in a list
a<- DF %>% group_split()

#Histogram plotting function
plot.my.hist <- function(x,y, name, max, min, step){
    hist(log10(x),
     xlab = paste("log10(", name, " )"), 
     ylab = "Count", 
     col = "lightblue",
     main = y,
     xlim = c(min,max),
     breaks = seq(from= min , to= max, by=step)
     )}


##Plot results and save in results
#Predator
pdf("../results/Pred_Subplots.pdf", width=6, height=12)
par(mfrow=c(5,1))
for(i in 1:5){
    plot.my.hist(pull(a[[i]][2]), 
                pull(a[[i]][1,1]),
                name = "Predator Mass (g)",
                max = 6 , min = -4, step = 1)
}
dev.off()

#Prey
pdf("../results/Prey_Subplots.pdf", width=6, height=12)
par(mfrow=c(5,1))
for(i in 1:5){
    plot.my.hist(pull(a[[i]][3]), 
                pull(a[[i]][1,1]),
                name = "Prey Mass (g)",
                max = 4 , min = -11, step = 1)
}
dev.off()

#Size Ratio
pdf("../results/SizeRatio_Subplots.pdf", width=6, height=12)
par(mfrow=c(5,1))
for(i in 1:5){
    plot.my.hist(pull(a[[i]][4]), 
                pull(a[[i]][1,1]),
                name = "Size ratio:\n(Predator mass/Pret mass)",
                max = 9 , min = -3, step = 1)
}
dev.off()

##Results as csv
#summarize the results by group , making new columns for each summary
table.results <- DF%>%
        summarize(Mean.Predator = mean(log10(Predator.mass)),
                  Median.Predator = median(log10(Predator.mass)),      
                  Mean.Prey = mean(log10(Prey.mass)),      
                  Median.Prey = median(log10(Prey.mass)),
                  Mean.SizeRatio = mean(log10(Size.ratio)),
                  Median.SizeRatio = median(log10(Size.ratio)))

#rename first column
table.results<- table.results%>% rename("Feeding.type" = "Type.of.feeding.interaction")

#write results to csv
write.csv(table.results, "../results/PP_Results.csv")            