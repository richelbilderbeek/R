#!/bin/bash

if [ ! -d MyFavoritePackages ]
then
  mkdir MyFavoritePackages
fi

APE_FILE=ape_3.3.tar.gz

if [ ! -e MyFavoritePackages/$APE_FILE ]
then
  echo "Downloading plyr tar"
  wget https://cran.r-project.org/src/contrib/$APE_FILE
  mv $APE_FILE MyFavoritePackages/$APE_FILE
else
  echo "tar already on disk"
fi

if [ ! -d MyFavoritePackages/plyr ]
then
  echo "Unpacking plyr tar"
  cd MyFavoritePackages
  tar zxvf $APE_FILE
  cd ..
else
  echo "tar already unpacked"
fi