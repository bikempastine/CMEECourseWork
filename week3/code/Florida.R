# Load florida temperature data
rm(list=ls())
load("../data/KeyWestAnnualMeanTemperature.RData")
ls() #data called ats

#examine the data
class(ats)
head(ats)
summary(ats)

#plot the temperature data
png(file="../results/temp.png", width=500, height=450)
plot(ats, pch=19, cex= 0.8, ylab= "Average Annaual Temprature (°C)",
    main= "Fig 1: Temperatures in Key West, Florida in the 20th century") #relationship appears linear
abline(lm(ats$Temp ~ ats$Year), col = "red", lwd = 3)
text(paste("Correlation:", round(cor(ats$Temp, ats$Year), 2)), x = 1915, y = 25.8)
dev.off()

#correlation coefficient of actual data

hist(ats$Temp) #temperature appears somewhat normal 
floridacor<- cor(ats$Year, ats$Temp, method= 'pearson') 

#randomly reshuffle temperatures and find the corelation coefficient between years and reshuffled
reps = 100000
set.seed(2489)
cormatrix<- matrix(NA, nrow= reps, ncol=1)
for (i in 1:reps){
    temp<- sample(ats$Temp, replace= F)
    corcoeff<- cor(ats$Year, temp, method= 'pearson')
    cormatrix[i]<- corcoeff
}

# explore this cor coef data
summary(cormatrix)
hist(cormatrix)

# fraction of the random correlation coefficients were greater than the observed one
aprox_pvalue<- sum(cormatrix > floridacor)/ reps
paste("approximate, asymtomatic p-value is:", aprox_pvalue)


d <- density(cormatrix ,from=-1, to=1) # returns the density data


png(file="../results/density.png", width=500, height=450)
plot(d, xlim= c(-0.6,0.6), lwd= 3, #cex.lab=1.5, cex.axis=1.5, cex.main=1.5,,
        xlab = "Pearson Correlation Coefficient",
        ylab = "Probability Density",
        main = "Fig 2: Probability density distribion of randomly\npermutated temperature time series"
        )
polygon(d, border= 'black', col = 'lightgray')
abline(v= floridacor, col ='red' ,lty=2, lwd=3)
text(x =(floridacor - 0.16), y= 2, "observed\ncorrelation\ncoefficient", 
    col= 'red')
dev.off() 