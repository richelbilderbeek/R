#From https://github.com/richelbilderbeek/R/blob/master/FileIo/FunctionToFile.R
FunctionToFile <- function(function_name,file_name) 
{
  sink(file_name)
  print(function_name)
  sink()
}

library(testit)

temp_filename <- "~/tmp.txt"
FunctionToFile(assert,temp_filename)
FunctionToFile(FunctionToFile,temp_filename)

