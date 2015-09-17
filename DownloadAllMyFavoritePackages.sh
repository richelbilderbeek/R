
if [ ! -d MyFavoritePackages ]
then
  mkdir MyFavoritePackages
fi

./DownloadApe.sh
./DownloadPdb.sh
./DownloadPhyloch.sh
./DownloadPlyr.sh
