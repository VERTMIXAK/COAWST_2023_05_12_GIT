#!/bin/bash

\rm *.sbat *.py runAll.bash

sourceFiles='../his_08049/scheduleForDeletion/fleat_his_08049_'
iniDir='../ini_014_n50/'

for ii in `seq 0 7`
do
	for jj in `seq 0 2 8`
	do

        jjPlusOne=$(($jj + 1))

		batName="bat"$ii"_"$jj".sbat"
#		echo $batName
		cp headBat.txt $batName
		echo "python bry"$ii"_"$jj".py" >> $batName

		bryName="bry"$ii"_"$jj".py"
		cp headBry.txt $bryName

		echo 'wts_file = "'$iniDir'remap_weights_PALAU_BrianFull_to_PALAU_800m_bilinear_*"' 	>> $bryName
        cat midBry.txt 																			>> $bryName
 		echo "myArg = 'ls "$sourceFiles$ii$jj'*.nc '$sourceFiles$ii$jjPlusOne'*.nc' "'"  		>> $bryName
		cat tailBry.txt 																		>> $bryName

		echo "sbatch " $batName >> runAll.bash

	done
done
