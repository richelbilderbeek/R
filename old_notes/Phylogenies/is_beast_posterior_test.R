source("~/GitHubs/R/Phylogenies/is_beast_posterior.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
library(ape)
library(testit)

get_is_beast_posterior_test_filename <- function() {
  # Return an existing .trees filename
  
  filenames <- c(
    "is_beast_posterior.trees",
    "~/GitHubs/R/Phylogenies/is_beast_posterior.trees"
  )
  for (filename in filenames) {
    if (file.exists(filename)) { return (filename) }
  }
  print("get_is_beast_posterior_test_filename: ERROR: cannot find the 'is_beast_posterior_test.R' file")
  
}

is_beast_posterior_test <- function() {

  assert(file.exists(get_is_beast_posterior_test_filename()))
  posterior <- beast2out.read.trees(get_is_beast_posterior_test_filename())
  
  assert(is_beast_posterior(posterior))
  assert(length(posterior) == 10)
  
  # Putting posteriors in a vector must yield an invalid BEAST posterior
  not_posteriors <- c(posterior,posterior)
  assert(length(not_posteriors) == 20)
  assert(!is_beast_posterior(not_posteriors))

  # Putting posteriors in a list must yield an invalid BEAST posterior
  not_posteriors <- c(list(posterior),list(posterior))
  assert(length(not_posteriors) == 2)
  assert(!is_beast_posterior(not_posteriors))
  

  assert(!is_beast_posterior(42))
  assert(!is_beast_posterior(3.14))
  assert(!is_beast_posterior("Hello world"))
  assert(!is_beast_posterior(rcoal(n = 2)))
  
  print("is_beast_posterior_test: OK")
}

is_beast_posterior_test()
