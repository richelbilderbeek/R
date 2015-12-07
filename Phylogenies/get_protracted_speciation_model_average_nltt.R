library(PBD)

source("~/GitHubs/R/Phylogenies/get_average_nltt.R")

get_protracted_speciation_model_average_nltt <- function(
  speciation_initiation_rate_good_species,
  speciation_completion_rates,
  speciation_initiation_rate_incipient_species,
  extinction_rate_good_species,
  extinction_rate_incipient_species,
  crown_age,
  n_trees,
  gene_tree_of_species_tree,
  ...
)
{
  assert(gene_tree_of_species_tree == "gene_tree" || gene_tree_of_species_tree == "species_tree")
  
  phylogenies <- NULL
  for (i in seq(1,n_trees)) {
    trees_full <- pbd_sim(
      c(
        speciation_initiation_rate_good_species,
        speciation_completion_rates,
        speciation_initiation_rate_incipient_species,
        extinction_rate_good_species,
        extinction_rate_incipient_species
      ),
      crown_age,
      soc = 2,
      plot = 0
    )

    if (gene_tree_of_species_tree == "gene_tree") {
      phylogeny <- trees_full$tree  #Will be similar to a BD tree
    } else {
      phylogeny <- trees_full$stree  #Species tree
    }
    phylogenies <- c(phylogenies,list(phylogeny))
  }
  
  get_average_nltt(
    phylogenies,
    ...
  )
}

get_protracted_speciation_model_average_nltt_test_1 <- function() {
  #
  # Compare gene tree and species tree
  #  
  
  speciation_initiation_rate_good_species <- 0.2
  speciation_completion_rate <- 0.1
  speciation_initiation_rate_incipient_species <- 0.2
  extinction_rate_good_species <- 0.1
  extinction_rate_incipient_species <- 0.1
  crown_age <- 15
  n_trees <- 1000
    
  # Compare species tree and gene tree
  get_protracted_speciation_model_average_nltt(
    speciation_initiation_rate_good_species  = speciation_initiation_rate_good_species,
    speciation_completion_rate = speciation_completion_rate,
    speciation_initiation_rate_incipient_species  = speciation_initiation_rate_incipient_species,
    extinction_rate_good_species = extinction_rate_good_species,
    extinction_rate_incipient_species = extinction_rate_incipient_species,
    crown_age = crown_age,
    n_trees = n_trees,
    gene_tree_of_species_tree = "species_tree",
    col = "red",
    lwd = 4,
    cex.lab = 1.5,
    cex.axis = 1.5,
    plot_nltts = FALSE,
    dt = 0.001,
    main = paste(
      "Average nLTT of ",n_trees,
      " PBD species trees (red) and gene trees (blue).\n",
      "  b_1: ",speciation_initiation_rate_good_species,
      ", b_2: ",speciation_initiation_rate_incipient_species,
      ", la_1: ",speciation_completion_rate,
      ", mu_1: ",extinction_rate_good_species,
      ", mu_2: ",extinction_rate_incipient_species,
      ", crown age: ",crown_age,")"
      ,sep=""
    )
  )
  
  get_protracted_speciation_model_average_nltt(
    speciation_initiation_rate_good_species = speciation_initiation_rate_good_species,
    speciation_completion_rate = speciation_completion_rate,
    speciation_initiation_rate_incipient_species= speciation_initiation_rate_incipient_species,
    extinction_rate_good_species = extinction_rate_good_species,
    extinction_rate_incipient_species = extinction_rate_incipient_species,
    crown_age = crown_age,
    n_trees = n_trees,
    gene_tree_of_species_tree = "gene_tree",
    col = "blue",
    lwd = 4,
    cex.lab = 2,
    cex.axis = 2,
    plot_nltts = FALSE,
    dt = 0.001,
    replot = TRUE #Overlay this on a current plot
  )
}

get_protracted_speciation_model_average_nltt_test_2 <- function() {
  #
  # Species tree become more like BD for higher speciation completion rates
  #  
  #set.seed(314)
  speciation_initiation_rate_good_species <- 0.2
  speciation_completion_rates <- c(0.01,0.1,1.0,10.0)
  speciation_initiation_rate_incipient_species <- 0.2
  extinction_rate_good_species <- 0.1
  extinction_rate_incipient_species <- 0.1
  crown_age <- 15
  n_trees <- 100
  
  title <- paste(
    "Average nLTT of ",n_trees,
    " PBD species trees with different speciation completion_rates\n",
    "  speciation_initiation_rate_good_species: ",speciation_initiation_rate_good_species,
    ", speciation_initiation_rate_incipient_species: ",speciation_initiation_rate_incipient_species,
    ", speciation_completion_rates: variable",
    ", extinction_rate_good_species: ",extinction_rate_good_species,
    ", extinction_rate_incipient_species: ",extinction_rate_incipient_species,
    ", crown age: ",crown_age,")",
    sep=""
  )
  # Compare species tree and gene tree
  for (i in seq(1,length(speciation_completion_rates))) {
    replot <- FALSE
    if (i > 1) { replot <- TRUE }
    get_protracted_speciation_model_average_nltt(
      speciation_initiation_rate_good_species = speciation_initiation_rate_good_species,
      speciation_completion_rate = speciation_completion_rates[i],
      speciation_initiation_rate_incipient_species = speciation_initiation_rate_incipient_species,
      extinction_rate_good_species = extinction_rate_good_species,
      extinction_rate_incipient_species = extinction_rate_incipient_species,
      crown_age = crown_age,
      n_trees = n_trees,
      gene_tree_of_species_tree = "species_tree",
      col = i,
      replot = replot,
      plot_nltts = FALSE
    )
  }
}

# Uncomment this to view the function demonstration
get_protracted_speciation_model_average_nltt_test_1()
get_protracted_speciation_model_average_nltt_test_2()
