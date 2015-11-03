library(testit)

AreAllUnique <- function(container) 
{
  return (length(container) == length(unique(container)))
}

DemonstrateAreAllUnique <- function() {
  assert(AreAllUnique(c()))
  assert(AreAllUnique(c(1)))
  assert(AreAllUnique(c(1,2)))
  assert(AreAllUnique(c(1,2,3)))
  assert(AreAllUnique(c(1,2,3,4)))
  assert(!AreAllUnique(c(1,2,4,4)))
  assert(!AreAllUnique(c(1,4,4,4)))
  assert(!AreAllUnique(c(4,4,4,4)))
}

#DemonstrateAreAllUnique()