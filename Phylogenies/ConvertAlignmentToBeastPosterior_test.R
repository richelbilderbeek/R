source("~/GitHubs/R/Phylogenies/CreateRandomAlignment.R")
source("~/GitHubs/R/Phylogenies/CreateRandomPhylogeny.R")
source("~/GitHubs/R/Phylogenies/AddOutgroupToPhylogeny.R")
source("~/GitHubs/R/Phylogenies/ConvertPhylogenyToAlignment.R")
source("~/GitHubs/R/Phylogenies/ConvertAlignmentToBeastPosterior.R")
library(nLTT)

demonstrate_convert_alignment_to_beast_posterior <- function() {

  phylogeny_without_outgroup <- create_random_phylogeny(n_taxa = 5)

  phylogeny_with_outgroup <- add_outgroup_to_phylogeny(
    phylogeny_without_outgroup,
    stem_length = 0
  )
  alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny_with_outgroup,
    sequence_length = 10
  )
  image(alignment)
  posterior <- convert_alignment_to_beast_posterior(
    alignment,
    mcmc_chainlength = 10000,
    base_filename = "demonstrate_convert_alignment_to_beast_posterior",
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

demonstrate_convert_alignment_to_beast_posterior()
