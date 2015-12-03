library(coalescentMCMC)
library(ape)
library(testit)

calculate_likelihood_coalescent_test <- function() {
  
  N <- 10
  phylogeny <- rcoal(N)
  
  plot(
    phylogeny,
    main=paste("Random coalescent tree with N = ",N,sep="")
  )
  
  # theta = 2 * N * nu
  # N: number of alleles in the population
  # nu: neutral mutation rate
  
#   mutation_rates <- seq(0.0,1.0,0.001)
#   likelihoods <- c()
#   for (this_mutation_rate in mutation_rates)
#   {
#     likelihood <- dcoal(phy = phylogeny,theta = 2.0 * N * this_mutation_rate,log = FALSE)
#     if (length(likelihoods) == 0) 
#     {
#       likelihoods <- likelihood
#     } else {
#       likelihoods <- c(likelihoods,likelihood)
#     }
#   }
#   plot(likelihoods ~ mutation_rates,
#     main=paste("Likelihoods calculated using dcoal \n(theta = 2.0 * N * mutation rate), for N=",N,sep=""),
#     xlab="Mutation rate",
#     ylab="Likelihood"
#   )
}

calculate_likelihood_coalescent_test()
