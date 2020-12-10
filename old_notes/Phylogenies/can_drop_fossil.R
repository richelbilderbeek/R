# Are there lineages in a phylogeny that are extinct and thus can be dropped?
# Can only create a reconstructed tree if at least 2 species are extant
can_drop_fossil <- function(phylogeny) {
  return (length(phylogeny$tip.label) - length(is.extinct(phylogeny)) >= 2) 
}