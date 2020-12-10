remove_file_extension <- function(filename) {
  return(tools::file_path_sans_ext(filename))
}