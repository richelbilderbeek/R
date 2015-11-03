library(testit)

# Convert "S[species index]-[species index]-[sub species index]"
# to "[sub species index]", which is the regex used by PBD
# Return empty string if it is an incorrectly formed tip label
StripSpeciesLabelFromTipLabel <- function(label) {
  my_regex <- "S([[:digit:]]+)-([[:digit:]]+)-([[:digit:]]+)"
  if (length(grep(my_regex,label)) == 0) {
    return ("")
  }
  return (sub(my_regex,"\\3",label,perl=TRUE))
}

StripSpeciesLabelFromTipLabels <- function(labels) {
  new_labels <- NULL
  for (label in labels) {
    new_label = StripSpeciesLabelFromTipLabel(label)
    new_labels = c(new_labels, new_label)
  }
  return (new_labels)
}

DemonstrateStripSpeciesLabelFromTipLabels <- function() {
  # Invalid tip labels result in an empty string
  assert(StripSpeciesLabelFromTipLabel("Sx-1-2") == "")
  assert(StripSpeciesLabelFromTipLabel("S1-x-2") == "")
  assert(StripSpeciesLabelFromTipLabel("S1-2-x") == "")
  
  # Valid tip labels
  assert(StripSpeciesLabelFromTipLabel("S1-2-3") == "3")
  assert(StripSpeciesLabelFromTipLabel("S2-2-2") == "2")
  assert(StripSpeciesLabelFromTipLabel("S11-2-3") == "3")
  assert(StripSpeciesLabelFromTipLabel("S1-22-3") == "3")
  assert(StripSpeciesLabelFromTipLabel("S1-2-33") == "33")
  assert(StripSpeciesLabelFromTipLabel("S11-22-3") == "3")
  assert(StripSpeciesLabelFromTipLabel("S1-22-33") == "33")
  assert(StripSpeciesLabelFromTipLabel("S11-2-33") == "33")
  
  # Do multiple labels
  assert(StripSpeciesLabelFromTipLabels(c("S11-11-3","S11-11-33")) == c("3","33"))
}

#DemonstrateStripSpeciesLabelFromTipLabels()
