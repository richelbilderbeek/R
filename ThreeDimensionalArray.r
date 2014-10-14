n_values <- 10
n_columns <- 3
n_datasets <- 2
d <- array(0,dim = c(n_values,n_column,n_datasets))
d

i <- 1
for (z in 1:n_datasets)
{
  for (y in 1:n_columns)
  {
		for (x in 1:n_values) 
		{
      d[x,y,z] <- i
    	i <- i + 1
    }
  }
}

d

# Plot the second column of the first dataset
plot(d[ ,2,1],ylim=c(0,100),t="l",col="blue")
# Also plot the second column of the second dataset
lines(d[ ,2,2],col="red")
