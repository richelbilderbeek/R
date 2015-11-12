# Step #1
# Creates files with filename [number].RDa that
# contain the parameters of interest.
library(testit)

CreateJobFiles <- function () {
  for (i in seq(2,36)) {
    my_file <- file(paste("job_",i,".sh",sep=""))
    writeLines(
      c(
        "#!/bin/bash",
        "#SBATCH --time=16:00:00",
        "#SBATCH --nodes=1",
        "#SBATCH --ntasks-per-node=1",
        "#SBATCH --ntasks=1",
        "#SBATCH --mem=100000",
        paste("#SBATCH --job-name=job_",i,sep=""),
        "#SBATCH --mail-type=BEGIN,END",
        "module load R beagle-lib Beast",
        paste("Rscript run_one.R ",i,".RDa",sep="")
      ),
      my_file
    )
    close(my_file)
    
  }
}    
    

#TestCreateParametersFiles()

#CreateParametersFiles()


CreateJobFiles()