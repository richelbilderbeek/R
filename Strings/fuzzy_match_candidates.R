names1 <- read.table("fuzzy_match_candidates_1.csv", stringsAsFactors = FALSE)
names1 <- as.vector(names1[ ,1])
names2 <- read.table("fuzzy_match_candidates_2.csv", stringsAsFactors = FALSE)
names2 <- as.vector(names2[ ,1])


text <- NULL

for (name in names1)
{
  # Find the max.distance that still yields at least one hit
  good_distance <- -1
  for (distance in seq(1,1000))
  {
    if (length(agrep(name, names2, max.distance = distance)) > 0)
    {
      good_distance <- distance
      break
    }
  }
  # Show the hits
  match_names <- names2[ agrep(name, names2, max.distance = good_distance) ]
  line <- paste(
      name,
      good_distance,
      match_names, sep = ","
    )
  text <- c(text, line)
}

my_file <- file("fuzzy_match_candidates_result.csv")
writeLines(text, my_file)
close(my_file)
