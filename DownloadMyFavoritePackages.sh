
if [ ! -e MyFavoritePackages/PBD.pdf ]
then
  wget https://cran.r-project.org/web/packages/PBD/PBD.pdf
  mv PBD.pdf MyFavoritePackages/PBD.pdf
fi

if [ ! -e MyFavoritePackages/PBD_1.0.tar.gz ]
then
  wget https://cran.r-project.org/src/contrib/PBD_1.0.tar.gz
  mv PBD_1.0.tar.gz MyFavoritePackages/PBD_1.0.tar.gz
fi

if [ ! -d MyFavoritePackages/PBD ]
then
  cd MyFavoritePackages
  tar zxvf PBD_1.0.tar.gz
  cd ..
fi