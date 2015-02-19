library(testit)

CreateRandomBase <- function()
{
  i <- sample(1:4,1)
  if (i == 1) { return ("A"); }
  if (i == 2) { return ("C"); }
  if (i == 3) { return ("G"); }
  if (i == 4) { return ("T"); }
  print("ERROR: CreateRandomBase")
  return (NULL)
}

CreateRandomDnaSequence <- function(n_bases)
{
  if (n_bases < 1)
  {
    print("ERROR: CreateRandomDnaSequence: n_bases cannot be less than 1")
    return ()
  }
  sequence <- NULL
  for (i in 1:n_bases)
  {
    sequence <- paste(CreateRandomBase(),sequence,sep="")
  }
  return (sequence)
}

Test <- function()
{
  {
    b <- CreateRandomBase()
    assert(nchar(b) == 1)
  }

  {
    n_bases <- 10
    s <- CreateRandomDnaSequence(n_bases)
    assert(nchar(s) == n_bases)
  }
  print("Testing done")
}

Test()