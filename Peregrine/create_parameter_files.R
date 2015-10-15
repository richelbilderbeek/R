# Step #1
# Creates files with filename [number].RDa that
# contain the parameters of interest.
library(testit)

LoadParametersFromFile <- function(filename) {
  assert(file.exists(filename))
  my_table <- readRDS(filename)
}

SaveParametersToFile <- function(
  rng_seed,
  b_1, # the speciation-initiation rate of good species
  b_2, # the speciation-initiation rate of incipient species 
  la_1, # the speciation-completion rate 
  mu_1, # the extinction rate of good species 
  mu_2, # the extinction rate of incipient species 
  age,
  mutation_rate,
  n_alignments,
  sequence_length,
  mcmc_chainlength,
  filename
) {

  my_table <- data.frame( row.names = c("Description","Value"))
  my_table[, "rng_seed"] <- c("Random number generate seed",rng_seed)
  my_table[, "b_1"] <- c("Speciation initiation rate of good species",b_1)
  my_table[, "b_2"] <- c("Speciation initiation rate of incipient species",b_2)
  my_table[, "la_1"] <- c("Speciation completion rate",la_1)
  my_table[, "mu_1"] <- c("Extinction rate of good species",mu_1)
  my_table[, "mu_2"] <- c("Extinction rate of incipient species",mu_2)
  my_table[, "age"] <- c("Phylogenetic tree age",age)
  my_table[, "mutation_rate"] <- c("DNA mutation rate",mutation_rate)
  my_table[, "n_alignments"] <- c("Number of DNA alignments",n_alignments)
  my_table[, "sequence_length"] <- c("DNA sequence length",sequence_length)
  my_table[, "mcmc_chainlength"] <- c("MCMC chain length",mcmc_chainlength)
  
  my_list <- list(my_table)
  names(my_list) <- c("parameters")
  assert(my_list$parameters == my_table)
  
  
  saveRDS(my_list,file=filename)
  assert(file.exists(filename))
  
  my_list_again <- readRDS(filename)
  # Check that the original and loaded data frame were identical
  assert(length(my_list) == length(my_list_again))
  assert(my_list$parameters == my_list_again$parameters)

  assert(rng_seed == as.numeric(my_list$parameters$rng_seed[2]))
  assert(b_1  == as.numeric(my_list$parameters$b_1[2]))
  assert(b_2  == as.numeric(my_list$parameters$b_2[2]))
  assert(la_1 == as.numeric(my_list$parameters$la_1[2]))
  assert(mu_1 == as.numeric(my_list$parameters$mu_1[2]))
  assert(mu_2 == as.numeric(my_list$parameters$mu_2[2]))
  assert(age == as.numeric(my_list$parameters$age[2]))
  assert(n_alignments == as.numeric(my_list$parameters$n_alignments[2]))
  assert(mutation_rate == as.numeric(my_list$parameters$mutation_rate[2]))
  assert(sequence_length == as.numeric(my_list$parameters$sequence_length[2]))
  assert(mcmc_chainlength == as.numeric(my_list$parameters$mcmc_chainlength[2]))
}

TestCreateParametersFiles <- function() {
  rng_seed <- 42
  b_1  <- 0.2 # the speciation-initiation rate of good species
  b_2  <- 0.2 # the speciation-initiation rate of incipient species 
  la_1 <- 1.0 # the speciation-completion rate 
  mu_1 <- 0.1 # the extinction rate of good species 
  mu_2 <- 0.1 # the extinction rate of incipient species 
  age <- 15
  mutation_rate <- 0.1
  n_alignments <- 10
  sequence_length <- 100
  mcmc_chainlength <- 10000
  filename <- "1_tmp.txt"
  SaveParametersToFile(
    rng_seed = rng_seed,
    b_1 = b_1, # the speciation-initiation rate of good species
    b_2 = b_2, # the speciation-initiation rate of incipient species 
    la_1 = la_1, # the speciation-completion rate 
    mu_1 = mu_1, # the extinction rate of good species 
    mu_2 = mu_2, # the extinction rate of incipient species 
    age = age,
    mutation_rate = mutation_rate,
    n_alignments = n_alignments,
    sequence_length = sequence_length,
    mcmc_chainlength = mcmc_chainlength,
    filename = filename
  )
  
  assert(file.exists(filename))
  parametersfile <- LoadParametersFromFile(filename)
  
  assert(rng_seed == as.numeric(parametersfile$parameters$rng_seed[2]))
  assert(b_1  == as.numeric(parametersfile$parameters$b_1[2]))
  assert(b_2  == as.numeric(parametersfile$parameters$b_2[2]))
  assert(la_1 == as.numeric(parametersfile$parameters$la_1[2]))
  assert(mu_1 == as.numeric(parametersfile$parameters$mu_1[2]))
  assert(mu_2 == as.numeric(parametersfile$parameters$mu_2[2]))
  assert(age == as.numeric(parametersfile$parameters$age[2]))
  assert(mutation_rate == as.numeric(parametersfile$parameters$mutation_rate[2]))
  assert(n_alignments == as.numeric(parametersfile$parameters$n_alignments[2]))
  assert(sequence_length == as.numeric(parametersfile$parameters$sequence_length[2]))
  assert(mcmc_chainlength == as.numeric(parametersfile$parameters$mcmc_chainlength[2]))
  file.remove(filename) # Get rid of that test file
}

CreateParametersFiles <- function () {

  file_index <- 0

  for (rng_seed in c(42)) {
    for (b_1 in c(0.5)) { # the speciation-initiation rate of good species
      b_2 <- b_1 # the speciation-initiation rate of incipient species
      for (la_1 in c(0.01,0.1,1,10,100,1000,10000)) { # the speciation-completion rate
        for (mu_1 in c(0.1)) {
          mu_2 <- mu_1
          for (age in c(5)) {
            for (mutation_rate in c(0.01)) {
              for (n_alignments in c(2)) {
                for (sequence_length in c(100)) {
                  mcmc_chainlength <- 1000000
                  filename <- paste(file_index,".RDa",sep="")
                  SaveParametersToFile(
                    rng_seed = rng_seed,
                    b_1 = b_1, 
                    b_2 = b_2,  
                    la_1 = la_1,  
                    mu_1 = mu_1,
                    mu_2 = mu_2,
                    age = age,
                    mutation_rate = mutation_rate,
                    n_alignments = n_alignments,
                    sequence_length = sequence_length,
                    mcmc_chainlength = mcmc_chainlength,
                    filename = filename
                  )
                  file_index <- file_index + 1
                }
              }
            }
          }
        }
      }
    }
  }
}    
    

#TestCreateParametersFiles()

#CreateParametersFiles()
