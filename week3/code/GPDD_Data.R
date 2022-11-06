#install.packages("maps")
library(maps)


#load in data
load("../data/GPDDFiltered.RData")

#basic info about the data
head(gpdd)
summary(gpdd)

#map the data on a world map
map("world",  fill= T, col = "lightgreen", interior = FALSE, border='darkgreen')
points(x = gpdd$long , y =gpdd$lat, col='red', cex= 0.8, pch= 19)
box()

#Looking at the map, what biases might you expect in any analysis based on the data represented?

# There is a strong northern hemisphere biases in the data : the mean latitude  is 48.88 degrees
# and the 1st Quartile latitude is 43,50 degrees. Furthermore, there is also a longitudinal bias.
# There is little data collected in the Asian continent while most of the data is collected in Europe
# and North America. For a database called the 'Global Population Dynamics Database', the spatial biases 
# are clear. This will impact how globally applicable the analyses of this data are.