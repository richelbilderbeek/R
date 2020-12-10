source("~/GitHubs/R/Phylogenies/get_genetic_distance.R")
source("~/GitHubs/R/Phylogenies/create_random_alignment.R")
source("~/GitHubs/R/Phylogenies/convert_newick_to_phylogeny.R")
source("~/GitHubs/R/Phylogenies/is_phylogeny.R")
source("~/GitHubs/R/Phylogenies/convert_phylogeny_to_alignment.R")

library(ape)
library(testit)

get_genetic_distance_test <- function(
) {
  phylogeny <- convert_newick_to_phylogeny("((A:1,B:1):1,D:2);")
  assert(is_phylogeny(phylogeny))
  
  alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny,
    sequence_length = 100, 
    mutation_rate = 0.1
  )
  
  image(alignment)
  d <- get_genetic_distance(alignment, model = "JC69")
  print(d)

  dist_ab <- d[1][1]
  dist_ac <- d[2][1]
}

get_genetic_distance_test()
