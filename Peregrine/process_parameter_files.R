if (length(commandArgs(TRUE)) != 1) {
  print("Need one command-line argument.")
  print("Use, for example 'Rscript process_parameter_files parameters.txt'")
  quit()
}

parameters_filename <- commandArgs(TRUE)[1]

if (!file.exists(parameters_filename)) {
  print(paste("Parameters file ",parameters_filename," not found",sep=""))
  quit()
}

# The tarball must be extracted to check if the install will succeed
# system("R CMD check ~/GitHubs/Wip/RampalEtienne/R/PBD")
# system("R CMD INSTALL ~/GitHubs/Wip/RampalEtienne/R/PBD_1.1.tar.gz")

library(ape)
library(DDD)
library(plyr)
#library(phyloch) # From http://www.christophheibl.de/Rpackages.html
source("~/GitHubs/R/MyFavoritePackages/phyloch/R/write.phy.R") #Fixed bug
#source("~/GitHubs/R/MyFavoritePackages/phyloch/R/raxml.R") #Fixed bug
source("~/GitHubs/R/MyFavoritePackages/phyloch/R/raxml2.R") #Calls 'x' instead of './x'
library(geiger)
library(testit)
library(ape)
library(geiger)
library(phytools)
library(PBD)
library(testit)
library(RColorBrewer)
library(data.table)
library(phangorn)
library(nLTT);
source("~/GitHubs/R/Phylogenies/AddOutgroupToPhylogeny.R")
source("~/GitHubs/R/Phylogenies/ConvertPhylogenyToAlignments.R")
source("~/GitHubs/R/Phylogenies/ConvertAlignmentsToFasta.R")


can_install_devtools <- FALSE
if (can_install_devtools) {
  library(devtools)
  install_github("olli0601/rBEAST")
  print("olli0601 his rBEAST package installed from his GitHub")
} else {
  source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
  source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2.R")
  source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast.R")
  source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.treeannotator.R")
  source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/script.beast.R")
  print("olli0601 his rBEAST package loaded from this GitHub")
}

ReadParameters <- function(parameters_filename)
{
  assert(file.exists(parameters_filename))
  parameters <- readRDS(parameters_filename)
}

RunExperiment <- function(
  parameters_filename,
  do_plot = FALSE
)
{
  ###############################
  #
  # Read parameters from file
  # Create/extract all parameters
  # 
  ###############################
  parameters <- ReadParameters(parameters_filename)
  mutation_rate <- as.numeric(parameters$mutation_rate[2])
  sequence_length <- as.numeric(parameters$sequence_length[2])
  mcmc_chainlength <- as.numeric(parameters$mcmc_chainlength[2])
  output_filename <- gsub(".txt","_results.txt",parameters_filename)
    
  # File paths for BeastScripter
  beast_scripter_path <- "~/Programs/BeastScripter/BeastScripterConsole"
  base_filename <- "test_output_1"
  fasta_filename <- paste(base_filename,".fasta",sep="");
  beast_filename <- paste(base_filename,".xml",sep="");
  beast_path <- "~/Programs/BEAST/bin/beast"
  beast_log_filename <- paste(base_filename,".log",sep="");
  beast_trees_filename <- paste(base_filename,".trees",sep="");
  beast_state_filename <- paste(base_filename,".xml.state",sep="");
  
  assert(file.exists(beast_scripter_path))
  assert(file.exists(beast_path))
  
  ###############################
  #
  # Run the experiment
  #
  ###############################
  set.seed(parameters$rng_seed[2])
  
  # Create reconstructed protracted simulated tree
  b_1  <- as.numeric(parameters$b_1[2]) # the speciation-initiation rate of good species
  b_2  <- as.numeric(parameters$b_2[2]) # the speciation-initiation rate of incipient species 
  la_1 <- as.numeric(parameters$la_1[2]) # the speciation-completion rate 
  mu_1 <- as.numeric(parameters$mu_1[2]) # the extinction rate of good species 
  mu_2 <- as.numeric(parameters$mu_2[2]) # the extinction rate of incipient species 
  #age <- as.numeric(parameters$age[2])
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
  
  # Create simulated DNA from tree
  alignments <- ConvertPhylogenyToRandomAlignments(
    phylogeny_with_outgroup,sequence_length, 
    mutation_rate = 0.01
  )

  if (do_plot) {
    image(alignments)
  }
  
  # Save to FASTA file
  ConvertAlignmentsToFasta(alignments,fasta_filename)
  
  # Create BEAST2 parameter file from FASTA file and aparameters
  cmd <- paste(
    beast_scripter_path, 
    " --fasta ",fasta_filename,
    " --mcmc_length ",mcmc_chainlength,
    " --tree_prior ","birth_death",
    " --output_file ",beast_filename,
    " --silent",
    sep=""
  )
  system(cmd)
  assert(file.exists(beast_filename))
  
  # Run BEAST2, needs the BEAST2 .XML parameter file
  # Prevent BEAST prompting the user whether to overwrite the log file
  if (file.exists(beast_trees_filename)) { file.remove(beast_trees_filename) }
  if (file.exists(beast_log_filename)) { file.remove(beast_log_filename) }
  if (file.exists(beast_state_filename)) { file.remove(beast_state_filename) }
  
  cmd <- paste(
    beast_path, 
    " -seed ",parameters$rng_seed[2],
    " ",beast_filename,
    sep=""
  )
  system(cmd)
  assert(file.exists(beast_trees_filename))
  assert(file.exists(beast_log_filename))
  assert(file.exists(beast_state_filename))
  
  ###############################
  #
  # Save the results to file
  #
  ###############################
  
  # Analyse posterior
  # Read all trees from the BEAST2 posterior
  all_trees <- beast2out.read.trees(beast_trees_filename)
    
  my_list <- list(
    parameters,
    all_trees
  )
  names(my_list) <- c("parameters","posterior")
  saveRDS(my_list,file=output_filename)
  
  # last_tree <- tail(all_trees,n=1)[[1]]
  # plot(last_tree,main="Last tree in posterior")
  # 
  # all_nltt_stats <- NULL
  # for (tree in all_trees)
  # {
  #   all_nltt_stats = c(all_nltt_stats,nLTTstat(phylogeny_with_outgroup,tree))
  # }
  # hist(all_nltt_stats)
  # 
  # # Plot the original and last of the posterior's tree
  # n_cols <- 1
  # n_rows <- 2
  # par(mfrow=c(n_rows,n_cols))
  # plot(phylogeny_with_outgroup,main="Truth")
  # add.scale.bar()
  # plot(last_tree,main="Inferred")
  # add.scale.bar()
  # par(mfrow=c(1,1))
  
  # for (tree in all_trees) { plot(tree) }
  
  # Plot concensus tree
  # densiTree(all_trees)
  # ?densiTree
}

RunExperiment("~/1.txt")
