# load required libraries
library(ggplot2)

# function producing elipse to bound eigenvalues
build_elipse <- function(hradius, vradius){
    npoints = 250
    a <- seq(0,2 *pi, length = npoints + 1) # sequence from zero to 2pi with 251 points
    x <- hradius * cos(a)
    y <- vradius *sin(a)
    return(data.frame(x = x, y = y))
}

# Create a maxtrix to find the eigen values of
N <- 250 #size of matrix
M <- matrix(rnorm(N*N), N, N) # create the matrix

# Find the eigen values
eigenvals <- eigen(M)$values

# Build the dataframe of the eigen values seperating out real and imaginary component
eigDF <- data.frame("Real" = Re(eigenvals), "Imaginary" = Im(eigenvals))
head(eigDF)

# Set radius of the elipse
my_radius <- sqrt(N)

#Dataframe of the elipse
ellDF <- build_elipse(my_radius, my_radius)
names(ellDF) <- c("Real", "Imaginary") #rename columns to match eigDF

##Plot results
#plot the eigenvalues
p <- ggplot(eigDF, aes(x = Real, y = Imaginary))+
            geom_point(shape = I(3))+
            theme_bw()+
            theme(legend.position = "none")

#add vertical and horizontal lines representing real, imaginary axis
p <- p + geom_hline(aes(yintercept = 0))+
         geom_vline(aes(xintercept = 0))

#add the elipse
p <- p + geom_polygon(data = ellDF, aes(x = Real, y = Imaginary, 
                                        alpha = 1/20, fill = "red"))

# Save to pdf in results
pdf("../results/Girko.pdf", width=10, height=10)
print(p)
dev.off()