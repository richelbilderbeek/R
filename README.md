# R

Repo       |[GitHub Actions](https://github.com/informalr/informalr/actions)                                     |[![Codecov logo](man/figures/Codecov.png)](https://www.codecov.io)
-----------|-----------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------
`informalr`|![R-CMD-check](https://github.com/informalr/informalr/workflows/R-CMD-check/badge.svg?branch=master) |[![codecov.io](https://codecov.io/github/informalr/informalr/coverage.svg?branch=master)](https://codecov.io/github/informalr/informalr/branch/master)

My notes on the R programming language

```
This repository is being phased out
```

The contents of this repository will move into [the ribir package](https://github.com/richelbilderbeek/ribir).

## install rJava

```
sudo apt-get install openjdk-8-*
sudo R CMD javareconf
```

Do so with RStudio closed.

## libjvm.so: cannot open shared object file: No such file or directory

```
error: unable to load shared object '/home/richel/R/i686-pc-linux-gnu-library/3.2/rJava/libs/rJava.so':
  libjvm.so: cannot open shared object file: No such file or directory
```

Close RStudio, then:

```
sudo R CMD javareconf
```


## I want to collaborate

Awesome!

Feel invited to post an Issue and/or submit a Poll Request in this GitHub its coding standard.

This GitHub follows the guidelines from the codings standard(s) of [R-CodingStandard](https://github.com/richelbilderbeek/R-CodingStandard).

This means 
 * A function that foos a bar is named `foo_bar`
 * That function is put in a file called `foo_bar.R`
 * Its test is in `foo_bar_test.R`

There is some older code that pre-dates the R coding standard(s), you are welcome to clean 
that up :-)

## Hack to let `plyr` work on R 3.0.2

This is _not_ a recommended procedure. 

This procedure:

 * Download the `plyr` tarball
 * Unpacks the `plyr` tarball
 * Modified the `plyr/DESCRPTION` file to depend on R 3.0.2
 * Delete the original `plyr` tarball
 * Packs the hacked tarball

The hacked tarball can then be installed in R. Sure, the MD5 checksum will fail :-)

```
PLYR_FILE=plyr_1.8.3.tar.gz

# Download the `plyr` tarball
wget https://cran.r-project.org/src/contrib/$PLYR_FILE

# Unpacks the `plyr` tarball
tar zxvf $PLYR_FILE

# Modified the `plyr/DESCRPTION` file to depend on R 3.0.2
sed -i plyr/DESCRIPTION -e 's/Depends: R (>= 3.1.0)/Depends: R (>= 3.0.2)/'

# Delete the original `plyr` tarball
rm $PLYR_FILE

# Packs the hacked tarball
tar cvzf $PLYR_FILE plyr/*
```

This is the bare-bone version of the full script in [DownloadPlyr.sh](DownloadPlyr.sh).
