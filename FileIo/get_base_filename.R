source("~/GitHubs/R/FileIo/remove_file_extension.R")

get_base_filename <- function(filename) {
  # Returns the filename with extension and path stripped
  # For example, 'home/luke/the_force.txt' becomes 'the_force'
  return (tools::file_path_sans_ext(basename(filename)))
}