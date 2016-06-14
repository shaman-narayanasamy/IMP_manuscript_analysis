#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/MG/X317690558_MG_R1.fq,/mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/MT/X317690558_MT_R1.fq -2 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/MG/X317690558_MG_R2.fq,/mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/MT/X317690558_MT_R2.fq -d /home/snarayanasamy/Work/metAmosAnalysis/X317690558_metAmos_MGMT -i 250:500,250:500

runPipeline -d /home/snarayanasamy/Work/metAmosAnalysis/X317690558_metAmos_MGMT -p 8

date
