source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/FileIo/get_base_filename.R")
source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
library(ape)
library(ggplot2)
library(gridExtra)
library(nLTT)
library(testit)

plot_multi_nltt_stats_histogram <- function(filenames) {

  data <- data.frame()
  
  for (filename in filenames) {
    assert(is_valid_file(filename))
    file <- load_parameters_from_file(filename)
    n_species_trees_samples <- as.numeric(file$parameters$n_species_trees_samples[2])
    n_alignments <- as.numeric(file$parameters$n_alignments[2])
    n_beast_runs <- as.numeric(file$parameters$n_beast_runs[2])
    for (i in seq(1,n_species_trees_samples)) {
      for (j in seq(1,n_alignments)) {
        for (k in seq(1,n_beast_runs)) {
          base_filename <- get_base_filename(filename)
          trees_filename <- paste(base_filename,"_",i,"_",j,"_",k,".trees",sep="")
          all_trees <- beast2out.read.trees(trees_filename)
          all_nltt_stats <- NULL
          for (tree in all_trees) {
            all_nltt_stats <- c(all_nltt_stats,nLTTstat(file$species_trees_with_outgroup[[1]][[1]],tree))
          }
          this_data <- data.frame(length = all_nltt_stats)
          this_data$description <- get_base_filename(filename)
          data <- rbind(data,this_data)
        }
      }
    }
  }

  myplot <- ggplot(
    data, aes(length, fill = description)
  ) + geom_histogram(
    alpha = 0.25,
    aes(y = ..density..), 
    position = 'identity', 
    binwidth = 0.005
  ) + ggtitle("nLTT statistics distribution") + 
    theme(plot.title = element_text(lineheight=.8, face="bold")) + 
    scale_fill_manual(" ",values=c("red","blue"))
  grid.arrange(myplot)
  ggsave("multi_nltt_stats_histogram.png")
}