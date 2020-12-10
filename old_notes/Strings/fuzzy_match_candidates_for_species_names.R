library(testthat)

get_match_genus_name_only <- function(genus_name, candidate_genus_names)
{
  testthat::expect_equal(length(genus_name), 1)
  testthat::expect_equal(ncol(candidate_genus_names), NULL)
  # Find the max.distance that still yields at least one hit
  good_distance <- -1
  for (distance in seq(1,1000))
  {
    if (length(agrep(genus_name, candidate_genus_names, max.distance = distance)) > 0)
    {
      good_distance <- distance
      break
    }
  }
  match_indices <- agrep(genus_name, candidate_genus_names, max.distance = good_distance)
  return(list(distance = distance, match_indices = match_indices))
}

get_match_species_name_only <- function(genus_name, candidate_genus_names)
{
  return(get_match_genus_name_only(genus_name, candidate_genus_names))
}

get_match_both_names <- function(full_name, candidate_full_names)
{
  return(get_match_genus_name_only(full_name, candidate_full_names))
}

get_best_species_name_match <- function(names, candidates)
{
  testthat::expect_equal(length(names), 2)
  testthat::expect_equal(ncol(candidates), 2)
  testthat::expect_equal(nrow(candidates) > 0, TRUE)
  # If half of the name gives a reasonable match, keep it
  genus_only_name <- names[1]
  taxon_only_name <- names[2]
  full_name <- paste(names[ ,1],names[ ,2],sep="_")
  testthat::expect_equal(length(genus_only_name), 1)
  testthat::expect_equal(length(taxon_only_name), 1)
  testthat::expect_equal(length(full_name), 1)
  candidates_genus_only_names <- candidates[ , 1]
  candidates_taxon_only_names <- candidates[ , 2]
  candidates_full_names <- paste(candidates[ , 1],candidates[ , 2],sep="_")
  testthat::expect_equal(ncol(candidates_genus_only_names), NULL)
  testthat::expect_equal(ncol(candidates_taxon_only_names), NULL)
  testthat::expect_equal(ncol(candidates_full_names), NULL)

  match_genus <- get_match_genus_name_only(genus_only_name, candidates_genus_only_names)
  match_species <- get_match_species_name_only(taxon_only_name, candidates_taxon_only_names)
  match_both <- get_match_both_names(full_name, candidates_full_names)

  return(
    list(
      match_genus = match_genus,
      match_species = match_species,
      match_both = match_both
    )
  )
}



names1 <- read.table("fuzzy_match_candidates_1.csv",
  stringsAsFactors = FALSE, sep = "_"
)
names1 <- unique(names1)
names2 <- read.table("fuzzy_match_candidates_2.csv",
  stringsAsFactors = FALSE, sep = "_"
)
names2 <- unique(names2)
testthat::expect_equal(ncol(names1), 2)
testthat::expect_equal(ncol(names2), 2)


text <- NULL

for (i in c(1,2))
{
  if (i == 1)
  {
    names <- names1
    candidates <- names2
  }
  else
  {
    names <- names2
    candidates <- names1
  }

  for (row in seq(1,nrow(names)))
  #for (row in seq(1,3))
  {
    testthat::expect_equal(ncol(names), 2)
    testthat::expect_equal(ncol(candidates), 2)
    species_name <- names[row, ]
    results <- get_best_species_name_match(species_name,candidates)

    sub_line_genus <- candidates[results$match_genus$match_indices, ]
    sub_line_genus <- paste(sub_line_genus[, 1], sub_line_genus[, 2])
    testthat::expect_equal(ncol(sub_line_genus), NULL)

    sub_line_species <- candidates[results$match_species$match_indices, ]
    sub_line_species <- paste(sub_line_species[, 1], sub_line_species[, 2])
    testthat::expect_equal(ncol(sub_line_species), NULL)

    sub_line_both <- candidates[results$match_both$match_indices, ]
    sub_line_both <- paste(sub_line_both[, 1], sub_line_both[, 2])
    testthat::expect_equal(ncol(sub_line_both), NULL)

    line <- paste(
        paste(species_name, collapse = " "),
        results$match_genus$distance,
        paste(sub_line_genus, collapse = " "),
        results$match_species$distance,
        paste(sub_line_species, collapse = " "),
        results$match_both$distance,
        paste(sub_line_both, collapse = " "),
      sep = ","
    )
    #print(line)
    text <- c(text, line)
  }
}

my_file <- file("fuzzy_match_candidates_result.csv")
writeLines(text, my_file)
close(my_file)
