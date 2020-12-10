library(testit)
library(nLTT)
source("~/GitHubs/R/FileIo/get_base_filename.R")
source("~/GitHubs/R/Phylogenies/get_average_nltt.R")
source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/Peregrine/read_file.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")

plot_alignment_repeatabilities <- function() {
  # How well do the BEAST2 runs on the multiple alignments match?
  
  # Filenames have the form:
  # * 'article_a_b_c_d_e_f_g.trees'
  # * 'example_i_e_f_g.trees'
  # a: 0-base index of birth rate
  # b: 0-base index of lambda
  # c: 0-base index of mu
  # d: 0-base index of mutation rate
  # e: 0-base index of alignment length
  # f: 1-base index of species tree sampled from gene tree
  # g: 1-base index of alignment simulated from species tree
  # h: 1-base index of BEAST2 run on an alignment
  # i: 1-base index of the example
  for (trees_filename in list.files(path = ".", pattern = "^(toy_example|example|article)_.*_1_1\\.trees")) {  
    trees_filename_1 <- trees_filename
    trees_filename_2 <- gsub("_1_1.trees","_1_2.trees", trees_filename)
    trees_filename_3 <- gsub("_1_1.trees","_2_1.trees", trees_filename)
    trees_filename_4 <- gsub("_1_1.trees","_2_2.trees", trees_filename)
    if (!file.exists(trees_filename_2)) next
    if (!file.exists(trees_filename_3)) next
    if (!file.exists(trees_filename_4)) next
    parameter_filename <- get_base_filename(trees_filename)
    parameter_filename <- substr(parameter_filename,1,nchar(parameter_filename) - 6)
    parameter_filename <- paste(parameter_filename,".RDa",sep="")

    png_filename <- get_base_filename(trees_filename)
    png_filename <- substr(png_filename,1,nchar(png_filename) - 4)
    png_filename <- paste(png_filename,"_alignment_repeatability.png",sep="")
    
    print(paste(trees_filename_1,trees_filename_2,parameter_filename, png_filename))
    assert(is_valid_file(parameter_filename))
    parameter_file <- read_file(parameter_filename)
    assert(file.exists(trees_filename))
    assert(file.exists(trees_filename_1))
    assert(file.exists(trees_filename_2))
    assert(file.exists(trees_filename_3))
    assert(file.exists(trees_filename_4))
    png(png_filename)
    nLTT.plot(phy = parameter_file$species_trees_with_outgroup[[1]][[1]],replot = TRUE,lty=1,lwd = 1, main="Repeatability alignments")
    get_average_nltt(beast2out.read.trees(trees_filename_1), replot = TRUE, lty = 3, lwd = 1, col = "red")
    get_average_nltt(beast2out.read.trees(trees_filename_2), replot = TRUE, lty = 3, lwd = 1, col = "blue")
    get_average_nltt(beast2out.read.trees(trees_filename_3), replot = TRUE, lty = 3, lwd = 1, col = "green")
    get_average_nltt(beast2out.read.trees(trees_filename_4), replot = TRUE, lty = 3, lwd = 1, col = "purple")
    legend(0.7,0.3, # Bottom right
      c('True','BEAST'), # puts text in the legend
      lty=c(1,3), # gives the legend appropriate symbols (lines)
      lwd=c(1,1)
    )   
    dev.off()
  }
}
plot_alignment_repeatabilities()

#setwd("~/GitHubs/R/Peregrine")