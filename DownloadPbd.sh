#!/bin/bash

if [ ! -d MyFavoritePackages ]
then
  mkdir MyFavoritePackages
fi

cd MyFavoritePackages
git clone https://github.com/rsetienne/PBD.git