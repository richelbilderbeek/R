library(ape)
library(nLTT)
source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")
source("~/GitHubs/R/Peregrine/show_posteriors.R")
  source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
  source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2.R")
  source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast.R")
  source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.treeannotator.R")
  source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/script.beast.R")

rda_filename <- "~/Slurm/24.RDa"
trees_filename <- "~/Slurm/24_1_1.trees"

file <- load_parameters_from_file(rda_filename)
print(t(file$parameters[c(2),]))

plot(file$species_trees_with_outgroup[[1]][[1]],main="Original species tree")
nLTT.plot(file$species_trees_with_outgroup[[1]][[1]],main="Original species tree")



# Analyse posterior
# Read all trees from the BEAST2 posterior
all_trees <- beast2out.read.trees(trees_filename)
last_tree <- tail(all_trees,n=1)[[1]]
plot(last_tree,main="Last tree in posterior")
nLTT.plot(last_tree,main="Last tree in posterior")

all_nltt_stats <- NULL
for (tree in all_trees)
{
  all_nltt_stats = c(all_nltt_stats,nLTTstat(file$species_trees_with_outgroup[[1]][[1]],tree))
}
hist(all_nltt_stats,main="Distribution of nLTT statistics\nbetween species tree and posterior")

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
