library(testit)
source("~/GitHubs/R/Phylogenies/convert_alignment_to_nexus.R")
source("~/GitHubs/R/Phylogenies/convert_phylogeny_to_alignment.R")
source("~/GitHubs/R/Phylogenies/create_random_alignment.R")


convert_alignment_to_nexus_test <- function() {

  p <- rcoal(10)
  assert(class(p) == "phylo")
  plot(p)
  
  set.seed(3)
  a <- convert_phylogeny_to_alignment(
    phylogeny = p,
    sequence_length = 1000,
    mutation_rate = 0.05
  )
  image(a)
  
  filename <- "~/convert_alignment_to_nexus_test.nexus"
  
  
  convert_alignment_to_nexus(alignment = a,filename)
  file.show(filename)
}

convert_alignment_to_nexus_test()
