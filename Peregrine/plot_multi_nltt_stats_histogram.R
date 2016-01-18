source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/FileIo/get_base_filename.R")
source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
library(ggplot2)
library(gridExtra)
library(testit)

plot_multi_nltt_stats_histogram <- function(filenames) {

  data <- data.frame()
  
  for (filename in filenames) {
    assert(is_valid_file(filename))
    file <- load_parameters_from_file(filename)
    trees_filename <- paste(get_base_filename(filename),"_1_1_1.trees",sep="")
    all_trees <- beast2out.read.trees(trees_filename)
    
    all_nltt_stats <- NULL
    for (tree in all_trees) {
      all_nltt_stats <- c(all_nltt_stats,nLTTstat(file$species_trees_with_outgroup[[1]][[1]],tree))
    }
    this_data <- data.frame(length = all_nltt_stats)
    this_data$description <- get_base_filename(filename)
    data <- rbind(data,this_data)
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

plot_multi_nltt_stats_histogram(c("example_1.RDa","example_2.RDa"))
