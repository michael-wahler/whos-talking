# this file can be loaded using 
#     source ("~/R/waves.r")

# load required libraries
library (seewave)
library (tuneR)

# configure player (for Ubuntu)
setWavPlayer('/usr/bin/aplay')

analyze <- function(wavefile, name) {
  # define data frame to store the analysis data
  df <- as.data.frame(matrix(0, ncol = 30, nrow = 1))
  
  # print ("Starting analysis....")
  
  # load wave file
  wav <- readWave(wavefile)
  
  # set correct frequency
  f <- wav@samp.rate
  
  length_s = length(wav@left) / f
  
  
  wav.spec <- meanspec(wav,flim=c(0,6), plot=FALSE)
  bands <- fbands (wav.spec, bands=seq(0,6,by=0.2), plot=FALSE)
  df[1,1:30] <- bands [,2]
  
  return (df)

}

print ("Creating test data from .wav files...")

df <- analyze (wavefile="../samples/barack_test.wav", name="Barack")
write.table (df, "../generated/test_data_barack.csv", sep=",", row.names = FALSE)


df <- analyze (wavefile="../samples/george_test.wav", name="George")
write.table (df, "../generated/test_data_george.csv", sep=",", row.names = FALSE)
  
df <- analyze (wavefile="../samples/donald_test.wav", name="Donald")
write.table (df, "../generated/test_data_donald.csv", sep=",", row.names = FALSE)

df <- analyze (wavefile="../samples/michael_test.wav", name="Michael")
write.table (df, "../generated/test_data_michael.csv", sep=",", row.names = FALSE)


print ("Test data generated.")
