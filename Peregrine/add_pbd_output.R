source("~/GitHubs/R/Peregrine2/is_valid_file.R")
source("~/GitHubs/R/Peregrine/read_file.R")
source("~/GitHubs/R/Phylogenies/is_pbd_sim_output.R")
library(testit)
library(PBD)

add_pbd_output <- function(filename) {
  assert(is_valid_file(filename))
  file <- read_file(filename)
  assert(mode(file) == "list")
  
  # If it already contains 'pbd_output' this has already been done
  if(is_pbd_sim_output(file$pbd_output)) {
    print(paste("file ",filename," already has a pbd_output",sep=""))
    return ()
  }
  print(paste("Adding pbd_output to file ",filename,sep=""))

  # Read parameters
  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2])
  species_initiation_rate_good_species  <- as.numeric(parameters$species_initiation_rate_good_species[2])
  species_initiation_rate_incipient_species  <- as.numeric(parameters$species_initiation_rate_incipient_species[2])
  speciation_completion_rate <- as.numeric(parameters$speciation_completion_rate[2])
  extinction_rate_good_species <- as.numeric(parameters$extinction_rate_good_species[2])
  extinction_rate_incipient_species <- as.numeric(parameters$extinction_rate_incipient_species[2])
  age <- as.numeric(parameters$age[2]) 
  
  # Create the tree without outgroup
  print(paste(" * Setting seed ", rng_seed, sep=""))
  set.seed(rng_seed)
  
  pbd_output <- pbd_sim(c(species_initiation_rate_good_species,speciation_completion_rate,species_initiation_rate_incipient_species,extinction_rate_good_species,extinction_rate_incipient_species),age=as.numeric(parameters$age[2]),soc=2,plot=FALSE)

  assert(is_pbd_sim_output(pbd_output))

  phylogeny <- pbd_output$tree
  
  assert(is.rooted(phylogeny))
  assert(is.ultrametric(phylogeny))
  assert(!is_pbd_sim_output(file$pbd_output))

  file$pbd_output <- pbd_output
  
  assert(is_pbd_sim_output(file$pbd_output))
  assert(all.equal(file$pbd_output,pbd_output))

  # Append the pbd_output to file
  saveRDS(file,file=filename)

  # Check file integrity
  file_again <- readRDS(filename)
  assert(file_again$parameters == parameters)
  assert(all.equal(file_again$pbd_output,pbd_output))
  
  assert(!is.na(file$pbd_output[1])) #The purpose of this function
  print(paste("Added pbd_output to file ",filename,sep=""))
}