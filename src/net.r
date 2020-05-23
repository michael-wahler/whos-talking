library(neuralnet)
library(readr)

training_data <- read_csv("../generated/training_data.csv", col_types = 
                            cols(.default=col_double(),V31=col_character()))


print ("Creating neural network from training data....")

############################################################
# neural network function
feats <- names(training_data)

# Concatenate strings
f <- paste(feats[1:30],collapse=' + ')
f <- paste('Barack + George + Donald + Michael ~',f)

# Convert to formula
f <- as.formula(f)

# Convert the "name" column to three individual binary columns
trainset <- cbind(training_data[, 1:30], nnet::class.ind(training_data$V31))

############################################################
# neural network
nn <- neuralnet(f,trainset,hidden=c(10,5,10),linear.output=FALSE)  #hidden=c(10,5,10) works very well

#print ("Neural network created. View it with 'plot(nn)'")

#FIXME when changing the file name, the generated PDF file is corrupt
#pdf(file="../generated/nn.pdf")  
print(plot(nn))
dev.off()

print ("Neural net saved to PDF.")

