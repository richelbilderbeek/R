library(testit)

get_temp_filename <- function(
  prefix = "tmp_",
  file_extension = ".txt"
) {
  return (
    tempfile(
      pattern = prefix,
      fileext = file_extension
    )
  )
}

demonstrate_get_temp_filename <- function() {
  filename <- get_temp_filename()
  print(paste("Filename '",filename,"' obtained",sep=""))
  assert(!file.exists(filename))
  print(paste("Filename '",filename,"' confirmed not to exist",sep=""))
}

demonstrate_get_temp_filename()

