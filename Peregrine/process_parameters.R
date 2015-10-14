# Step #2
# Reads parameter file '[number].RDa'. If that file has no $data
# sections, it adds simulated data

#
# Simulated data:
#  * original tree
#  * mutiple sequence alignments

source("~/GitHubs/R/Peregrine/install_libraries.R")
source("~/GitHubs/R/Peregrine/read_libraries.R")

# InstallLibraries()
ReadLibraries()

CollectFiles <- function() {
  files <- list.files(
    path = ".", 
    pattern = ".RDa",
  )
}

ReadFile <- function(filename)
{
  assert(file.exists(filename))
  file <- readRDS(filename)
}

AddPhylogenyWithOutgroup <- function(
  filename,
  do_plot = FALSE
) {
  file <- ReadFile(filename)
  assert(mode(file) == "list")
  
  # If it already contains 'phylogeny_with_outgroup' this has already been done
  if(!is.null(file$phylogeny_with_outgroup)) {
    print(paste("file ",filename," already has a phylogeny_with_outgroup",sep=""))
    return ()
  }
  
  assert(!is.null(file$parameters))
  assert(is.null(file$phylogeny_with_outgroup))

  # Read parameters
  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2]) # the extinction rate of incipient species 
  b_1  <- as.numeric(parameters$b_1[2]) # the speciation-initiation rate of good species
  b_2  <- as.numeric(parameters$b_2[2]) # the speciation-initiation rate of incipient species 
  la_1 <- as.numeric(parameters$la_1[2]) # the speciation-completion rate 
  mu_1 <- as.numeric(parameters$mu_1[2]) # the extinction rate of good species 
  mu_2 <- as.numeric(parameters$mu_2[2]) # the extinction rate of incipient species 
  
  # Create the tree without outgroup
  set.seed(rng_seed)
  tree_full <-pbd_sim(c(b_1,la_1,b_2,mu_1,mu_2),age=as.numeric(parameters$age[2]),soc=2,plot=do_plot)

  if (do_plot) {
    par(mfrow=c(1,1)) # Bug fix of https://github.com/richelbilderbeek/Wip/issues/20
  }
  
  phylogeny <- tree_full$tree
  assert(is.rooted(phylogeny))
  assert(is.ultrametric(phylogeny))
  if (do_plot) {
    plot(phylogeny,main="True tree")
    add.scale.bar()
  }
  
  # Add an outgroup
  phylogeny_with_outgroup <- AddOutgroupToPhylogeny(phylogeny,stem_length = 0)

  if (do_plot) {
    plot(phylogeny_with_outgroup)
    add.scale.bar(x=0,y=length(phylogeny_with_outgroup$tip.label))
  }
  
  file <- c(file,list(phylogeny_with_outgroup))
  names(file)[ length(file) ] <- "phylogeny_with_outgroup"
  names(file)
  assert(file$parameters == parameters)
  assert(all.equal(file$phylogeny_with_outgroup,phylogeny_with_outgroup))

  # Append the phylogeny_with_outgroup to file
  saveRDS(file,file=filename)

  file_again <- readRDS(filename)
  assert(file_again$parameters == parameters)
  assert(all.equal(file_again$phylogeny_with_outgroup,phylogeny_with_outgroup))

  assert(!is.null(file$phylogeny_with_outgroup))
  print(paste("file ",filename," has gotten has a phylogeny_with_outgroup",sep=""))
}

AddAlignments <- function(
  filename,
  do_plot = FALSE
)
{
  file <- ReadFile(filename)
  assert(mode(file) == "list")
  
  # If it already contains 'alignments' this has already been done
  if(!is.null(file$alignments)) {
    print(paste("file ",filename," already has its alignments",sep=""))
    return ()
  }
  
  assert(!is.null(file$parameters))
  assert(!is.null(file$phylogeny_with_outgroup))
  assert(is.null(file$alignments))
  

  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2]) # the extinction rate of incipient species 
  mutation_rate <- as.numeric(parameters$mutation_rate[2])
  n_alignments <- as.numeric(parameters$n_alignments[2])
  sequence_length <- as.numeric(parameters$sequence_length[2])

  set.seed(rng_seed)

  # Create simulated DNA from tree
  alignments <- NULL
  for (i in n_alignments) {
    alignment <- ConvertPhylogenyToRandomAlignments(
      phylogeny = file$phylogeny_with_outgroup,
      sequence_length = sequence_length, 
      mutation_rate = mutation_rate
    )

    if (do_plot) {
      image(alignments)
    }
    assert(alignment == alignment)
    alignments <- c(alignments,alignment)
  }
  assert(alignments == alignments)
  
  # Add it to the file
  file <- c(file,list(alignments))
  names(file)[ length(file) ] <- "alignments"
  names(file)
  assert(file$parameters == parameters)
  assert(file$alignments == alignments)

  # Save the file
  saveRDS(file,file=filename)

  file_again <- readRDS(filename)
  assert(file_again$parameters == parameters)
  assert(file_again$alignments == alignments)

  assert(!is.null(file$alignments))
  print(paste("file ",filename," has gotten its ", n_alignments, "alignments",sep=""))
}


#filename = "1.RDa"
#do_plot = FALSE


AddPosteriors <- function(
  filename,
  do_plot = FALSE
)
{
  file <- ReadFile(filename)
  assert(mode(file) == "list")
  
  # If it already contains 'posterior' this has already been done
  if(!is.null(file$posterior)) {
    print(paste("file ",filename," already has its posteriors",sep=""))
    return ()
  }
  
  assert(!is.null(file$parameters))
  assert(!is.null(file$phylogeny_with_outgroup))
  assert(!is.null(file$alignments))
  assert(is.null(file$posterior))

  parameters <- file$parameters
  mcmc_chainlength <- as.numeric(parameters$mcmc_chainlength[2])
  alignments <- file$alignments
  assert(length(n_alignments) > 0)

  posteriors <- NULL
  for (alignment in alignments) {
    posterior <- ConvertAlignmentToBeastPosterior(
      alignment = alignment,
      mcmc_chainlength = mcmc_chainlength,
      rng_seed = rng_seed
    )
    assert(all.equal(posterior,posterior))
    posteriors <- c(posteriors,posterior)
  }
  assert(all.equal(posteriors,posteriors))
  assert(length(posteriors) == length(alignments))
  
  # Add it to the file
  file <- c(file,list(posteriors))
  names(file)[ length(file) ] <- "posteriors"
  names(file)
  assert(file$parameters == parameters)
  assert(all.equal(file$posteriors,posteriors))

  # Save the file
  saveRDS(file,file=filename)

  file_again <- readRDS(filename)
  assert(file_again$parameters == parameters)
  assert(all.equal(file_again$posteriors,posteriors))

  assert(!is.null(file$posteriors))
  print(paste("file ",filename," has gotten its posteriors",sep=""))
}

print("Creating phylognies from parameters")
for (parameter_filename in CollectFiles()) {
  AddPhylogenyWithOutgroup(paste("~/",parameter_filename,sep=""))  
}

print("Creating alignments from phylogenies")
for (parameter_filename in CollectFiles()) {
  AddAlignments(paste("~/",parameter_filename,sep=""))  
}

AddPosteriors("~/1.RDa")

print("Creating posterioirs from alignments")
for (parameter_filename in CollectFiles()) {
  AddPosteriors(paste("~/",parameter_filename,sep=""))  
  #RunExperiment(paste("~/",parameter_filename,sep=""))  
}
