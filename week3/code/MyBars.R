##Learning to plot lineranges (or boxes) in ggplot

#Load required packages
library(ggplot2)

#load data
a <- read.table("../data/Results.txt", header = TRUE)
head(a) #view data

# append on a column of zeros
a$ymin <- rep(0, dim(a)[1])

#plot first linerange
p <- ggplot(a) + geom_linerange(data = a, aes(x=x, ymin = ymin,
                                            ymax = y1, size = 0.5),
                                colour = "#E69F00", alpha = 0.5, 
                                show.legend = FALSE)

#plot second linerange
p <- p + geom_linerange(data = a, aes(x = x, ymin = ymin,
                                    ymax = y2,size = 0.5),
                        colour = "#56B4E9", alpha = 0.5, 
                        show.legend = FALSE)

#plot third linerange:
p <- p + geom_linerange(data = a, aes(x = x, ymin = ymin,
                                    ymax = y3, size = 0.5),
                        colour = "#D55E00", alpha = 0.5, 
                        show.legend = FALSE)

#add labels
p <- p + geom_text(data = a, aes(x = x, y = -500, label = Label))

#set axis labels and add theme
p <- p + scale_x_continuous("My x axis",breaks = seq(3, 5, by = 0.05)) +
            scale_y_continuous("My y axis") +
            theme_bw()


#save as pdf

pdf("../results/MyBars.pdf", width=10, height=10)
print(p)
dev.off()