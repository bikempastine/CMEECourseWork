# An example utility function
# This functiom calculates heights of trees given the distance of each tree
# from its base and angle to its top, using trigonometric formula

# height = distance * tan(radians)

# Arguments=
# degrees: the angle of elevation of the tree
# distance: The distance from the base of the tree (meters)

# Output=
# The heights of the tree, same units as the distance argument

treesdata <- read.csv("../data/trees.csv") #read in the csv

#function to get tree heights using trig
TreeHeight <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    #print(paste("Tree height is:", height))
    #print(paste("Tree height is:", height))

    return (height)
}

#make a new column on treesdata with the results from the function
treesdata$Tree.Height.m<- TreeHeight(treesdata$Angle.degrees, treesdata$Distance.m)

#save the results in results
write.csv(treesdata, "../results/TreeHts.csv")