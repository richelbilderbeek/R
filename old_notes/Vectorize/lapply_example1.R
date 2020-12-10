library(plyr)
library(dplyr)
library(TreeSim)
library(testit)

x <- c(1,2,3)

laply(x, function(x) { x * 2} )
?laply


phylogenies <- TreeSim::sim.bd.age(15, numbsim = 10, lambda = 0.5, mu = 0.5)
phylogenies <- lapply(phylogenies, FUN = function(x) { class(x) <- "phylo"; return (x) } )
class(phylogenies) <- "multiPhylo"
assert(class(phylogenies) == "multiPhylo")
assert(class(phylogenies[[1]]) == "phylo")



x <- list(5,3)
x
x < 4
x <- x[ x < 4]
x



n_trees <- 100
n_tips <- 200
set.seed(41)
treesim_phylogenies <- TreeSim::sim.bd.age(6, numbsim = n_trees, lambda = 0.5, mu = 0.0, complete = FALSE)
?dplyr::filter
dplyr::filter_(treesim_phylogenies, function(x) { return (class(x) == "phylo") } )
