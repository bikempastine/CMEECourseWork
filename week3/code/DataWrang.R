################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")

############# Inspect the dataset ###############
head(MyData)
dim(MyData)
str(MyData) #why??
fix(MyData) #you can also do this
fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
head(MyData)
dim(MyData)
fix(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data
head(TempData)

############# Convert from wide to long format  ###############
require(reshape2) # load the reshape2 package

?melt #check out the melt function

MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")
fix(MyWrangledData)
class(MyWrangledData$Block)
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############

require(tidyverse)
#converting dataframe into a tibble
MyWrangledData <- as_tibble(MyWrangledData)
MyWrangledData
class(MyWrangledData)

glimpse(MyWrangledData)

View(MyWrangledData) #like fix but in tidyverse

filter(MyWrangledData, Count>100) #like subset

slice(MyWrangledData, 10:15)

MyWrangledData %>% group_by(Species) %>% 
        summarise(avg =mean(Count))

#same as
aggregate(MyWrangledData$Count, list(MyWrangledData$Species), FUN=mean) 

# Visualisation 
library(ggplot2)

# histogram of species abundance, grouped by cultivation
abundance_by_cultivation <- MyWrangledData %>% 
        group_by(Cultivation)%>% 
        ggplot( aes(x = log(Count))) +
        geom_histogram(fill = "lightblue", colour = "black") +
        theme_bw()+
        facet_grid(Cultivation ~ .)+
        labs(x = "Species Abundance",
        y = "Count of plots" ,
        title = "Species abundance by cultivation month")

#Bar plot of the number of tree species and number of trees observed of each species
spec<- MyWrangledData %>% group_by( Species)%>%  summarize(total = sum(Count))
ggplot(data = spec ,aes(y = total, x= reorder(Species, total))) +
        geom_bar(stat="identity", fill = 'steelblue')+
        theme_bw()+ coord_flip() + labs(x = 'total observed',
        y = 'Tree species', title = 'Number of tree species')



