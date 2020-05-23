library(readr)

test_data <- read_csv("../generated/test_data_barack.csv", col_types = 
                            cols(.default=col_double()))


############################################################
# normalize the data
# Create Vector of Column Max and Min Values
# maxs <- apply(test_data[,1:30], 2, max)
# mins <- apply(test_data[,1:30], 2, min)
# 
# # Use scale() and convert the resulting matrix to a data frame
# scaled.test.data <- as.data.frame(scale(test_data[,1:30],center = mins, scale = maxs - mins))


scaled.test.data <- test_data

print ("Loaded scaled.test.data")