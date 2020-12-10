is_folder <- function(folder_name) 
{
  # Sees if a name is a valid folder name. Returns TRUE if yes, FALSE if no
  is_folder <- file.info(folder_name)[1,"isdir"]
  if (is.na(is_folder)) { return (FALSE) }
  if (is_folder == TRUE) { return (TRUE) }
  return (FALSE)
}
