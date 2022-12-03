# load in the data: model run results
l_model <- readRDS("../data/model_fit_linear.RData")
q_model <- readRDS("../data/model_fit_quadratic.RData")
c_model <- readRDS("../data/model_fit_cubic.RData")
g_model <- readRDS("../data/model_fit_gompertz.RData")


#load the key prepared in data_massage.R
key <- readRDS("../data/key.RData")

#function to change the names of columns to include the model they came from 
column_naming <- function(model, name) {
    colnames(model) <- paste(name, colnames(model), sep = "_")
    names(model)[names(model) == paste(name, 'ID', sep = "_")] <- 'ID'
    return(colnames(model))
}

#change the column names for each model dataframe
colnames(l_model) <- column_naming(model = l_model, name = 'linear')
colnames(q_model) <- column_naming(model = q_model, name = 'quadratic')
colnames(c_model) <- column_naming(model = c_model, name = 'cubic')
colnames(g_model) <- column_naming(model = g_model, name = 'gompertz')


#put all data frames into list
results_list <- list(key, l_model, q_model, c_model, g_model)      

#merge all data frames together
merged_results <- Reduce(function(x, y) merge(x, y, by = 'ID',), results_list)  

write.csv(merged_results, "../results/results_table.csv")