# Detect if the phylogeny has a paraphyly
source("~/GitHubs/R/Phylogenies/is_monophyletic.R")

has_paraphyly <- function(phylogeny) {
  return (!is_monophyletic(phylogeny))
}