rm(list=ls())
library(coalescentMCMC)
library(ape);
library(testit)

N <- 10
mutation_rate <- 0.1
phylogeny <- rcoal(N)

svg(filename="CalculateLikelihoodCoalescent.svg")
n_cols <- 1
n_rows <- 2
par(mfrow=c(n_rows,n_cols))

plot(
  phylogeny,
  main=paste("Random coalescent tree with N = ",N,", and mutation rate = ",mutation_rate,sep="")
)

# theta = 2 * N * nu
# N: number of alleles in the population
# nu: neutral mutation rate

mutation_rates <- seq(0.0,1.0,0.001)
likelihoods <- c()
for (this_mutation_rate in mutation_rates)
{
  likelihood <- dcoal(phy = phylogeny,theta = 2.0 * N * this_mutation_rate,log = FALSE)
  if (length(likelihoods) == 0) 
  {
    likelihoods <- likelihood
  } else {
    likelihoods <- c(likelihoods,likelihood)
  }
}
plot(likelihoods ~ mutation_rates,type="lines",
  main=paste("Likelihoods calculated using dcoal \n(theta = 2.0 * N * mutation rate), for N=",N,sep=""),
  xlab="Mutation rate",
  ylab="Likelihood"
)
abline(v=mutation_rate, lty = 3)
par(mfrow=c(1,1))
dev.off()
