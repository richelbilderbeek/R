library(ape)

get_phylogeny_crown_age <- function(
  phylogeny,
  stem_length,
  outgroup_name = "Outgroup"
) {
  n_taxa <- length(phylogeny$tip.label)
  crown_age <- dist.nodes(phylogeny)[n_taxa + 1][1]
  return (crown_age)
}