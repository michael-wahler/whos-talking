# Runs a demo consisting of training a neural network and using it to classify speech
# __author__ = "Michael Wahler"
# __copyright__ = "Copyright 2020, Michael Wahler"
# __license__ = "GPLv3"
# __version__ = "0.1"
# __status__ = "Prototype"

library(neuralnet)
library(readr)

stored_model_filename = "../generated/model.rds"

# This function runs the data in csv_filename through the neural net nn
run_net <- function(csv_filename, name)
{
cat (sprintf("\nLoading test data for %s\n", name))

test_data <- read_csv(csv_filename, col_types = 
                        cols(.default=col_double()))

predicted.nn.values <- compute(nn,test_data)

cat (sprintf("-----------------------------------------\nResults:\n\n"))
cat(sprintf("Pr[Barack] = %f\n", predicted.nn.values$net.result[[1]]))
cat(sprintf("Pr[George] = %f\n", predicted.nn.values$net.result[[2]]))
cat(sprintf("Pr[Donald] = %f\n", predicted.nn.values$net.result[[3]]))
cat(sprintf("Pr[Michael] = %f\n", predicted.nn.values$net.result[[4]]))
}



cat (sprintf("This demo\n"))
cat (sprintf("- creates training and test data from .wav files and stores them as .csv\n"))
cat (sprintf("- loads the generated training data from .csv and creates a neural network\n"))
cat (sprintf("- loads some test data and evaluates it on the neural network\n"))


# generate ../generated/test_data_*.csv
source ("create_test_data.r")


#TODO
# test if ../generated/model.rds exist
# if it does, 
# nn <- readRDS("../generated/model.rds")
# and skip the "source" lines create_training_data and net.r

if (file.exists(stored_model_filename)) 
{
    nn <- readRDS("../generated/model.rds")
    cat (sprintf("Found stored model in %s, loading it instead of training a new model.\n", stored_model_filename))
} else 
{
    # generate ../generated/training_data.csv
    source ("create_training_data.r")
    # trains a neural network referenced by variable 'nn'
    source ("net.r")
}

# run the neural network with the test data

run_net ("../generated/test_data_michael.csv", "Michael")

run_net ("../generated/test_data_barack.csv", "Barack")

run_net ("../generated/test_data_donald.csv", "Donald")

run_net ("../generated/test_data_george.csv", "George")


# save neural network model
if (! file.exists(stored_model_filename)) {
    saveRDS (nn, file=stored_model_filename) 
    cat (sprintf("\n\nStored neural network model in %s, it will be reused on the next run.\n",
    stored_model_filename))
}
