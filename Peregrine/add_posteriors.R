#rm(list = ls())
source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Phylogenies/is_beast_posterior.R")

read_libraries()

add_posteriors <- function(
  filename,
  do_plot = FALSE
)
{
  file <- read_file(filename)
  assert(mode(file) == "list")

  assert(!is.null(file$parameters))
  assert(!is.null(file$pbd_output))
  assert(!is.null(file$species_trees_with_outgroup))
  assert(!is.null(file$alignments))
  assert(!is.null(file$posteriors))
  
  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2])
  mcmc_chainlength <- as.numeric(parameters$mcmc_chainlength[2])
  n_alignments <- as.numeric(parameters$n_alignments[2])
  n_beast_runs <- as.numeric(parameters$n_beast_runs[2])

  assert(n_alignments > 0)
  assert(n_beast_runs > 0)

  print(paste("add_posteriors: rng_seed: ",rng_seed,sep=""))
  print(paste("add_posteriors: mcmc_chainlength: ",mcmc_chainlength,sep=""))
  print(paste("add_posteriors: n_alignments: ",n_alignments,sep=""))
  print(paste("add_posteriors: n_beast_runs: ",n_beast_runs,sep=""))
  
  # For each alignment, create n_beast_runs posteriors
  for (i in seq(1:n_alignments)) {

    assert(i >= 1)
    assert(i <= length(file$alignments))

    # Obtain the alignment
    alignment <- file$alignments[[i]][[1]]

    if (!is_alignment(alignment)) {
      print(paste("alignments[[", i, "]] is NA. Terminating 'add_posteriors'",sep=""))
      return ()
    }
    assert(is_alignment(alignment))
    
    for (j in seq(1:n_beast_runs)) {
  
      index <- 1 + (j - 1) + ( (i - 1) * n_alignments)
      assert(index >= 1)
      assert(index <= length(file$posteriors))
      
      if(is_beast_posterior(file$posteriors[[index]][[1]])) {
        print(paste("   * Posterior #", j, " for alignment #",i," at index #", index, " already has a posterior", sep=""))
         next 
      }

      print(paste("   * Setting seed to ", rng_seed, sep=""))
      set.seed(rng_seed) # FIX_ISSUE_4
    
      print(paste("   * Creating posterior #", j, " for alignment #",i," at index #", index, sep=""))
      basefilename <- basename(tempfile(pattern = "tmp_", fileext = ""))
      print(paste("   * Creating posterior using basefilename '", basefilename, "'", sep=""))
      
      assert(is_alignment(alignment))
      posterior <- convert_alignment_to_beast_posterior(
        alignment = alignment,
        base_filename = basefilename,
        mcmc_chainlength = mcmc_chainlength,
        rng_seed = rng_seed
      )

      assert(is_beast_posterior(posterior))
      #assert(is_beast_posterior(list(posterior)))

      print(paste("   * Storing posterior #", j, " for alignment #",i," at index #", index, sep=""))
      file$posteriors[[index]] <- list(posterior)
      assert(is_beast_posterior(file$posteriors[[index]][[1]]))
      
    }
  }
  
  # Save the file
  saveRDS(file, file = filename)
  file_again <- readRDS(filename)
  assert(file_again$parameters == parameters)
  assert(all.equal(file_again$posteriors, file$posteriors))
  print(paste("file ", filename, " has gotten its posteriors", sep = ""))
}
