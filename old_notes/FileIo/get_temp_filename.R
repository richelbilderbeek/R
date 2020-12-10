get_temp_filename <- function(
  prefix = "tmp_",
  file_extension = ".txt",
  full_path = TRUE
) {
  # Produces a temporary file name like '/tmp/RtmpgVAoFh/tmp_73be5139b316.txt'
  # It is guaranteed that the file does not exist
  # Set full_path to FALSE to obtain only 'tmp_73be5139b316.txt'
  filename <- tempfile(
    pattern = prefix,
    fileext = file_extension
  )
  if (full_path) { 
    return (filename) 
  }
  return (basename(filename))
}