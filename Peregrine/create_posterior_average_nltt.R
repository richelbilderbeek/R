source("~/GitHubs/R/Peregrine/save_parameters_to_file.R")
source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")
source("~/GitHubs/R/Peregrine/add_pbd_output.R")
source("~/GitHubs/R/Peregrine/add_species_trees_with_outgroup.R")
source("~/GitHubs/R/Peregrine/add_alignments.R")
source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")
source("~/GitHubs/R/Peregrine/show_posteriors.R")
source("~/GitHubs/R/Peregrine/add_posteriors.R")
source("~/GitHubs/R/Phylogenies/get_average_nltt.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.treeannotator.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/script.beast.R")
library(nLTT)
library(ape)
library(ggplot2)
library(gridExtra)
library(testit)

setwd("~/Slurm")

for (parameter_set in seq(2,35)) {
  print(paste("parameter_set: ",parameter_set))
  png(paste(parameter_set,"_posterior.png",sep=""))
  for (alignment_index in c(1,2)) {
    print(paste("alignment_index: ",alignment_index))
    for (beast_run_index in c(1,2)) {
      print(paste("beast_run_index: ",beast_run_index))
      trees_filename <- paste(parameter_set,"_",alignment_index,"_",beast_run_index,".trees",sep="")
      all_trees <- beast2out.read.trees(trees_filename)
      do_replot <- FALSE #A new plot is started
      line_type <- ifelse(alignment_index == 1, 1, 3)
      line_width <- 1
      if (alignment_index == 1 && beast_run_index == 1)  {
        get_average_nltt(all_trees,replot = FALSE,lty=line_type,lwd = line_width, main="Average nLTTs")
      } else {
        get_average_nltt(all_trees,replot = TRUE,lty=line_type,lwd = line_width)
      }
    }
  }
  dev.off()
}


file <- load_parameters_from_file("33.RDa")
t(file$parameters)
