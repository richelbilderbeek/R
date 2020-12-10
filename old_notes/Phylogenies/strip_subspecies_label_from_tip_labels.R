# Convert "[species index]-[species index]-[sub species index]"
# to "[species index]", which is the regex used by PBD
# Return empty string if it is an incorrectly formed tip label
strip_subspecies_label_from_tip_label <- function(label) {
  my_regex <- "S([[:digit:]]+)-([[:digit:]]+)-([[:digit:]]+)"
  if (length(grep(my_regex,label)) == 0) {
    return ("")
  }
  return (sub(my_regex,"\\1",label,perl=TRUE))
}

strip_subspecies_label_from_tip_labels <- function(labels) {
  new_labels <- NULL
  for (label in labels) {
    new_label = strip_subspecies_label_from_tip_label(label)
    new_labels = c(new_labels, new_label)
  }
  return (new_labels)
}