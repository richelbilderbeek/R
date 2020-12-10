#!/bin/bash

if [ ! -d MyFavoritePackages ]
then
  mkdir MyFavoritePackages
fi

FILE=ape_3.3.tar.gz
FOLDER=ape

if [ ! -e MyFavoritePackages/$FILE ]
then
  echo "Downloading tar"
  wget https://cran.r-project.org/src/contrib/$FILE
  mv $FILE MyFavoritePackages/$FILE
else
  echo "Tar already on disk"
fi

if [ ! -d MyFavoritePackages/$FOLDER ]
then
  echo "Unpacking tar"
  cd MyFavoritePackages
  tar zxvf $FILE
  cd ..
else
  echo "Tar already unpacked"
fi