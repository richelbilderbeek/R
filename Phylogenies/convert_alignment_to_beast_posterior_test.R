source("~/GitHubs/R/Phylogenies/add_outgroup_to_phylogeny.R")
source("~/GitHubs/R/Phylogenies/create_random_phylogeny.R")
source("~/GitHubs/R/Phylogenies/convert_phylogeny_to_alignment.R")
source("~/GitHubs/R/Phylogenies/convert_alignment_to_beast_posterior.R")
source("~/GitHubs/R/Phylogenies/is_phylogeny.R")
library(nLTT)

convert_alignment_to_beast_posterior_test <- function() {

  phylogeny_without_outgroup <- create_random_phylogeny(n_taxa = 5)

  assert(is_phylogeny(phylogeny_without_outgroup))
  
  phylogeny_with_outgroup <- add_outgroup_to_phylogeny(
    phylogeny_without_outgroup,
    stem_length = 0
  )


  assert(is_phylogeny(phylogeny_with_outgroup))
  
  alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny_with_outgroup,
    sequence_length = 10
  )

  assert(is_alignment(alignment))
  
  image(alignment)
  
  base_filename <- "convert_alignment_to_beast_posterior_test"

  if (file.exists(paste(base_filename,".log",sep=""))) {
    file.remove(paste(base_filename,".log",sep=""))  
  }
  if (file.exists(paste(base_filename,".trees",sep=""))) {
    file.remove(paste(base_filename,".trees",sep=""))  
  }
  if (file.exists(paste(base_filename,".xml.state",sep=""))) {
    file.remove(paste(base_filename,".xml.state",sep=""))  
  }
  
  assert(!file.exists(paste(base_filename,".log",sep="")))
  assert(!file.exists(paste(base_filename,".trees",sep="")))
  assert(!file.exists(paste(base_filename,".xml.state",sep="")))
  
  posterior <- convert_alignment_to_beast_posterior(
    alignment,
    mcmc_chainlength = 10000,
    base_filename = base_filename,
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

convert_alignment_to_beast_posterior_test()
