
if [ ! -d MyFavoritePackages ]
then
  mkdir MyFavoritePackages
fi

./DownloadApe.sh
./DownloadDeSolve.sh
./DownloadGeiger.sh
./DownloadPdb.sh
./DownloadPhangorn.sh
./DownloadPhyloch.sh
./DownloadPlyr.sh
