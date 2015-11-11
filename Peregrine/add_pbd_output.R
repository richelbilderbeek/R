source("~/GitHubs/R/Peregrine/read_libraries.R")

# InstallLibraries()
ReadLibraries()

AddPbdOutput <- function(
  filename,
  do_plot = FALSE
) {
  file <- ReadFile(filename)
  assert(mode(file) == "list")
  
  # If it already contains 'pbd_output' this has already been done
  if(!is.null(file$pbd_output)) {
    print(paste("file ",filename," already has a pbd_output",sep=""))
    return ()
  }
  
  assert(!is.null(file$parameters))
  assert(is.null(file$pbd_output))

  # Read parameters
  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2]) # the extinction rate of incipient species 
  species_initiation_rate_good_species  <- as.numeric(parameters$species_initiation_rate_good_species[2])
  species_initiation_rate_incipient_species  <- as.numeric(parameters$species_initiation_rate_incipient_species[2]) # the speciation-initiation rate of incipient species 
  speciation_completion_rate <- as.numeric(parameters$speciation_completion_rate[2]) # the speciation-completion rate 
  extinction_rate_good_species <- as.numeric(parameters$extinction_rate_good_species[2]) # the extinction rate of good species 
  extinction_rate_incipient_species <- as.numeric(parameters$extinction_rate_incipient_species[2]) # the extinction rate of incipient species 
  age <- as.numeric(parameters$age[2]) 
  
  # Create the tree without outgroup
  set.seed(rng_seed)

  #do_plot <- FALSE
  pbd_output <-pbd_sim(c(species_initiation_rate_good_species,speciation_completion_rate,species_initiation_rate_incipient_species,extinction_rate_good_species,extinction_rate_incipient_species),age=as.numeric(parameters$age[2]),soc=2,plot=do_plot)

  if (do_plot) {
    par(mfrow=c(1,1)) # Bug fix of https://github.com/richelbilderbeek/Wip/issues/20
  }
  
  phylogeny <- pbd_output$tree
  
  assert(is.rooted(phylogeny))
  assert(is.ultrametric(phylogeny))
  if (do_plot) {
    plot(phylogeny,main="True tree")
    add.scale.bar()
  }
  
  file <- c(file,list(pbd_output))
  names(file)[ length(file) ] <- "pbd_output"
  assert(file$parameters == parameters)
  assert(all.equal(file$pbd_output,pbd_output))

  # Append the pbd_output to file
  saveRDS(file,file=filename)

  file_again <- readRDS(filename)
  assert(file_again$parameters == parameters)
  assert(all.equal(file_again$pbd_output,pbd_output))

  assert(!is.null(file$pbd_output))
  print(paste("file ",filename," has gotten has its pbd_output",sep=""))
}