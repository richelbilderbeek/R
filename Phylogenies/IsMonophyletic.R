library(ape)
library(testit)

source("~/GitHubs/R/Container/AreAllIdentical.R")
source("~/GitHubs/R/Container/AreAllUnique.R")
source("~/GitHubs/R/Phylogenies/ConvertNewickToPhylogeny.R")
source("~/GitHubs/R/Phylogenies/GetCorrectTestNewicks.R")
source("~/GitHubs/R/Phylogenies/GetCorrectParaphyleticTestNewicks.R")
source("~/GitHubs/R/Phylogenies/StripSubspeciesLabelFromTipLabels.R")
source("~/GitHubs/R/Phylogenies/IsMonophyleticGroup.R")

# Detect if the phylogeny is monophyletic, i.e. that there are no paraphylies
IsMonophyletic <- function(phylogeny) {

  #
  #      +------- C
  #      |
  #  +---+Y
  #  |   |
  # -+X  +------- B
  #  |
  #  |
  #  |
  #  +----------- A
  #
  # Assume A,B and C being species names that can also be non-unique.
  # When (A,B,C) = ("Eagle","Dog","Eagle"), this is a paraphyly,
  #   as there is an Eagle (at C) that is more related to a Dog (at B) than its sister Eagle at A
  # When (A,B,C) = ("Dog","Eagle","Eagle"), this is a monophyly,
  #   as there is no species more related to each other than the two Eagles
  #
  # In R, the function getMRCA can be used to detect this:
  #   getMRCA(phylogeny,tip=c("A","C")) == 4 (labeled by an X)
  #   getMRCA(phylogeny,tip=c("B","C")) == 5 (labeled by a  Y)
  #
  # When there is a paraphyly,
  #   getMRCA(phylogeny,tip=c("Dog (at B)","Eagle (at C)"))      == 5 (labeled by an Y)
  # > getMRCA(phylogeny,tip=c("Eagle (at A)","Eagle (at C)"))    == 4 (labeled by an X)
  # Or (but false here): 
  #   getMRCA(phylogeny,tip=c("Dog (at B)","Eagle (at A)"))      == 4 (labeled by an X)
  # > getMRCA(phylogeny,tip=c("Eagle (at A)","Eagle (at C)"))    == 4 (labeled by an X)
  #
  # So, when two identically named species have a lower MRCA than 
  # another species with one of them, there is a paraphyly
  #

  # Copy the tip labels
  original_tip_labels <- phylogeny$tip.label
  n_original_tip_labels <- length(original_tip_labels)

  # If there are one or two tips, there is a monophyly   
  if (n_original_tip_labels <= 2) {
    return (TRUE) 
  }
  # If all tips are unique, there is a monophyly
  if (AreAllUnique(original_tip_labels)) {
    return (TRUE) 
  }
  
  # Replace the tip labels by their tip IDs
  phylogeny$tip.label <- seq(1,n_original_tip_labels)
  unique_tip_labels <- phylogeny$tip.label

  plot(phylogeny,show.node.label=TRUE,root.edge = TRUE)
  nodelabels( , col = "black", bg = "gray")
  
  for (a in seq(1,n_original_tip_labels-2)) {
    assert(a >= 1 && a <= n_original_tip_labels)
    a_unique_name <- unique_tip_labels[a]
    a_original_name <- original_tip_labels[a]
    
    for (b in seq(a + 1,n_original_tip_labels-1)) {
      assert(b >= 1 && b <= n_original_tip_labels)
      b_unique_name <- unique_tip_labels[b]
      b_original_name <- original_tip_labels[b]

      for (c in seq(b + 1,n_original_tip_labels)) {
        assert(c >= 1 && c <= n_original_tip_labels)
        c_unique_name <- unique_tip_labels[c]
        c_original_name <- original_tip_labels[c]

        # If species are (A,B,C) this cannot be a paraphyly
        if(AreAllUnique   (c(a_original_name,b_original_name,c_original_name))) { next }

        # If species are (A,A,A) this cannot be a paraphyly
        if(AreAllIdentical(c(a_original_name,b_original_name,c_original_name))) { next }

        assert(AreAllUnique(c(a_unique_name,b_unique_name,c_unique_name)))
        focal_species_name  <- NULL
        sister_species_name <- NULL
        other_species_name  <- NULL
        if (a_original_name == b_original_name) {
          focal_species_name  <- a_unique_name
          sister_species_name <- b_unique_name
          other_species_name  <- c_unique_name
        } else if (a_original_name == c_original_name) {
          focal_species_name  <- a_unique_name
          sister_species_name <- c_unique_name
          other_species_name  <- b_unique_name
        } else {
          focal_species_name  <- b_unique_name
          sister_species_name <- c_unique_name
          other_species_name  <- a_unique_name
        }
        mrca_sister <- getMRCA(phylogeny,tip=c(focal_species_name,sister_species_name))
        mrca_other1 <- getMRCA(phylogeny,tip=c(other_species_name,focal_species_name))
        mrca_other2 <- getMRCA(phylogeny,tip=c(other_species_name,sister_species_name))
        if (mrca_other1 > mrca_sister) return (FALSE)
        if (mrca_other2 > mrca_sister) return (FALSE)
      }
    }
  }

  return (TRUE)
}

DemonstrateIsMonophyletic <- function() {

  phylogeny <- read.tree(text="(A:2.0,(B:1.0,C:1.0):1.0):1.0;")
  #
  #      +------- C
  #      |
  #  +---+
  #  |   |
  # -+   +------- B
  #  |
  #  |
  #  |
  #  +----------- A
  #
  plot(phylogeny,show.node.label=TRUE,root.edge = TRUE)
  nodelabels( , col = "black", bg = "gray")
  assert(IsMonophyletic(phylogeny))

  phylogeny <- read.tree(text="(A:2.0,(B:1.0,A:1.0):1.0):1.0;")
  #
  #      +------- A
  #      |
  #  +---+
  #  |   |
  # -+   +------- B
  #  |
  #  |
  #  |
  #  +----------- A
  #
  plot(phylogeny,show.node.label=TRUE,root.edge = TRUE)
  nodelabels( , col = "black", bg = "gray")
  assert(!IsMonophyletic(phylogeny))
  
  for (monophyletic_newick in GetCorrectTestNewicks()) {
    monophyletic_phylogeny <- ConvertNewickToPhylogeny(monophyletic_newick)
    plot(monophyletic_phylogeny,show.node.label=TRUE,root.edge = TRUE)
    nodelabels( , col = "black", bg = "gray")
    assert(IsMonophyletic(monophyletic_phylogeny))
  }

  for (paraphyletic_newick in GetCorrectParaphyleticTestNewicks()) {
    paraphyletic_phylogeny <- ConvertNewickToPhylogeny(paraphyletic_newick)
    paraphyletic_phylogeny$tip.label <- StripSubspeciesLabelFromTipLabels(paraphyletic_phylogeny$tip.label)
    plot(paraphyletic_phylogeny,show.node.label=TRUE,root.edge = TRUE)
    nodelabels( , col = "black", bg = "gray")
    assert(!IsMonophyletic(paraphyletic_phylogeny))
  }
}

DemonstrateIsMonophyletic()
