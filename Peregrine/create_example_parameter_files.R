# Step #1
# Creates files with filename [number].RDa that
# contain the parameters of interest.
source("~/GitHubs/R/Peregrine/save_parameters_to_file.R")
source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")
source("~/GitHubs/R/Peregrine/add_pbd_output.R")
source("~/GitHubs/R/Peregrine/add_species_trees_with_outgroup.R")
source("~/GitHubs/R/Peregrine/add_alignments.R")
source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")
source("~/GitHubs/R/Peregrine/show_posteriors.R")
source("~/GitHubs/R/Peregrine/add_posteriors.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.treeannotator.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/script.beast.R")
library(nLTT)
library(ape)
library(testit)

create_example_parameters_files <- function () {
  for (i in c(1,2)) {
    speciation_completion_rate <- 1000000.0
    if (i == 2) speciation_completion_rate <- 0.01
    
    save_parameters_to_file(
      rng_seed = 1,
      species_initiation_rate_good_species = 0.5, 
      species_initiation_rate_incipient_species = 0.5,  
      speciation_completion_rate = speciation_completion_rate,  
      extinction_rate_good_species = 0.1,
      extinction_rate_incipient_species = 0.1,
      age = 5,
      n_species_trees_samples = 1,
      mutation_rate = 0.01,
      n_alignments = 1,
      sequence_length = 1000,
      mcmc_chainlength = 1000000,
      n_beast_runs = 1,
      filename = paste("example",i,".RDa",sep="")
    )
  }
}

create_example_parameters_files()

for (i in c(1,2)) {

  filename <- paste("example",i,".RDa",sep="")
  trees_filename <- paste("example",i,"_1_1.trees",sep="")
  add_pbd_output(filename)  
  file <- read_file(filename)
  
  png(paste("example_",i,"_gene_tree.png",sep=""))
  plot(file$pbd_output[[1]], main = paste("Example ",i," gene tree",sep=""))
  dev.off()

  add_species_trees_with_outgroup(filename)  
  
  file <- read_file(filename)
  png(paste("example_",i,"_species_tree_with_outgroup.png",sep=""))
  plot(file$species_trees_with_outgroup[[1]][[1]], main = "Example 1 species tree with outgroup")
  dev.off()
  nLTT.plot(file$species_trees_with_outgroup[[1]][[1]],main="Example 1 species tree with outgroup")
  png(paste("example_",i,"_species_tree_with_outgroup_nltt.png",sep=""))
  nLTT.plot(file$species_trees_with_outgroup[[1]][[1]], main = "Example 1 species tree with outgroup")
  dev.off()
  
  add_alignments(filename, do_plot = FALSE)  
  file <- read_file(filename)
  png(paste("example_",i,"_alignment.png",sep=""))
  image(file$alignments[[1]][[1]], main="Example 1")
  dev.off()
  
  
  add_posteriors(filename)  
  
  # Analyse posterior
  # Read all trees from the BEAST2 posterior
  all_trees <- beast2out.read.trees(trees_filename)
  last_tree <- tail(all_trees,n=1)[[1]]
  
  png(paste("example_",i,"_posterior_sample.png",sep=""))
  plot(last_tree,main="Example 1 last tree in posterior")
  dev.off()
  
  png(paste("example_",i,"_posterior_sample_nltt.png",sep=""))
  nLTT.plot(last_tree,main="Example 1 last tree in posterior")
  dev.off()
  
  # Both nLTT
  png(paste("example_",i,"_both_nltts.png",sep=""))
  nLTT.plot(file$species_trees_with_outgroup[[1]][[1]],
    main="Example 1 species tree with outgroup nLTTs", lwd = 2
  )
  nLTT.lines(last_tree, lwd = 2, lty = 3)
  dev.off()
  
  nLTTstat(file$species_trees_with_outgroup[[1]][[1]],last_tree)
  
  all_nltt_stats <- NULL
  
  for (tree in all_trees)
  {
    all_nltt_stats = c(all_nltt_stats,nLTTstat(file$species_trees_with_outgroup[[1]][[1]],tree))
  }
  png(paste("example_",i,"_nltts_stats.png",sep=""))
  hist(all_nltt_stats,main="Distribution of nLTT statistics\nbetween species tree and posterior")
  dev.off()
}