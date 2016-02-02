library(testit)
library(ape)
library(nLTT)
source("~/GitHubs/R/FileIo/get_base_filename.R")
source("~/GitHubs/R/Phylogenies/get_average_nltt.R")
source("~/GitHubs/R/Phylogenies/sample_species_trees_from_pbd_sim_output.R")

source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/Peregrine/read_file.R")

plot_gene_tree_versus_species_trees <- function() {

  for (parameter_filename in list.files(path = ".", pattern = "^(toy_example|example|artXicle)_.*\\.RDa")) {  
    print(parameter_filename)
    assert(is_valid_file(parameter_filename))
    base_filename <- get_base_filename(parameter_filename)
    png_filename <- get_base_filename(parameter_filename)
    png_filename <- substr(png_filename,1,nchar(png_filename) - 6)
    png_filename <- paste(png_filename,"_gene_tree_versus_species_trees.png",sep="")
    file <- read_file(parameter_filename)
    trees <- sample_species_trees_from_pbd_sim_output(n = 100, file$pbd_output)
    png(png_filename)
    nLTT.plot(
      file$pbd_output$tree
    )
    get_average_nltt(phylogenies = trees, plot_nltts = TRUE, replot = TRUE, col = "red", lty = 3)
    dev.off()
  }
}

plot_gene_tree_versus_species_trees()
