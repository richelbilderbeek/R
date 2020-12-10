source("~/GitHubs/R/FileIo/save_text.R")

my_text <- c(
  toBibtex(citation()),
  toBibtex(citation(package = "ape")),
  toBibtex(citation(package = "ggplot2")),
  toBibtex(citation(package = "gridExtra")),
  toBibtex(citation(package = "nLTT")),
  toBibtex(citation(package = "testit")),
  toBibtex(citation(package = "tools")),
  toBibtex(citation(package = "PBD")),
  toBibtex(citation(package = "phangorn")),
  toBibtex(citation(package = "geiger")),
  toBibtex(citation(package = "PBD")),
  toBibtex(citation(package = "PBD")),
  "@Manual{,",
  "  title = {rBEAST},",
  "  author = {olli0601},",
  "}"
)




save_text(filename = "tmp.bib", text = my_text)

