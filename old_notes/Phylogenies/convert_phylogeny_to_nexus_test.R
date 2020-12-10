source("~/GitHubs/R/Phylogenies/create_random_alignment.R")
source("~/GitHubs/R/Phylogenies/convert_phylogeny_to_nexus.R")


convert_phylogeny_to_nexus_test <- function() {

  phylogeny <- rcoal(10)
  assert(class(phylogeny) == "phylo")
  plot(phylogeny)
  
  filename <- "~/convert_alignment_to_nexus_test.nexus"

  convert_phylogeny_to_nexus(phylogeny,filename)
  file.show(filename)
}

convert_phylogeny_to_nexus_test()
