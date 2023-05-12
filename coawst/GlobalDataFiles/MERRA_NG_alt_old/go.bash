source ~/.runROMSintel

\rm -rf M2T1NXINT
cp -R ../MERRA_getData_template/M2T1NXINT .


\rm -rf M2T1NXALB
cp -R ../MERRA_getData_template/M2T1NXALB .



\rm -rf M2T1NXRAD
cp -R ../MERRA_getData_template/M2T1NXRAD .


\rm -rf M2T1NXSLV
cp -R ../MERRA_getData_template/M2T1NXSLV .

echo "done copying"

year=`head -2 subset_ALB.txt | tail -1 | cut -d '&' -f1 | rev | cut -d '.' -f2 | rev | cut -c 1-4`
#year=`head -2 subset_ALBb.txt | tail -1 | grep -Eo [0-9]{8} | cut -c 1-4`
#year=`pwd | rev | cut -d '_' -f1 | rev`

echo $year


sed -i "s/YYYY/$year/" M2*/*.py
sed -i "s/YYYY/$year/" M2*/*.m
sed -i "s/YYYY/$year/" M2*/*.bash


exit


cd M2T1NXALB
bash batch*.bash


cd ../M2T1NXINT
bash batch*.bash

cd ../M2T1NXRAD 
bash batch*.bash

cd ../M2T1NXSLV
bash batch*.bash

