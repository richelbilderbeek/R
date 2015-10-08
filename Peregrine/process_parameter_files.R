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

parameters <- readRDS(parameters_filename)


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

###############################
#
# Model parameters
#
###############################
rng_seed <- 42
b_1  <- 0.2 # the speciation-initiation rate of good species
b_2  <- 0.2 # the speciation-initiation rate of incipient species 
la_1 <- 1.0 # the speciation-completion rate 
mu_1 <- 0.1 # the extinction rate of good species 
mu_2 <- 0.1 # the extinction rate of incipient species 
age <- 15
mutation_rate <- 0.1
sequence_length <- 100
n_tree_searches <- 10
n_bootstrap_replicates <- 10
mcmc_chainlength <- 10000

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
# Model script
#
###############################
set.seed(rng_seed)

# Create reconstructed protracted simulated tree
tree_full <-pbd_sim(c(b_1,la_1,b_2,mu_1,mu_2),age,soc=2,plot=0)
par(mfrow=c(1,1)) # Bug fix of https://github.com/richelbilderbeek/Wip/issues/20

phylogeny <- tree_full$tree
assert(is.rooted(phylogeny))
assert(is.ultrametric(phylogeny))
plot(phylogeny,main="True tree")
add.scale.bar()

# Add an outgroup
phylogeny_with_outgroup <- AddOutgroupToPhylogeny(phylogeny,stem_length = 0)
plot(phylogeny_with_outgroup)
add.scale.bar(x=0,y=length(phylogeny_with_outgroup$tip.label))

# Create simulated DNA from tree
alignments <- ConvertPhylogenyToRandomAlignments(
  phylogeny_with_outgroup,sequence_length, 
  mutation_rate = 0.01
)
image(alignments)

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
  " -seed ",rng_seed,
  " ",beast_filename,
  sep=""
)
system(cmd)
assert(file.exists(beast_trees_filename))
assert(file.exists(beast_log_filename))
assert(file.exists(beast_state_filename))

# Analyse posterior
# Read all trees from the BEAST2 posterior
all_trees <- beast2out.read.trees(beast_trees_filename)
last_tree <- tail(all_trees,n=1)[[1]]
plot(last_tree,main="Last tree in posterior")

all_nltt_stats <- NULL
for (tree in all_trees)
{
  all_nltt_stats = c(all_nltt_stats,nLTTstat(phylogeny_with_outgroup,tree))
}
hist(all_nltt_stats)

# Plot the original and last of the posterior's tree
n_cols <- 1
n_rows <- 2
par(mfrow=c(n_rows,n_cols))
plot(phylogeny_with_outgroup,main="Truth")
add.scale.bar()
plot(last_tree,main="Inferred")
add.scale.bar()
par(mfrow=c(1,1))

# for (tree in all_trees) { plot(tree) }

# Plot concensus tree
# densiTree(all_trees)
# ?densiTree
