#!/bin/bash

for oldName in `ls palau*his_*.nc | tail -5`
do
	newName="ta_"$oldName
	echo $oldName $newName
	ncra -O -v u,v,temp,salt $oldName $newName
	cp -f $oldName /import/VERTMIX/PALAU_2023/ROMS/PALAU_800m/Experiments/AccumulatedData_PALAU_800m_2023
    cp -f $newName /import/VERTMIX/PALAU_2023/ROMS/PALAU_800m/Experiments/AccumulatedData_PALAU_800m_2023
done

for oldName in `ls palau*his2_*.nc | tail -5`
do
    newName="ta_"$oldName
    echo $oldName $newName
    ncra -O -v ubar,vbar,u_sur,v_sur,temp_sur,salt_sur,zeta,EBF,rvort_sur $oldName $newName
    cp -f $oldName /import/VERTMIX/PALAU_2023/ROMS/PALAU_800m/Experiments/AccumulatedData_PALAU_800m_2023
    cp -f $newName /import/VERTMIX/PALAU_2023/ROMS/PALAU_800m/Experiments/AccumulatedData_PALAU_800m_2023
done


