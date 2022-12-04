#!/usr/bin/env Rscript

# This functiom calculates heights of trees given the distance of each tree
# from its base and angle to its top, using trigonometric formula

# height = distance * tan(radians)

# Arguments=
# degrees: the angle of elevation of the tree
# distance: The distance from the base of the tree (meters)

# Output=
# The heights of the tree, same units as the distance argument

#import data
data_name <- commandArgs(trailingOnly = T) #take value from command line
treesdata <- read.csv(paste("../data/", data_name , sep = "")) #read in the csv, the name of which is printed from csv from the command line


#function to get tree heights using trig
TreeHeight <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)

    return (height)
}

#make a new column on treesdata with the results from the function
treesdata$Tree.Height.m<- TreeHeight(treesdata$Angle.degrees, treesdata$Distance.m)

head(treesdata)
#save the results in results
rm_csv_data<- substring(data_name, 1, nchar(data_name)-4) #get the string from the input without .csv
## R
write.csv(treesdata, paste("../results/",rm_csv_data, "_treeheights.csv", sep=""))