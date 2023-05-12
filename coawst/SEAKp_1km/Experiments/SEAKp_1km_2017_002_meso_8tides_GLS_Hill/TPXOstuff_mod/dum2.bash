module purge
. /etc/profile.d/modules.sh
module load matlab/R2013a
#matlab -nodisplay -nosplach <  tideComparison_M2.m
#matlab -nodisplay -nosplash <  tideComparison_K1.m
matlab -nodisplay -nosplash <  tideComparison_O1.m
matlab -nodisplay -nosplash <  tideComparison_S2.m
