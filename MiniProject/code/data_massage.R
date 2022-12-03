# load packages
library(dplyr)

##load the data
data<-read.csv("../data/LogisticGrowthData.csv")

##define the groups
grouped_data <- data %>% 
                group_by(Species, Medium, Temp, Citation)%>%
                mutate(ID = cur_group_id()) #add column to be the grouped ids

grouped_data <- as.data.frame(grouped_data) #make it into a dataframe to move away from pesky tibbles


d <- subset(grouped_data, Time >= 0 & PopBio > 0 ) #remove values that are less than or equal to zero in population and time
# lost 2.1% of data

#log all of the pop bio
d$PopBio <- log(d$PopBio) 

#make a key of all the groups
key <- d %>% group_by(Species, Medium, Temp, Citation) %>% 
    select(Species, Medium, Temp, Citation,PopBio_units, ID) %>% 
    group_by(Species, Medium, Temp, Citation) %>%
    unique()


# make a list of dataframes with each ID
d_sub <- list() #initialise empty list

for (i in 1:max(d$ID)){ #loop through each ID to fill the list
    d_sub[[i]]<- subset(d, ID == i)
}

d_sub <- Filter(function(x) nrow(x) > 6, d_sub)


#save the clean data as a dataframe -> load the data using readRDS
saveRDS(d_sub, file="../data/clean_list.RData")
saveRDS(key, file="../data/key.RData")