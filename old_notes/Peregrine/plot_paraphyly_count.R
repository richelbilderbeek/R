library(testit)
library(ape)
library(nLTT)
source("~/GitHubs/R/FileIo/get_base_filename.R")
source("~/GitHubs/R/Phylogenies/get_average_nltt.R")
source("~/GitHubs/R/Phylogenies/is_monophyletic.R")
source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/Peregrine/read_file.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")

plot_paraphyly_count <- function() {
  # How well do the BEAST2 runs on the multiple species trees match?
  
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
  for (trees_filename in list.files(path = ".", pattern = "^(toy_example|example|article)_.*_1_1_1\\.trees")) {  
    trees_filename_1 <- trees_filename
    trees_filename_2 <- gsub("_1_1_1.trees","_1_1_2.trees", trees_filename)
    trees_filename_3 <- gsub("_1_1_1.trees","_1_2_1.trees", trees_filename)
    trees_filename_4 <- gsub("_1_1_1.trees","_1_2_2.trees", trees_filename)
    trees_filename_5 <- gsub("_1_1_1.trees","_2_1_1.trees", trees_filename)
    trees_filename_6 <- gsub("_1_1_1.trees","_2_1_2.trees", trees_filename)
    trees_filename_7 <- gsub("_1_1_1.trees","_2_2_1.trees", trees_filename)
    trees_filename_8 <- gsub("_1_1_1.trees","_2_2_2.trees", trees_filename)
    if (!file.exists(trees_filename_2)) next
    if (!file.exists(trees_filename_3)) next
    if (!file.exists(trees_filename_4)) next
    if (!file.exists(trees_filename_5)) next
    if (!file.exists(trees_filename_6)) next
    if (!file.exists(trees_filename_7)) next
    if (!file.exists(trees_filename_8)) next
    parameter_filename <- get_base_filename(trees_filename)
    parameter_filename <- substr(parameter_filename,1,nchar(parameter_filename) - 6)
    parameter_filename <- paste(parameter_filename,".RDa",sep="")

    png_filename <- get_base_filename(trees_filename)
    png_filename <- substr(png_filename,1,nchar(png_filename) - 6)
    png_filename <- paste(png_filename,"_paraphyly_count.png",sep="")
    
    print(paste(trees_filename_1,trees_filename_2,parameter_filename, png_filename))
    assert(is_valid_file(parameter_filename))
    parameter_file <- read_file(parameter_filename)
    assert(file.exists(trees_filename))
    assert(file.exists(trees_filename_1))
    assert(file.exists(trees_filename_2))
    assert(file.exists(trees_filename_3))
    assert(file.exists(trees_filename_4))
    assert(file.exists(trees_filename_5))
    assert(file.exists(trees_filename_6))
    assert(file.exists(trees_filename_7))
    assert(file.exists(trees_filename_8))
    trees_1 <- beast2out.read.trees(trees_filename_1)
    trees_2 <- beast2out.read.trees(trees_filename_2)
    trees_3 <- beast2out.read.trees(trees_filename_3)
    trees_4 <- beast2out.read.trees(trees_filename_4)
    trees_5 <- beast2out.read.trees(trees_filename_5)
    trees_6 <- beast2out.read.trees(trees_filename_6)
    trees_7 <- beast2out.read.trees(trees_filename_7)
    trees_8 <- beast2out.read.trees(trees_filename_8)

    png(png_filename)
    
    n_mono_1 <- length(trees[is_monophyletic(trees_1)])
    n_para_1 <- length(trees[!is_monophyletic(trees_1)])
    n_mono_2 <- length(trees[is_monophyletic(trees_2)])
    n_para_2 <- length(trees[!is_monophyletic(trees_2)])
    n_mono_3 <- length(trees[is_monophyletic(trees_3)])
    n_para_3 <- length(trees[!is_monophyletic(trees_3)])
    n_mono_4 <- length(trees[is_monophyletic(trees_4)])
    n_para_4 <- length(trees[!is_monophyletic(trees_4)])
    n_mono_5 <- length(trees[is_monophyletic(trees_5)])
    n_para_5 <- length(trees[!is_monophyletic(trees_5)])
    n_mono_6 <- length(trees[is_monophyletic(trees_6)])
    n_para_6 <- length(trees[!is_monophyletic(trees_6)])
    n_mono_7 <- length(trees[is_monophyletic(trees_7)])
    n_para_7 <- length(trees[!is_monophyletic(trees_7)])
    n_mono_8 <- length(trees[is_monophyletic(trees_8)])
    n_para_8 <- length(trees[!is_monophyletic(trees_8)])
    
    df <- data.frame(
      n_mono = c(n_mono_1,n_mono_2,n_mono_3,n_mono_4,n_mono_5,n_mono_6,n_mono_7,n_mono_8), 
      n_para = c(n_para_1,n_para_2,n_para_3,n_para_4,n_para_5,n_para_6,n_para_7,n_para_8)
    )
    df <- t(df)
    colnames(df) <- c("1_1_1","1_1_2","1_2_1","1_2_2","2_1_1","2_1_2","2_2_1","2_2_2")
    df <- data.frame(df)
    barplot(as.matrix(df), main = "Number of monophylies in posterior") # Best
    #qplot(x = n_mono, data = df, type="bar")
    dev.off()
  }
}
plot_paraphyly_count()

#setwd("~/GitHubs/R/Peregrine")