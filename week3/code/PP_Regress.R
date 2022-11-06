#load required packages
library(ggplot2)
library(dplyr)
library(broom)

#clean workspace
rm(list=ls())


#load the data
Pred <- as.data.frame(read.csv("../data/EcolArchives-E089-51-D1.csv"))

## Cleaning
#making prey mass data to be all in mg
mg<- filter(Pred, Prey.mass.unit == "mg") #get rows where prey mass unit is mg
mg$Prey.mass<- mg$Prey.mass *0.001 #multiply prey mass in these rows by 0.001 to convert to grams

# Join rows that had prey mass in g and ones that were originally in mg
Pred_prey_g <- rbind(mg, filter(Pred, Prey.mass.unit == "g"))


## Plotting
#plot the results in the style in the MulQUalBio
reproduced_predator<- ggplot(Pred_prey_g,  aes(Prey.mass,  Predator.mass,
        group = Predator.lifestage, col=Predator.lifestage)) +
  geom_point(pch=4) +
  geom_smooth(method = lm, fullrange=TRUE)+
  theme_bw()+
  theme(legend.position="bottom")+
  scale_x_continuous(trans = scales::log_trans(),
                     breaks = scales::log_breaks()) +
  scale_y_continuous(trans = scales::log_trans(),
                     breaks = scales::log_breaks())+
    xlab("Prey mass in grams")+
    ylab("Preditor mass in grams")+
  facet_wrap(~Type.of.feeding.interaction, nrow=5, strip.position= "right")

#write the plot to pdf in results
pdf("../results/reproduced_predator.pdf", width=6, height=12)
print(reproduced_predator)
dev.off()

## Storing results
#Perform the regression, first grouping by the required feilds
regression <- Pred_prey_g %>% 
                            group_by(Type.of.feeding.interaction,Predator.lifestage)%>%
                            do(reg_vals = summary(lm(log(Prey.mass) ~ log(Predator.mass), data=.))) #do function executes the regression in dplyr

#Get the list of groups that correspond to each regression output
reg_group_key<- Pred_prey_g %>% group_by(Type.of.feeding.interaction,Predator.lifestage)%>%
                group_keys()

#make a dataframe to put regression output into
reg_results <- data.frame(Type_of_feeding_interaction = character(),
                Predator_lifestage= character(),
                Intercept = double(), 
                Slope= double(), 
                F_stat= double(), 
                R2= double(), 
                Pvalue= double())


#Put in requird info from the reg//-group_key and the regression results
for(i in 1:18){
    reg_results[i,1]<- reg_group_key[i,1]
    reg_results[i,2]<- reg_group_key[i,2]
    reg_results[i,3]<- regression$reg_vals[[i]][[4]][1,1] #intercept
    reg_results[i,4]<- regression$reg_vals[[i]][[4]][2,1] #slope
    reg_results[i,5]<- regression$reg_vals[[i]][[10]][1] #F-stat
    reg_results[i,6]<- regression$reg_vals[[i]][[8]] #R2
    reg_results[i,7]<- regression$reg_vals[[i]][[4]][2,4] #p-value
}

#write results to csv and save in results
write.csv(reg_results, file= "../results/PP_Regress_Results.csv")

