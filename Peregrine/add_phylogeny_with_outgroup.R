source("~/GitHubs/R/Peregrine/install_libraries.R")
source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Peregrine/collect_files.R")

# InstallLibraries()
ReadLibraries()

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