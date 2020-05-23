cat (sprintf("This demo\n"))
cat (sprintf("- creates training and test data from .wav files and stores them as .csv\n"))
cat (sprintf("- loads the generated training data from .csv and creates a neural network\n"))
cat (sprintf("- loads some test data and evaluates it on the neural network\n"))

source ("create_training_data.r")
source ("create_test_data.r")
source ("net.r")


# try out with test data
library(readr)
cat (sprintf("Loading test data for Michael\n"))
test_data <- read_csv("../generated/test_data_michael.csv", col_types = 
                        cols(.default=col_double()))


predicted.nn.values <- compute(nn,test_data)


cat (sprintf("-----------------------------------------\nResults:\n\n"))
cat(sprintf("Pr[Barack] = %f\n", predicted.nn.values$net.result[[1]]))
cat(sprintf("Pr[George] = %f\n", predicted.nn.values$net.result[[2]]))
cat(sprintf("Pr[Donald] = %f\n", predicted.nn.values$net.result[[3]]))
cat(sprintf("Pr[Michael] = %f\n", predicted.nn.values$net.result[[4]]))

cat (sprintf("Loading test data for Barack\n"))
test_data <- read_csv("../generated/test_data_barack.csv", col_types = 
                        cols(.default=col_double()))
predicted.nn.values <- compute(nn,test_data)

cat (sprintf("-----------------------------------------\nResults:\n\n"))
cat(sprintf("Pr[Barack] = %f\n", predicted.nn.values$net.result[[1]]))
cat(sprintf("Pr[George] = %f\n", predicted.nn.values$net.result[[2]]))
cat(sprintf("Pr[Donald] = %f\n", predicted.nn.values$net.result[[3]]))
cat(sprintf("Pr[Michael] = %f\n", predicted.nn.values$net.result[[4]]))
