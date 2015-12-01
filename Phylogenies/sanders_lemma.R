# Solve Sander's lemma:
#
# Imagine a phylogeny like this:
#
#       +---+ A
#   +---+
#   |   +---+ B
#   |
#   +-------+ D
#
# There need to be alignments made with either AB and AD
#
# This can be done in two ways:
# 1) Create subphylogenies first, then create alignments from this
# 2) Create alignment of complete phylogeny first, then take the sub alignments
#
# Sander's lemma is that this possibly yields different variances in the alignments
# 
# Conclusion: both ways are equivalent, as they give give identical genetic distances

source("~/GitHubs/R/Phylogenies/convert_newick_to_phylogeny.R")


source("~/GitHubs/R/Phylogenies/get_genetic_distance.R")
source("~/GitHubs/R/Phylogenies/create_random_alignment.R")
source("~/GitHubs/R/Phylogenies/convert_newick_to_phylogeny.R")
source("~/GitHubs/R/Phylogenies/is_phylogeny.R")
source("~/GitHubs/R/Phylogenies/convert_phylogeny_to_alignment.R")

library(ape)
library(testit)

get_genetic_distances_same_alignment <- function(
) {
  phylogeny <- convert_newick_to_phylogeny("((A:1,B:1):1,D:2);")
  assert(is_phylogeny(phylogeny))
  
  alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny,
    sequence_length = 100, 
    mutation_rate = 0.1
  )
  
  #image(alignment)
  d <- get_genetic_distance(alignment, model = "JC69")

  dist_ab <- d[1][1]
  dist_ad <- d[2][1]
  output <- c(dist_ab,dist_ad)
  names(output) <- c("AB","AD")
  return (output)
}

get_genetic_distances_different_trees <- function(
) {
  phylogeny_ab <- convert_newick_to_phylogeny("(A:1,B:1);")
  phylogeny_ad <- convert_newick_to_phylogeny("(A:2,D:2);")
  
  assert(is_phylogeny(phylogeny_ab))
  assert(is_phylogeny(phylogeny_ad))
  
  alignment_ab <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny_ab,
    sequence_length = 100, 
    mutation_rate = 0.1
  )
  alignment_ad <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny_ad,
    sequence_length = 100, 
    mutation_rate = 0.1
  )

  ab <- get_genetic_distance(alignment_ab, model = "JC69")
  ad <- get_genetic_distance(alignment_ad, model = "JC69")
  
  dist_ab <- ab[1][1]
  dist_ad <- ad[1][1]
  output <- c(dist_ab,dist_ad)
  names(output) <- c("AB","AD")
  return (output)
}


sander_lemma <- function() {
  n_repeats <- 1000
  
  ds_same <- NULL
  for (i in seq(1:n_repeats)) {
    ds_same <- rbind(ds_same,get_genetic_distances_same_alignment())
  }
  ds_diff <- NULL
  for (i in seq(1:n_repeats)) {
    ds_diff <- rbind(ds_diff,get_genetic_distances_different_trees())
  }
  #print(ds_same)  
  #print(ds_diff)  

  mean_ab_same <- mean(ds_same[,1])
  mean_ab_diff <- mean(ds_diff[,1])
  print(paste("mean_ab_same: ", mean_ab_same, sep=""))
  print(paste("mean_ab_diff: ", mean_ab_diff, sep=""))

  variance_ab_same <- var(ds_same[,1])
  variance_ab_diff <- var(ds_diff[,1])
  print(paste("variance_ab_same: ", variance_ab_same, sep=""))
  print(paste("variance_ab_diff: ", variance_ab_diff, sep=""))

  mean_ad_same <- mean(ds_same[,2])
  mean_ad_diff <- mean(ds_diff[,2])
  print(paste("mean_ad_same: ", mean_ad_same, sep=""))
  print(paste("mean_ad_diff: ", mean_ad_diff, sep=""))
  
  variance_ad_same <- var(ds_same[,2])
  variance_ad_diff <- var(ds_diff[,2])
  print(paste("variance_ad_same: ", variance_ad_same, sep=""))
  print(paste("variance_ad_diff: ", variance_ad_diff, sep=""))

  plot(jitter(ds_same), col = "red", pch = 19, cex = 0.5)
  points(jitter(ds_diff), col = "blue", pch = 19, cex = 0.5)
  
}

sander_lemma()