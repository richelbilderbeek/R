library(testit)

AreAllIdentical <- function(container) 
{
  return (length(unique(container)) == 1)
}

DemonstrateAreAllIdentical <- function() {
  assert(!AreAllIdentical(c()))
  assert( AreAllIdentical(c(1)))
  assert(!AreAllIdentical(c(1,2)))
  assert(!AreAllIdentical(c(1,2,3)))
  assert(!AreAllIdentical(c(1,2,3,4)))
  assert(!AreAllIdentical(c(1,2,4,4)))
  assert(!AreAllIdentical(c(1,4,4,4)))
  assert( AreAllIdentical(c(4,4,4,4)))
}

#DemonstrateAreAllIdentical()