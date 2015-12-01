source("~/GitHubs/R/Phylogenies/strip_species_label_from_tip_labels.R")

strip_species_label_from_tip_labels_test <- function() {
  # Invalid tip labels result in an empty string
  assert(strip_species_label_from_tip_label("Sx-1-2") == "")
  assert(strip_species_label_from_tip_label("S1-x-2") == "")
  assert(strip_species_label_from_tip_label("S1-2-x") == "")
  
  # Valid tip labels
  assert(strip_species_label_from_tip_label("S1-2-3") == "3")
  assert(strip_species_label_from_tip_label("S2-2-2") == "2")
  assert(strip_species_label_from_tip_label("S11-2-3") == "3")
  assert(strip_species_label_from_tip_label("S1-22-3") == "3")
  assert(strip_species_label_from_tip_label("S1-2-33") == "33")
  assert(strip_species_label_from_tip_label("S11-22-3") == "3")
  assert(strip_species_label_from_tip_label("S1-22-33") == "33")
  assert(strip_species_label_from_tip_label("S11-2-33") == "33")
  
  # Do multiple labels
  assert(strip_species_label_from_tip_labels(c("S11-11-3","S11-11-33")) == c("3","33"))
  
  print("strip_species_label_from_tip_labels_test: OK")
}

strip_species_label_from_tip_labels_test()
