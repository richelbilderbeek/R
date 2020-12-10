library(ape)

# Detect if a group of labels is monophyletic
is_monophyletic_group <- function(phylogeny, groups) {
  return (is.monophyletic(phylogeny, tips = groups))
}

