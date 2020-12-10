# Function to determine if two files have identical content

files_are_equal <- function(filename1, filename2) {
  assert(file.exists(filename1))
  assert(file.exists(filename2))

  a <- readLines(filename1)
  b <- readLines(filename2)
  return (identical(a,b))
}