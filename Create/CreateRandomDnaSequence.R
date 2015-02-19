CreateRandomDnaSequence <- function(n_sequences)
{
  if (n_sequences < 1)
  {
    print("ERROR: CreateRandomDnaSequence: n_sequences cannot be less than 1")
    return ()
  }
  # define which bases will make up your sequences
  bases <- c(rep('A', 5), rep('C',5), rep('G',5), rep('T',5))
  # set how many sequences you want to produce
  # initialize empty object
  sequences <- rep (NA, n_sequences)
  # populate the object by shuffling and joining your bases
  for (i in 1:n_sequences){
      sequences[i] <- paste(sample(bases, length(bases)), collapse = '')
  }
  return (sequences)
}

print(CreateRandomDnaSequence(1))