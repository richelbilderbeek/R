#!/bin/bash

if [ ! -d MyFavoritePackages ]
then
  mkdir MyFavoritePackages
fi

PBD_FILE=PBD_1.0.tar.gz

if [ ! -e MyFavoritePackages/$PBD_FILE ]
then
  wget https://cran.r-project.org/src/contrib/$PBD_FILE
  mv $PBD_FILE MyFavoritePackages/$PBD_FILE
fi

if [ ! -d MyFavoritePackages/PBD ]
then
  cd MyFavoritePackages
  tar zxvf $PBD_FILE
  cd ..
fi

if [ ! -e MyFavoritePackages/PBD.pdf ]
then
  wget https://cran.r-project.org/web/packages/PBD/PBD.pdf
  mv PBD.pdf MyFavoritePackages/PBD.pdf
fi