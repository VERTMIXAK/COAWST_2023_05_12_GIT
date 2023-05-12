#!/bin/bash
source /import/home/jgpender/.runROMSintel
source /import/home/jgpender/.runPycnal

# do a little subsetting on frinkiac
ssh jgpender@frinkiac.oceanmodeling.net '/bin/bash autoPALAU_800m_2.bash'

/bin/rm  *.nc  log */doneFlag.txt

# download some files from frinkiac and process
/usr/bin/scp jgpender@frinkiac.oceanmodeling.net:transfer/HIS0.nc 					.
/usr/bin/scp jgpender@frinkiac.oceanmodeling.net:transfer/HISend_reduce.nc 			.
/usr/bin/scp jgpender@frinkiac.oceanmodeling.net:transfer/surfaceTSUVZ_reduce.nc 	.	

#/bin/bash fixDate.bash
ncatted -O -a units,ocean_time,o,c,"days since 1900-01-01 00:00:00"     HIS0.nc
ncatted -O -a units,ocean_time,o,c,"days since 1900-01-01 00:00:00"     HISend_reduce.nc
ncatted -O -a units,ocean_time,o,c,"days since 1900-01-01 00:00:00"     surfaceTSUVZ_reduce.nc

/import/home/jgpender/.conda/envs/pycnalEnv/bin/python settime.py HIS0.nc                   ocean_time
/import/home/jgpender/.conda/envs/pycnalEnv/bin/python settime.py HISend_reduce.nc          ocean_time
/import/home/jgpender/.conda/envs/pycnalEnv/bin/python settime.py surfaceTSUVZ_reduce.nc    ocean_time

# Get the big jobs running in the background

echo "start IC job" >> log
cd ini
#sleep 1
/bin/bash makeINI.bash &
#sleep 1
#/bin/ps aux |grep jgpender | grep ini.py >> ../log
cd ..

########## do the surface forcing in an earlier job
#echo "start forcing job" >> log
#cd GFS_PALAU_forecast
##sleep 1
#/bin/bash download.bash   &
##`/bin/ps aux |grep jgpender | grep downlo` >> log 
#cd ..



######### While waiting for the IC and surface file generation to finish do this:

# download the BC file

echo "start downloading bdry file" >> log

#/usr/bin/scp jgpender@frinkiac.oceanmodeling.net:transfer/bdry_PALAU_800.nc 			.

/usr/bin/scp jgpender@frinkiac.oceanmodeling.net:transfer/assim_bry.nc       	.
/usr/bin/scp jgpender@frinkiac.oceanmodeling.net:transfer/fore_bry.nc        	.
/usr/bin/ncrcat  assim_bry.nc  fore_bry.nc  bdry_PALAU_800.nc
\rm assim_bry.nc   fore_bry.nc


echo "about to change time units for bdry_PALAU_800.nc" 									>>log
ncatted -O -a units,bry_time,o,c,"days since 1900-01-01 00:00:00"						bdry_PALAU_800.nc
echo "done changing time units for bdry_PALAU_800.nc" >>log 

/import/home/jgpender/.conda/envs/pycnalEnv/bin/python settime.py bdry_PALAU_800.nc    bry_time

echo "done changing time for bdry_PALAU_800.nc" >>log 



# make subsetted versions of Brian's first snapshot


#oldFile=HISend.nc
#newFile=HISend_reduce.nc
#ncks -d xi_rho,206,280 -d eta_rho,42,112 -d xi_psi,206,280 -d eta_psi,42,112 -d xi_u,206,280 -d eta_u,42,112 -d xi_v,206,280 -d eta_v,42,112 $oldFile $newFile

oldFile=HIS0.nc
newFile=HIS0_reduce.nc
ncks -d xi_rho,206,280 -d eta_rho,42,112 -d xi_psi,206,280 -d eta_psi,42,112 -d xi_u,206,280 -d eta_u,42,112 -d xi_v,206,280 -d eta_v,42,112 $oldFile $newFile

#oldFile=surfaceTSUVZ.nc
#newFile=surfaceTSUVZ_reduce.nc
#ncks -d xi_rho,206,280 -d eta_rho,42,112 -d xi_psi,206,280 -d eta_psi,42,112 -d xi_u,206,280 -d eta_u,42,112 -d xi_v,206,280 -d eta_v,42,112 $oldFile $newFile




####### Now wait for the IC and surface forcing files to finish

while [ ! -f ./ini/doneFlag.txt ] 
do
	sleep 10
done

echo "f" >> log

####### do surface forcing job earlier
#while [ ! -f ./GFS_PALAU_forecast/doneFlag.txt ]
#do
#    sleep 10
#done



echo "g" >> log

/bin/bash work.bash


echo "done" >> log
