source("~/GitHubs/R/FileIo/get_base_filename.R")
source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")
source("~/GitHubs/R/Phylogenies/get_average_nltt.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.treeannotator.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/script.beast.R")
library(ape)
library(ggplot2)
library(gridExtra)
library(nLTT)
library(testit)

do_analyze_multi <- function(filenames) {
  do_analyze_multi_create_nltt_stats_histogram(filenames)
  do_analyze_multi_create_average_nltts(filenames)
}
  
do_analyze_multi_create_nltt_stats_histogram <- function(filenames) {

  data <- data.frame()
  
  for (filename in filenames) {
    file <- load_parameters_from_file(filename)

    trees_filename <- paste(get_base_filename(filename),"_1_1_1.trees",sep="")
    all_trees <- beast2out.read.trees(trees_filename)
    
    all_nltt_stats <- NULL
    for (tree in all_trees)
    {
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
  ) + ggtitle("Distribution of nLTT statistics\nbetween species tree and posterior") + 
    theme(plot.title = element_text(lineheight=.8, face="bold")) + 
    scale_fill_manual(" ",values=c("red","blue"))
  grid.arrange(myplot)
  ggsave("nltt_stats_histogram.png")
}

do_analyze_multi_create_average_nltts <- function(filenames) {
  png(paste("average_nltts.png",sep=""))
  for (i in c(1,length(filenames))) {
    
    trees_filename <- paste(get_base_filename(filenames[i]),"_1_1_1.trees",sep="")
    all_trees <- beast2out.read.trees(trees_filename)
    do_replot <- FALSE #A new plot is started
    if (i == 1)  {
      get_average_nltt(all_trees,replot = FALSE,lty=1,lwd = 2, main="Average nLTTs")
    } else {
      get_average_nltt(all_trees,replot = TRUE,lty=3,lwd = 2)
    }
      
  }
  dev.off()
}