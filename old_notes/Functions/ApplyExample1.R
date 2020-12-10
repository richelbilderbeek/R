library(testit)

# Create a table with dinosaur names and their estimated weights
names <- c("Albertosaurus","Allosaurus","Baryonyx")
weights_in_tons <- c(3,5,2)
table <- cbind(names,weights_in_tons)
print(table)

# Store in temp 
temp <- apply(table,1, function(row) print(paste("The", row[1],"weighted",row[2],"tons")))
temp <- apply(
  table,
  1, 
  function(row) { 
    print(paste("The", row[1],"weighted",row[2],"tons")) 
  } 
)
