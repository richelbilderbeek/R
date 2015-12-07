source("~/GitHubs/R/Phylogenies/get_phylogeny_crown_age.R")
source("~/GitHubs/R/Phylogenies/sample_species_trees_from_random_protracted_tree.R")
source("~/GitHubs/R/Phylogenies/has_paraphyly.R")

library(ape)
library(ggplot2)
library(gridExtra)

# Load all PBD functions
pbd_path <- "~/GitHubs/PBD/PBD/R"
for (file in list.files(path = pbd_path)) {
  source(paste(pbd_path,"/",file,sep=""));
}

library(testit)

investigate_sample_species_trees_from_protracted_tree <- function() {

  n <- 4
  age <- 5
  seed <- 320

  set.seed(seed)
  b_1  <- 0.7 # b_1 , the speciation-initiation rate of good species 
  la_1 <- 0.2 # la_1, the speciation-completion rate 
  b_2  <- 0.6 # b_2 , the speciation-initiation rate of incipient species 
  mu_1 <- 1.0 # mu_1, the extinction rate of good species 
  mu_2 <- 0.6 # mu_2, the extinction rate of incipient species 
  pbd_sim_output <- pbd_sim(c(b_1,la_1,b_2,mu_1,mu_2),age)
  names(pbd_sim_output)

  full_tree <- pbd_sim_output$tree

  # Strip the subspecies names
  species_tree <- pbd_sim_output$tree
  species_tree$tip.label <- strip_subspecies_label_from_tip_labels(species_tree$tip.label)
  assert(HasParaphyly(species_tree))
  plot(species_tree,show.node.label=TRUE,root.edge = TRUE)
  nodelabels( , col = "black", bg = "gray")

  branch_lengths_species_trees <- NULL
  n_species_trees <- 0
  while (length(branch_lengths_species_trees) < length(full_tree$edge.length)) {
    species_trees <- SampleSpeciesTreesFromPbdSimOutput(n=1,pbd_sim_output)
    branch_lengths_species_trees <- c(branch_lengths_species_trees,species_trees[[1]]$edge.length)
    n_species_trees <- n_species_trees + 1
  }



  p1 <- hist(full_tree$edge.length)
  p2 <- hist(branch_lengths_species_trees)
  plot( p1, col=rgb(0,0,1,1/4), xlim=c(0,30))
  plot( p2, col=rgb(1,0,0,1/4), xlim=c(0,30), add=T)

  data1 <- data.frame(length = full_tree$edge.length)
  data2 <- data.frame(length = branch_lengths_species_trees)

  #Now, combine your two dataframes into one.  First make a new column in each.
  data1$tree <- 'Gene tree'
  data2$tree <- paste(n_species_trees,"species trees")

  # and combine into your new data frame vegLengths
  data <- rbind(data1,data2)
  names(data)

  myplot <- ggplot(
    data, 
    aes(length, fill = tree)) + geom_histogram(alpha = 0.25,aes(y = ..density..), 
    position = 'identity', 
    binwidth = 0.5
  ) + xlab("Edge lengths") + 
    ylab("Frequency") + 
    ggtitle("Distribution of branch lengths of\n gene and (multiple) species trees") + 
    theme(legend.position = 'bottom')

  grid.arrange(myplot)
  ggsave("~/investigate_sample_species_trees_from_protracted_tree.png")
}

investigate_sample_species_trees_from_protracted_tree()