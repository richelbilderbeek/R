library(ape)
library(geiger)
library(phangorn)

source("~/GitHubs/R/Phylogenies/CreateRandomPhylogeny.R")
source("~/GitHubs/R/Phylogenies/ConvertPhylogenyToAlignment.R")

demonstrate_convert_phylogeny_to_alignment <- function() 
{
  phylogeny <- create_random_phylogeny(n_taxa = 5)
  alignment <- convert_phylogeny_to_alignment(phylogeny,sequence_length = 10)
  assert(class(alignment)=="DNAbin")

  n_cols <- 1
  n_rows <- 2
  par(mfrow=c(n_rows,n_cols))
  plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
  text(x = 0.5, y = 0.5, paste("convert_phylogeny_to_alignment"),cex = 1.6, col = "black")
  image(alignment)
  par(mfrow=c(1,1))
}

# Uncomment this to view the function demonstration
demonstrate_convert_phylogeny_to_alignment()
