source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/Peregrine/read_file.R")
source("~/GitHubs/R/Phylogenies/is_pbd_sim_output.R")
library(PBD)
library(testit)

add_pbd_output <- function(filename) {
  assert(is_valid_file(filename))
  file <- read_file(filename)
  if(is_pbd_sim_output(file$pbd_output)) {
    print(paste("file ",filename," already has a pbd_output",sep=""))
    return ()
  }
  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2])
  species_initiation_rate_good_species  <- as.numeric(parameters$species_initiation_rate_good_species[2])
  species_initiation_rate_incipient_species  <- as.numeric(parameters$species_initiation_rate_incipient_species[2])
  speciation_completion_rate <- as.numeric(parameters$speciation_completion_rate[2])
  extinction_rate_good_species <- as.numeric(parameters$extinction_rate_good_species[2])
  extinction_rate_incipient_species <- as.numeric(parameters$extinction_rate_incipient_species[2])
  age <- as.numeric(parameters$age[2]) 
  set.seed(rng_seed)
  #pbd_output <- pbd_sim(c(
  file$pbd_output <- pbd_sim(c(
    species_initiation_rate_good_species,
    speciation_completion_rate,
    species_initiation_rate_incipient_species,
    extinction_rate_good_species,
    extinction_rate_incipient_species
  ),age=as.numeric(parameters$age[2]),soc=2,plot=FALSE)
  #phylogeny <- pbd_output$tree
  #file$pbd_output <- pbd_output
  saveRDS(file,file=filename)
  print(paste("Added pbd_output to file ",filename,sep=""))
}