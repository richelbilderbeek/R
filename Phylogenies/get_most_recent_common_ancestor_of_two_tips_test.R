source("~/GitHubs/R/Phylogenies/get_most_recent_common_ancestor_of_two_tips.R")
library(ape)
library(testit)

get_most_recent_common_ancestor_of_two_tips_test_1 <- function() {

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

  assert(is.null(get_most_recent_common_ancestor_of_two_tips(phylogeny,"A","A")))
  assert(get_most_recent_common_ancestor_of_two_tips(phylogeny,"A","B") == 4)
  assert(get_most_recent_common_ancestor_of_two_tips(phylogeny,"A","C") == 4)
  assert(get_most_recent_common_ancestor_of_two_tips(phylogeny,"B","A") == 4)
  assert(is.null(get_most_recent_common_ancestor_of_two_tips(phylogeny,"B","B")))
  assert(get_most_recent_common_ancestor_of_two_tips(phylogeny,"B","C") == 5)
  assert(get_most_recent_common_ancestor_of_two_tips(phylogeny,"C","A") == 4)
  assert(get_most_recent_common_ancestor_of_two_tips(phylogeny,"C","B") == 5)
  assert(is.null(get_most_recent_common_ancestor_of_two_tips(phylogeny,"C","C")))

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

  assert(get_most_recent_common_ancestor_of_two_tips(phylogeny,"A","A") == 4)
  assert(get_most_recent_common_ancestor_of_two_tips(phylogeny,"A","B") == 4)
  assert(get_most_recent_common_ancestor_of_two_tips(phylogeny,"B","A") == 4)
  assert(is.null(get_most_recent_common_ancestor_of_two_tips(phylogeny,"B","B")))
}

get_most_recent_common_ancestor_of_two_tips_test_2 <- function() {
  get_most_recent_common_ancestor_of_two_tips_test()
  
  paraphyletic_newicks <- GetCorrectParaphyleticTestNewicks()
  paraphyletic_newick <- paraphyletic_newicks[1]
  paraphyletic_phylogeny <- convert_newick_to_phylogeny(paraphyletic_newick)
  #paraphyletic_phylogeny$tip.label = StripSubspeciesLabelFromTipLabels(paraphyletic_phylogeny$tip.label)
  
  plot(paraphyletic_phylogeny)
  
  tips <- StripSubspeciesLabelFromTipLabels(paraphyletic_phylogeny$tip.label)
  tips
  is.monophyletic(
    paraphyletic_phylogeny,
    tips = tips
  )
  
  is.monophyletic
  
  ## Test one monophyletic and one paraphyletic group on the bird.orders tree
  data("bird.orders")
  plot(bird.orders)
  is.monophyletic(phy = bird.orders, tips = c("Ciconiiformes", "Gruiformes"))
  is.monophyletic(bird.orders, c("Passeriformes", "Ciconiiformes", "Gruiformes"))
  
  # Labels are numbers 1 and 2
  phylogeny <- read.tree(text="(1:2.0,(2:1.0,1:1.0):1.0):1.0;")
  plot(phylogeny,root.edge = TRUE)
  is.monophyletic(phylogeny,tips=c(1,2))
  is.monophyletic(phylogeny,tips=c(1,2,3),plot = TRUE)
  ?is.monophyletic
  
  assert(is.monophyletic(phylogeny,tips=c(1,2)) == FALSE)
  
  # Labels are characters A and B
  phylogeny <- read.tree(text="(A:2.0,(B:1.0,A:1.0):1.0):1.0;")
  plot(phylogeny,root.edge = TRUE)
  assert(is.monophyletic(phylogeny,tips=c("A","B")) == FALSE) #Fails?
  
  is.monophyletic
  
  
  
  phylogeny <- read.tree(text="(A:2.0,(B:1.0,C:1.0):1.0):1.0;")
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
  plot(phylogeny,show.node.label=TRUE,root.edge = TRUE)
  nodelabels( , col = "black", bg = "gray")
  
  phylogeny$node.label = c("X","Y")
  
  mrca(phylogeny)
  getMRCA(phylogeny,tip=c("C","C"))
  getMRCA(phylogeny,tip=c("A","B"))
  getMRCA(phylogeny,tip=c("A","C"))
  getMRCA(phylogeny,tip=c("C","B"))
  names(phylogeny)
  ?phylogeny
  class(phylogeny)
  ?phylo
  
  phylogeny$Nnode
  phylogeny$edge
  phylogeny$tip.label
  nodelabels(phylogeny)
  
  phylogeny$node.label = c("X","Y")
  plot(phylogeny,show.node.label=TRUE)
  
  phylogeny$edge
  names(phylogeny)
  ?getMRCA
  ?mrca
}

get_most_recent_common_ancestor_of_two_tips_test_1()
