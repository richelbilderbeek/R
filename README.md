# R

My notes on the R programming language

 * [Biology](Biology/README.md)
 * [Create](Create/README.md)
 * [Functions](Function/README.md)
 * [Phylogenies](Phylogenies/README.md)
 * [Plot](Plot/README.md)
 * [Scripting](Scripting/README.md)
 * [Statistics](Statistics/README.md)
 * [Stochastic](Stochastic/README.md)
 * [Strings](Strings/README.md)
 * [Syntax](Syntax/README.md)
 * [Tables](Tables/README.md)
 * [Top-Predator-Prey system](TopPredPrey/README.md)


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
