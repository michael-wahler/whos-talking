# Generates training data from the .wav files stored in the samples directory
# input: .wav files in ../samples/
# output: training_data.csv in ../generated/
#
# __author__ = "Michael Wahler"
# __copyright__ = "Copyright 2020, Michael Wahler"
# __license__ = "GPLv3"
# __version__ = "0.1"
# __status__ = "Prototype"

# load required libraries
library (seewave)
library (tuneR)

# configure player (for Ubuntu)
setWavPlayer('/usr/bin/aplay')

analyze <- function(wavefile, name) {
  # define data frame to store the analysis data
  df <- as.data.frame(matrix(0, ncol = 31, nrow = 2))
  
  # print ("Starting analysis....")
  
  # load wave file
  wav <- readWave(wavefile)
  
  # set correct frequency
  f <- wav@samp.rate
  
  length_s = length(wav@left) / f
  
  
  # divide wave in 100ms-Snippets and analyze them separately
  for (i in 0:(length_s*10-1)){
    from = i*0.1
    to = i*0.1 + 0.1
    wav.spec <- meanspec(wav,flim=c(0,6), from=from, to=to, plot=FALSE)
    bands <- fbands (wav.spec, bands=seq(0,6,by=0.2), plot=FALSE)
    df[i+1,1:30] <- bands [,2]
    df[i+1,31] <- name
    # for debug:
    # print (i)
    # cat(sprintf("\"%f\" \"%f\"\n", from, to))
  }
  
  return (df)
  
}


dir.create(file.path("..", "generated"), showWarnings = FALSE)
print ("Creating training data from .wav files... ")

df <- analyze (wavefile="../samples/barack_train.wav", name="Barack")
df <- rbind (df, analyze (wavefile="../samples/george_train.wav", name="George"))
df <- rbind (df, analyze (wavefile="../samples/donald_train.wav", name="Donald") )
df <- rbind (df, analyze (wavefile="../samples/michael_train.wav", name="Michael") )

write.table (df, "../generated/training_data.csv", sep=",", row.names = FALSE)
print ("Result saved to ../generated/training_data.csv")
