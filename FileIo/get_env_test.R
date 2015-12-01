source("~/GitHubs/R/FileIo/get_env.R")

get_env_test <- function() {
  v <- c("SESSION", "HOSTNAME", "PATH", "HOME")
  for (s in v) {
    print(paste(s,": '",get_env(s),"'",sep=""))
  }
}

get_env_test()