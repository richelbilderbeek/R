library(ape);
library(geiger);
library(phangorn);
source("~/GitHubs/R/Phylogenies/AddOutgroupToPhylogeny.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.treeannotator.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/script.beast.R")

# One of the many ways to create a random phylogeny
CreateRandomPhylogeny <- function(n_taxa) {
  phylogeny <- rcoal(n_taxa)
}

# Create a random alignment
CreateRandomAlignment <- function(n_taxa,sequence_length) {
  phylogeny <- CreateRandomPhylogeny(n_taxa)
  alignment_phydat <- simSeq(phylogeny,l=sequence_length)
  alignment_dnabin <- as.DNAbin(alignment_phydat)
}

# Create a random FASTA file text
ConvertAlignmentToFasta <- function(alignment_dnabin,filename) {
  write.phyDat(alignment_dnabin, file=filename, format="fasta")
}

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
  
  # Create BEAST2 parameter file from FASTA file and parameters
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
  HEIRO phylogeny_with_outgroup <- AddOutgroupToPhylogeny(phylogeny_without_outgroup)
  alignment <- CreateAlignmentFromPhylogeny(
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
