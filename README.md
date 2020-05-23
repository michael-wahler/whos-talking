# Summary
This is an experiment to use neural networks to detect the speaker of a voice sample.

# Prerequisites
 - R must be installed (Ubuntu: `sudo apt install r-base`)
 - Run `sudo R` and install additional packages (system-wide, hence the 'sudo') by typing:
    ```R
    install.packages(c("fftw","tuneR","rgl","rpanel"), repos="http://cran.at.r-project.org/")
    install.packages("seewave", repos="http://cran.at.r-project.org/")
	install.packages('neuralnet')
	install.packages('readr')
	```

# How to use
 - Run
    ```bash
    cd src
    Rscript demo.r
    ```
   for a demo (runs about 4 seconds on a somewhat modern system).

# How it works
 - The program loads audio files in .wav format. It slices them into samples
   of 100 ms each. For each sample it computes the mean frequency spectrum and
   extracts the peaks for 30 frequency bands.
 - The training data is a table with 31 columns (30 double values for the peaks on
   the respective frequency band and the name of the person).
 - The training data is used to teach a neural network.
 - The test data is generated from audio files similarly to the training data.
   The only difference is that the audio files is not chopped into 100 ms chunks.

# Observations
 - with no hidden layer, George and Donald sound alike. Obama still sounds very different.
 - with no hidden layer, training the neural network takes several seconds
 - hidden layers (10,5,10) work almost perfectly
 - with some hidden layers, training the neural network is almost instantaneous

# Limitations and TODOs
 - silence should be automatically cut from the input audio files
 - the input files should be normalized, although this is unlikely to increase
   the quality of the algorithm
 - the algorithm can be optimized by experimenting with different ways of
   extracting audio information. E.g. instead of targeting equally distributed
   frequency bands as in the current version, one could try to target
   formants that are known to be characteristic to human voices. Also, instead
   of looking at the mean frequency spectrum, one could use local peaks etc. 
   
# Misc
On another system I needed to install further packages (alternative to mesa…: r-cran-rgl)
    ```bash
    sudo apt install mesa-common-dev bwidget libfftw3-dev libsndfile1-dev 
    ```
