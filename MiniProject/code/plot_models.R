#load packages
library(ggplot2)

# load in the data
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

# load in the data to annotate the graphs: AIC data
l_model <- readRDS("../data/model_fit_linear.RData")
q_model <- readRDS("../data/model_fit_quadratic.RData")
c_model <- readRDS("../data/model_fit_cubic.RData")
g_model <- readRDS("../data/model_fit_gompertz.RData")


# General plotting function 
plot_by_id <- function(df, ID){
    p <- ggplot( df[[ID]], aes(x= Time, y= PopBio))+
         geom_point(size = 2, shape =19)+
         xlab("Time")+ ylab("logPopulation")+
         theme_bw()+
         labs(subtitle = paste(" Species name:",df[[ID]]$Species, " \n Medium:",df[[ID]]$Medium, "\n Temp:", df[[ID]]$Temp, "\n Cite:",df[[ID]]$Citation, "\n ID:",df[[ID]]$ID))

    return(p)
}

#save the results and add the model fit line to the plot, with text containing info about the graphs
pdf(width = 12, height = 8, "../results/linear_models.pdf")
for (ID in 1:length(d)){
    print(plot_by_id(d, ID)+ 
          geom_line(data = l[[ID]], aes(x = Time, y = PopBio), size = 1, colour = '#f8766D')+ #linaer model
          geom_line(data = q[[ID]], aes(x = Time, y = PopBio), size = 1, colour = '#7CAE00')+ #quadratic model
          geom_line(data = c[[ID]], aes(x = Time, y = PopBio), size = 1, colour = '#00BFC4') + #cubic model
          geom_line(data = g[[ID]], aes(x = Time, y = N), size = 1, colour = '#C77CFF') + #gompertz model
          annotate("text", x = Inf, y = Inf, label = paste("AICc Linear:", signif(l_model[ID,7], 4), "\nAICc Quadratic:", 
                    signif(q_model[ID,8],4), "\nAICc Cubic:", signif(c_model[ID,9],4), "\nAICc Gompertz:", signif(g_model[ID, 10],4)), vjust = 6.5, hjust = 1))
}
dev.off()


p <- plot_by_id(d, ID)
p <- p + geom_line(data = g[[ID]], aes(x = Time, y = N), size = 1, colour = 'purple')
print(p)
