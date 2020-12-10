function_to_file <- function(function_name,file_name) {
  # Save a function its code to a file 
  
  sink(file_name)
  print(function_name)
  sink()
}