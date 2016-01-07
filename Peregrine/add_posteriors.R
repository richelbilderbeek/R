#rm(list = ls())
source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Phylogenies/is_beast_posterior.R")

read_libraries()
library(tools)

add_posteriors <- function(
  filename,
  do_plot = FALSE
)
{
  file <- read_file(filename)
  assert(mode(file) == "list")

  assert(basename("/test/1.txt") == "1.txt")
  assert(basename(file_path_sans_ext("/test/1.txt")) == "1")
  assert(basename(file_path_sans_ext("/test/13.RDa")) == "13")

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
  n_species_trees_samples <- as.numeric(file$parameters$n_species_trees_samples[2])
  n_alignments <- as.numeric(file$parameters$n_alignments[2])
  n_beast_runs <- as.numeric(file$parameters$n_beast_runs[2])
  
  for (i in seq(1,n_species_trees_samples)) 
  {
    for (j in seq(1,n_alignments)) 
    {
      alignment_index <- 1 + (j - 1) + ((i - 1) * n_species_trees_samples)
      assert(alignment_index >= 1)
      assert(alignment_index <= length(file$alignments))
      alignment <- file$alignments[[alignment_index]][[1]]
      if (!is_alignment(alignment)) {
        print(paste("alignments[[", i, "]] is NA. Terminating 'add_posteriors'",sep=""))
        return ()
      }
      assert(is_alignment(alignment))
      
      for (k in seq(1,n_beast_runs)) 
      {

        #i <- 2; j <- 2; k<-2; n_alignments<-2; n_species_trees_samples<-2
        posterior_index <- 1 + (k - 1) + ((j - 1) * n_alignments) + ((i - 1) * n_alignments * n_species_trees_samples)
        assert(posterior_index >= 1)
        assert(posterior_index <= length(file$posteriors))
        
        if(is_beast_posterior(file$posteriors[[posterior_index]][[1]])) {
          print(paste("   * Posterior #", k, " for alignment #",j," for species tree #",i," at posterior_index #", posterior_index, " already has a posterior", sep=""))
           next 
        }
        new_seed <- rng_seed + k
        print(paste("   * Setting seed to ", new_seed, sep=""))
        set.seed(new_seed) #Every BEAST2 run is made with a different RNG
      
        print(paste("   * Creating posterior #", k, " for alignment #",j," for species tree #",i," at posterior_index #", posterior_index, sep=""))
        basefilename <- paste(basename(file_path_sans_ext(filename)),"_",i,"_",j,"_",k,sep="")
        print(paste("   * Creating posterior using basefilename '", basefilename, "'", sep=""))

        posterior <- convert_alignment_to_beast_posterior(
          alignment = alignment,
          base_filename = basefilename,
          mcmc_chainlength = mcmc_chainlength,
          rng_seed = new_seed
        )
        assert(is_beast_posterior(posterior))
          
        print(paste("   * Storing posterior #", k, " for alignment #",j," for species tree #",i," at posterior_index #", posterior_index, sep=""))
        file$posteriors[[posterior_index]] <- list(posterior)
        assert(is_beast_posterior(file$posteriors[[posterior_index]][[1]]))
      } 
    }
  }
  
  # Save the file
  saveRDS(file, file = filename)
  file_again <- readRDS(filename)
  assert(file_again$parameters == parameters)
  assert(all.equal(file_again$posteriors, file$posteriors))
  print(paste("file ", filename, " has gotten its posteriors", sep = ""))
}
