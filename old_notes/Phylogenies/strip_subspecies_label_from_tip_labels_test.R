source("~/GitHubs/R/Phylogenies/strip_subspecies_label_from_tip_labels.R")

library(testit)

strip_subspecies_label_from_tip_labels_test <- function() {
  # Invalid tip labels result in an empty string
  assert(strip_subspecies_label_from_tip_label("Sx-1-2") == "")
  assert(strip_subspecies_label_from_tip_label("S1-x-2") == "")
  assert(strip_subspecies_label_from_tip_label("S1-2-x") == "")
  
  # Valid tip labels
  assert(strip_subspecies_label_from_tip_label("S1-2-3") == "1")
  assert(strip_subspecies_label_from_tip_label("S2-2-2") == "2")
  assert(strip_subspecies_label_from_tip_label("S11-2-3") == "11")
  assert(strip_subspecies_label_from_tip_label("S1-22-3") == "1")
  assert(strip_subspecies_label_from_tip_label("S1-2-33") == "1")
  assert(strip_subspecies_label_from_tip_label("S11-22-3") == "11")
  assert(strip_subspecies_label_from_tip_label("S1-22-33") == "1")
  assert(strip_subspecies_label_from_tip_label("S11-2-33") == "11")
  
  # Do multiple labels
  assert(strip_subspecies_label_from_tip_labels(c("S11-11-3","S1-1-33")) == c("11","1"))

  print("strip_subspecies_label_from_tip_labels_test: OK")
}

strip_subspecies_label_from_tip_labels_test()
