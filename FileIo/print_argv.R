argv <- commandArgs(trailingOnly = TRUE)
if (length(argv) == 0) {
  print("No arguments supplied")
}
for (s in argv) {
  print(s)
}