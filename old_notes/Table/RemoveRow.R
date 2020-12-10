library(testit)

DemonstrateRemoveRow <- function() {
  #   x y z
  # 1 1 1 1
  # 2 1 2 2
  # 3 1 3 3
  # 4 2 1 4
  # 5 2 2 5
  # 6 2 3 6
  # 7 3 1 7
  # 8 3 2 8
  # 9 3 3 9
  d <- data.frame(
      x = c(1,1,1,2,2,2,3,3,3), 
      y = c(1,2,3,1,2,3,1,2,3), 
      z = c(1,2,3,4,5,6,7,8,9)
  )
  print(d)
  
  # Only select rows with y == 2
  e <- subset(d,y == 2)
  print(e)
  #   x y z
  # 2 1 2 2
  # 5 2 2 5
  # 8 3 2 8  
  
  # Alternative way to select rows with y == 2
  f <- d[d$y == 2,]
  f
  
  
  assert(e == f)
  
}


DemonstrateRemoveRow()