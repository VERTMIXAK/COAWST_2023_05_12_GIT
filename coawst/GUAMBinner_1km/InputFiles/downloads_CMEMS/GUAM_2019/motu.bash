source ~/.runPycnal
while [ ! -f data_PHY/GLOBAL_REANALYSIS_PHY_001_030-TDS_2022_009.nc ]
do
python -m motuclient --motu http://my.cmems-du.eu/motu-web/Motu --service-id GLOBAL_REANALYSIS_PHY_001_030-TDS --product-id global-reanalysis-phy-001-030-daily  --longitude-min 130 --longitude-max 160 --latitude-min 0 --latitude-max 30 --date-min "2022-01-09 12:00:00" --date-max "2022-01-09 12:00:00" --depth-min 0.493 --depth-max 5727.918000000001 --variable thetao --variable so --variable zos --variable uo --variable vo --variable mlotst   --out-dir ./data_PHY  --out-name GLOBAL_REANALYSIS_PHY_001_030-TDS_2022_009.nc --user jpender --pwd hiphopCMEMS3~
done
while [ ! -f data_PHY/GLOBAL_REANALYSIS_PHY_001_030-TDS_2022_010.nc ]
do
python -m motuclient --motu http://my.cmems-du.eu/motu-web/Motu --service-id GLOBAL_REANALYSIS_PHY_001_030-TDS --product-id global-reanalysis-phy-001-030-daily  --longitude-min 130 --longitude-max 160 --latitude-min 0 --latitude-max 30 --date-min "2022-01-10 12:00:00" --date-max "2022-01-10 12:00:00" --depth-min 0.493 --depth-max 5727.918000000001 --variable thetao --variable so --variable zos --variable uo --variable vo --variable mlotst   --out-dir ./data_PHY  --out-name GLOBAL_REANALYSIS_PHY_001_030-TDS_2022_010.nc --user jpender --pwd hiphopCMEMS3~
done
while [ ! -f data_PHY/GLOBAL_REANALYSIS_PHY_001_030-TDS_2022_011.nc ]
do
python -m motuclient --motu http://my.cmems-du.eu/motu-web/Motu --service-id GLOBAL_REANALYSIS_PHY_001_030-TDS --product-id global-reanalysis-phy-001-030-daily  --longitude-min 130 --longitude-max 160 --latitude-min 0 --latitude-max 30 --date-min "2022-01-11 12:00:00" --date-max "2022-01-11 12:00:00" --depth-min 0.493 --depth-max 5727.918000000001 --variable thetao --variable so --variable zos --variable uo --variable vo --variable mlotst   --out-dir ./data_PHY  --out-name GLOBAL_REANALYSIS_PHY_001_030-TDS_2022_011.nc --user jpender --pwd hiphopCMEMS3~
done
