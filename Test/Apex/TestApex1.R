# To get devtools to install on Linux (as of 2015-04-19, Lubuntu) use the following line in the terminal:
# sudo apt-get install libcurl4-gnutls-dev
# install.packages("devtools")
library(devtools)
install_github("thibautjombart/apex")
install.packages("apex")
library(apex)
install.packages('installr')

if (!require('devtools')) install.packages('devtools'); library('devtools')
# make sure you have Rtools installed first! if not, then run:
#install.packages('installr')
#install.Rtools()
devtools::install_github('talgalili/installr')
library(installr)
setInternet2(TRUE)
updateR()
installr()

par(mfrow=c(3,1), mar=c(6,6,2,1))
image(woodmouse)
image(x@dna[[1]])
image(x@dna[[2]])