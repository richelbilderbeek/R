#From https://github.com/richelbilderbeek/R/blob/master/FileIo/FunctionToFile.R
FunctionToFile <- function(function_name,file_name) 
{
  sink(file_name)
  print(function_name)
  sink()
}

library(testit)

DemonstrateFunctionToFile <- function() {
  temp_filename <- "~/tmp.txt"
  # Write the function to file
  FunctionToFile(FunctionToFile,temp_filename)
  # Show the file its content
  readLines(temp_filename)
}


# Uncomment this to view the function demonstration
#DemonstrateFunctionToFile()
