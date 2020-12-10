# Are there lineages in a phylogeny that are extinct and thus can be dropped?
# Can only create a reconstructed tree if at least 2 species are extant

source("~/GitHubs/R/Phylogenies/is_phylogeny.R")

can_drop_extinct <- function(phylogeny) {
  if (!is_phylogeny(phylogeny)) return (FALSE)
  return (length(phylogeny$tip.label) - length(is.extinct(phylogeny)) >= 2) 
}