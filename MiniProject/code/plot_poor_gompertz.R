#load libraries
library(dplyr)
library(ggplot2)
library(tidyr)

#main data
d <- readRDS("../data/clean_list.RData")
#linear model
l <- readRDS("../data/model_plot_data_linear.RData")
#quadratic model
q <- readRDS("../data/model_plot_data_quadratic.RData")
#cubic model
c <- readRDS("../data/model_plot_data_cubic.RData")
#gompertz model
g <- readRDS("../data/model_plot_data_gompertz.RData")

ID =2
p <- ggplot( d[[ID]], aes(x= Time, y= PopBio))+
         geom_point(size = 2, shape =19)+
         xlab("Time")+ ylab("logPopulation")+
         theme_bw()+
         labs(subtitle = paste(" Species name:",d[[ID]]$Species, " \n Medium:",d[[ID]]$Medium, "\n Temp:", d[[ID]]$Temp, "\n Cite:","(Bea et al., 2014)", "\n ID:",d[[ID]]$ID))

p +geom_line(data = c[[ID]], aes(x = Time, y = PopBio), size = 1, colour = '#00BFC4') + #cubic model
 geom_line(data = g[[ID]], aes(x = Time, y = N), size = 1, colour = '#C77CFF') + #gompertz model
 geom_line(data = l[[ID]], aes(x = Time, y = PopBio), size = 1, colour = '#f8766D')+ #linaer model
geom_line(data = q[[ID]], aes(x = Time, y = PopBio), size = 1, colour = '#7CAE00')+ #quadratic model
annotate('text', y = -2.8, x= 450, label= 'Cubic', colour= '#00BFC4', size =3)+
annotate('text', y = -2.9, x= 450, label= 'Gompertz', colour= '#C77CFF', size =3)+
annotate('text', y = -3, x= 450, label= 'Linear', colour= '#f8766D', size =3)+
annotate('text', y = -3.1, x= 450, label= 'Quadratic', colour= '#7CAE00', size =3)

ggsave("../results/ID_2.png", width = 9, height = 9, units = "cm")

