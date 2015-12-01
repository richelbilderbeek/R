strip_species_label_from_tip_label <- function(label) {
  # Convert "S[species index]-[species index]-[sub species index]"
  # to "[sub species index]", which is the regex used by PBD
  # Return empty string if it is an incorrectly formed tip label

  my_regex <- "S([[:digit:]]+)-([[:digit:]]+)-([[:digit:]]+)"
  if (length(grep(my_regex,label)) == 0) {
    return ("")
  }
  return (sub(my_regex,"\\3",label,perl=TRUE))
}

strip_species_label_from_tip_labels <- function(labels) {
  new_labels <- NULL
  for (label in labels) {
    new_label = strip_species_label_from_tip_label(label)
    new_labels = c(new_labels, new_label)
  }
  return (new_labels)
}

