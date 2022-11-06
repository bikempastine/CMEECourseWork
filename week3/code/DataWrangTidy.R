
### Wrangling the Pound Hill Dataset using tidyverse

#load required packages
library(tidyverse)

############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")

############# Inspect the dataset ###############
head(MyData)
dim(MyData)
str(MyData) 

############# Transpose ###############
# To get those species into columns and treatments into rows 

MyData <- MyData %>% t() %>% as.data.frame() %>% #transpose data and save as a df
                    setNames(.[1,])%>% #set column names
                    slice(-1)%>% #get rid of first row : duplicate
                    mutate_all(funs(replace(., .=='', 0)))#%>% #replace blank cells with 0       




############# Convert from wide to long format  ###############
MyWrangledData<- MyData %>% pivot_longer(cols = 5:45,
                             names_to = "Species", values_to = "Count")


#convert to correct data type
MyWrangledData <- MyWrangledData %>% 
                    mutate(across(Cultivation:Quadrat, as.factor)) %>% 
                    mutate(across(Count, as.integer))




