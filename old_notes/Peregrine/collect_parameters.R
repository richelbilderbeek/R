source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")

setwd("~/GitHubs/R/Peregrine")

text <- NULL

for (filename in list.files(path = ".", pattern = "*.RDa")) {
  file <- load_parameters_from_file(filename)
  text <- rbind(text,c(filename,as.numeric(file$parameters[2,])))
}

# Create table headings *after* the creation of the table (order is important here)
for (filename in list.files(path = ".", pattern = "*.RDa")) {
  file <- load_parameters_from_file(filename)
  #print(colnames(file$parameters[2,]))
  colnames(text) <- c("filename",colnames(file$parameters[2,]))
  break
}

write.csv(file="collect_parameters.csv", x=text)

?list.files


file <- load_parameters_from_file("example_1.RDa")
print(file$parameters[2,])
show(file$parameters[2,])
text <- rbind(text,file$parameters[2,])

nrow(file$parameters[2,])
ncol(file$parameters[2,])

as.numeric(file$parameters[2,])
