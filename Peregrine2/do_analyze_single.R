source("~/GitHubs/R/FileIo/get_base_filename.R")

source("~/GitHubs/R/Peregrine/save_parameters_to_file.R")
source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")
source("~/GitHubs/R/Peregrine/add_pbd_output.R")
source("~/GitHubs/R/Peregrine/add_species_trees_with_outgroup.R")
source("~/GitHubs/R/Peregrine/add_alignments.R")
source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")
source("~/GitHubs/R/Peregrine/show_posteriors.R")
source("~/GitHubs/R/Peregrine/add_posteriors.R")
source("~/GitHubs/R/Phylogenies/get_average_nltt.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.treeannotator.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/script.beast.R")
library(nLTT)
library(ape)
library(testit)

do_analyze_single <- function(filename) {
  if (!file.exists(filename)) {
    print(paste(filename,": not found"))
    stop()
  }
  assert(file.exists(filename))
  base_filename <- get_base_filename(filename)
  file <- read_file(filename)
  
  # There is always one gene tree
  png(paste(base_filename,"_gene_tree.png",sep=""))
  plot(file$pbd_output[[1]], main = paste(base_filename," gene tree",sep=""))
  dev.off()
  
  # There are n_species_trees_sampled species trees
  n_species_trees_samples <- as.numeric(file$parameters$n_species_trees_samples[2])
  for (i in seq(1,n_species_trees_samples)) {
    png(paste(base_filename,"_species_tree_with_outgroup_",i,".png",sep=""))
    plot(file$species_trees_with_outgroup[[1]][[1]], main = paste(base_filename,"species tree with outgroup",i))
    dev.off()

    png(paste(base_filename,"_species_tree_with_outgroup_nltt_",i,".png",sep=""))
    nLTT.plot(file$species_trees_with_outgroup[[1]][[1]], main = paste(base_filename,"species tree with outgroup",i))
    dev.off()
  }
  
  n_alignments <- as.numeric(file$parameters$n_alignments[2])
  for (i in seq(1,n_species_trees_samples)) {
    for (j in seq(1,n_alignments)) {
      png(paste(base_filename,"_alignment_",i,"_",j,".png",sep=""))
      image(file$alignments[[1]][[1]], main=paste(base_filename,"alignment"))
      dev.off()
    }
  }

  n_beast_runs <- as.numeric(file$parameters$n_beast_runs[2])
  trees_filename <- paste(base_filename,"_1_1.trees",sep="")
  
  # Analyse posterior
  # Read all trees from the BEAST2 posterior
  all_trees <- beast2out.read.trees(trees_filename)
  last_tree <- tail(all_trees,n=1)[[1]]
  
  png(paste(base_filename,"_posterior_average_nltt.png",sep=""))
  get_average_nltt(all_trees)
  dev.off()
  png(paste(base_filename,"_posterior_sample.png",sep=""))
  plot(last_tree,main=paste(base_filename,"last tree in posterior"))
  dev.off()
  
  png(paste(base_filename,"_posterior_sample_nltt.png",sep=""))
  nLTT.plot(last_tree,main=paste(base_filename,"last tree in posterior"))
  dev.off()
  
  # Both nLTT
  png(paste(base_filename,"_both_nltts.png",sep=""))
  nLTT.plot(file$species_trees_with_outgroup[[1]][[1]],
    main=base_filename,"species tree with outgroup nLTTs", lwd = 2
  )
  nLTT.lines(last_tree, lwd = 2, lty = 3)
  dev.off()
  
  print(nLTTstat(file$species_trees_with_outgroup[[1]][[1]],last_tree))
  
  all_nltt_stats <- NULL
  
  for (tree in all_trees)
  {
    all_nltt_stats <- c(all_nltt_stats,nLTTstat(file$species_trees_with_outgroup[[1]][[1]],tree))
  }
  
  png(paste(base_filename,"_nltts_stats.png",sep=""))
  hist(all_nltt_stats,xlim=c(0,0.12),main=paste(base_filename," distribution of nLTT statistics\nbetween species tree and posterior"))
  dev.off()

  png(paste(base_filename,"_posterior_average_nltt.png",sep=""))
  get_average_nltt(all_trees,replot = FALSE,lty=3,lwd = 2, main=paste(base_filename," posterior average nLTT"))
  get_average_nltt(
    list(file$species_trees_with_outgroup[[1]][[1]],file$species_trees_with_outgroup[[1]][[1]]),
    replot = TRUE,lty=1,lwd = 2)
  dev.off()
  
}

do_analyze_single("example_3.RDa")
