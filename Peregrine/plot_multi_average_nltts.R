source("~/GitHubs/R/FileIo/get_base_filename.R")
source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
source("~/GitHubs/R/Phylogenies/get_average_nltt.R")
library(testit)

plot_multi_average_nltts <- function(filenames) {
  png(paste("multi_average_nltts.png",sep=""))
  for (i in c(1,length(filenames))) {
    assert(is_valid_file(filenames[i]))
    assert(file.exists(paste(get_base_filename(filenames[i]),"_1_1_1.trees",sep="")))
    trees_filename <- paste(get_base_filename(filenames[i]),"_1_1_1.trees",sep="")
    all_trees <- beast2out.read.trees(trees_filename)
    do_replot <- FALSE #A new plot is started
    if (i == 1)  {
      get_average_nltt(all_trees,replot = FALSE,lty=1,lwd = 2, main="Average nLTTs")
    } else {
      get_average_nltt(all_trees,replot = TRUE,lty=3,lwd = 2)
    }     
  }
  legend(0.7,0.3, # Top left
    c('BD','PBD'), # puts text in the legend
    lty=c(1,3), # gives the legend appropriate symbols (lines)
    lwd=c(2,2)
  )   
  dev.off()
}