DemonstrateAddColumn <- function() {

  my_table <- data.frame( row.names = c("Unit","Value"))
  my_table[, "g"] <- c("m/s^2",9.81)
  my_table
  my_table[, "v"] <- c("m/s",300000)
  my_table
}

DemonstrateAddColumn()