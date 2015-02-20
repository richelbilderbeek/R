library(testit)

# From https://github.com/richelbilderbeek/R
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

# From https://github.com/richelbilderbeek/R
CreateRandomDnaSequence <- function(n_bases)
{
  if (n_bases < 1)
  {
    print("ERROR: CreateRandomDnaSequence: n_bases cannot be less than 1")
    return (NULL)
  }
  sequence <- NULL
  for (i in 1:n_bases)
  {
    sequence <- paste(CreateRandomBase(),sequence,sep="")
  }
  return (sequence)
}

# From https://github.com/richelbilderbeek/R
CreateRandomDnaSequences <- function(n_sequences,n_bases)
{
  if (n_sequences < 1)
  {
    print("ERROR: CreateRandomDnaSequences: n_sequences cannot be less than 1")
    return (NULL)
  }
  if (n_bases < 1)
  {
    print("ERROR: CreateRandomDnaSequences: n_bases cannot be less than 1")
    return (NULL)
  }
  sequences <- NULL
  for (i in 1:n_sequences)
  {
    sequences <- rbind(sequences,CreateRandomDnaSequence(n_bases)) 
  }
  return (sequences)
}

# From https://github.com/richelbilderbeek/R
CreateRandomDnaSequenceTest <- function()
{
  # CreateRandomBase
  {
    b <- CreateRandomBase()
    assert(nchar(b) == 1)
  }
  # CreateRandomDnaSequence
  {
    n_bases <- 10
    s <- CreateRandomDnaSequence(n_bases)
    assert(nchar(s) == n_bases)
  }
  # CreateRandomDnaSequences
  {
    n_sequences <- 2
    n_bases <- 5
    s <- CreateRandomDnaSequences(n_sequences,n_bases)
    assert(length(s) == n_sequences)
    assert(nchar(s[1]) == n_bases)
  }
  # print("Testing CreateRandomDnaSequenceTest done")
}

CreateRandomDnaSequenceTest()