#!/bin/bash

if [ ! -d MyFavoritePackages ]
then
  mkdir MyFavoritePackages
fi

TREESIM_FILE=TreeSim_2.2.tar.gz

if [ ! -e MyFavoritePackages/$TREESIM_FILE ]
then
  wget https://cran.r-project.org/src/contrib/$TREESIM_FILE
  mv $TREESIM_FILE MyFavoritePackages/$TREESIM_FILE
fi

if [ ! -d MyFavoritePackages/PBD ]
then
  cd MyFavoritePackages
  tar zxvf $TREESIM_FILE
  cd ..
fi

if [ ! -e MyFavoritePackages/PBD.pdf ]
then
  wget https://cran.r-project.org/web/packages/PBD/PBD.pdf
  mv PBD.pdf MyFavoritePackages/PBD.pdf
fi