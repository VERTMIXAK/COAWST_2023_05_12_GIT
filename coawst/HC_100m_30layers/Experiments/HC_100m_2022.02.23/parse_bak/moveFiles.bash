exptDir=`pwd | rev | cut -d '/' -f2 | rev`
mkdir /import/VERTMIX/DABOB_JGP/HC_100m_30layers/Experiments/$exptDir

cp HC*.nc /import/VERTMIX/DABOB_JGP/HC_100m_30layers/Experiments/$exptDir

