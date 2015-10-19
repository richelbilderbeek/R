library(ape);
library(geiger);
library(phangorn);
source("~/GitHubs/R/Phylogenies/ConvertPhylogenyToAlignment.R")
source("~/GitHubs/R/Phylogenies/CreateRandomAlignment.R")
source("~/GitHubs/R/Phylogenies/AddOutgroupToPhylogeny.R")
source("~/GitHubs/R/Phylogenies/ConvertAlignmentToFasta.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.treeannotator.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/script.beast.R")

# alignment_dnabin <- CreateRandomAlignment(5,10)
# mcmc_chainlength = 10000
#rng_seed <- 42
ConvertAlignmentToBeastPosterior <- function(
  alignment_dnabin,
  mcmc_chainlength,
  rng_seed = 42
) {

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

  # Save to FASTA file
  ConvertAlignmentToFasta(alignment_dnabin,fasta_filename)

  options(scipen = 20) # So that mcmc_chainlength is written as 1000000 instead of 1e+7
  
  # Create BEAST2 parameter file from FASTA file and parameters
  cmd <- paste(
    beast_scripter_path, 
    " --fasta ",fasta_filename,
    " --mcmc_length ",mcmc_chainlength,
    " --tree_prior ","birth_death",
    " --output_file ",beast_filename,
    sep=""
  )
  print(paste("ConvertAlignmentToBeastPosterior: Executing command: ",cmd,sep=""))
  system(cmd)
  assert(file.exists(beast_filename))
  
  # Run BEAST2, needs the BEAST2 .XML parameter file
  # Prevent BEAST prompting the user whether to overwrite the log file
  if (file.exists(beast_trees_filename)) { file.remove(beast_trees_filename) }
  if (file.exists(beast_log_filename)) { file.remove(beast_log_filename) }
  if (file.exists(beast_state_filename)) { file.remove(beast_state_filename) }
  
  cmd <- paste(
    beast_path, 
    " -seed ",rng_seed,
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
  posterior <- beast2out.read.trees(beast_trees_filename)
}  


DemonstrateConvertAlignmentToBeastPosterior <- function() {

  phylogeny_without_outgroup <- CreateRandomPhylogeny(n_taxa = 5)

  phylogeny_with_outgroup <- AddOutgroupToPhylogeny(
    phylogeny_without_outgroup,
    stem_length = 0
  )
  alignment <- ConvertPhylogenyToAlignment(
    phylogeny = phylogeny_with_outgroup,
    sequence_length = 10
  )
  image(alignment)
  posterior <- ConvertAlignmentToBeastPosterior(
    alignment,
    mcmc_chainlength = 10000,
    rng_seed = 42
  )
  last_tree <- tail(posterior,n=1)[[1]]
  plot(last_tree,main="Last tree in posterior")
  
  all_nltt_stats <- NULL
  for (tree in posterior)
  {
    all_nltt_stats = c(all_nltt_stats,nLTTstat(phylogeny_with_outgroup,tree))
  }
  
  hist(all_nltt_stats)
}

# Uncomment this to view the function demonstration
#DemonstrateConvertAlignmentToBeastPosterior()
