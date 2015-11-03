library(testit)

# Convert "[species index]-[species index]-[sub species index]"
# to "[species index]", which is the regex used by PBD
# Return empty string if it is an incorrectly formed tip label
StripSubspeciesLabelFromTipLabel <- function(label) {
  my_regex <- "S([[:digit:]]+)-([[:digit:]]+)-([[:digit:]]+)"
  if (length(grep(my_regex,label)) == 0) {
    return ("")
  }
  return (sub(my_regex,"\\1",label,perl=TRUE))
}

StripSubspeciesLabelFromTipLabels <- function(labels) {
  new_labels <- NULL
  for (label in labels) {
    new_label = StripSubspeciesLabelFromTipLabel(label)
    new_labels = c(new_labels, new_label)
  }
  return (new_labels)
}

DemonstrateStripSubspeciesLabelFromTipLabels <- function() {
  # Invalid tip labels result in an empty string
  assert(StripSubspeciesLabelFromTipLabel("Sx-1-2") == "")
  assert(StripSubspeciesLabelFromTipLabel("S1-x-2") == "")
  assert(StripSubspeciesLabelFromTipLabel("S1-2-x") == "")
  
  # Valid tip labels
  assert(StripSubspeciesLabelFromTipLabel("S1-2-3") == "1")
  assert(StripSubspeciesLabelFromTipLabel("S2-2-2") == "2")
  assert(StripSubspeciesLabelFromTipLabel("S11-2-3") == "11")
  assert(StripSubspeciesLabelFromTipLabel("S1-22-3") == "1")
  assert(StripSubspeciesLabelFromTipLabel("S1-2-33") == "1")
  assert(StripSubspeciesLabelFromTipLabel("S11-22-3") == "11")
  assert(StripSubspeciesLabelFromTipLabel("S1-22-33") == "1")
  assert(StripSubspeciesLabelFromTipLabel("S11-2-33") == "11")
  
  # Do multiple labels
  assert(StripSubspeciesLabelFromTipLabels(c("S11-11-3","S1-1-33")) == c("11","1"))
}

#DemonstrateStripSubspeciesLabelFromTipLabels()
