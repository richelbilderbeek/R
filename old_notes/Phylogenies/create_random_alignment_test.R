# Create a random alignment and a demonstration of this

source("~/GitHubs/R/Phylogenies/create_random_alignment.R")

test_create_random_alignment <- function() {
  # Create the alignment
  alignment <- create_random_alignment(
    n_taxa = 5, 
    sequence_length = 20,
    rate = 0.1
  )
  
  # Prepare plotting two things
  n_cols <- 1
  n_rows <- 2
  par(mfrow=c(n_rows,n_cols))

  # Plot the text
  plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
  text(x = 0.5, y = 0.5, paste("demonstrate_create_random_alignment"),cex = 1.6, col = "black")
  # Plot the alignment
  image(alignment)

  # Restore plotting one thing
  par(mfrow=c(1,1))
}

test_create_random_alignment()