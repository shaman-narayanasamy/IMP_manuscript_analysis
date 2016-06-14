#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/HF_MGMT/X317690558_metAmos-IDBAUD"

date

cat /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/MG/X317690558_MG_R1.fq /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/MT/X317690558_MT_R1.fq > /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/X317690558_MGMT.R1.fq

cat /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/MG/X317690558_MG_R2.fq /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/MT/X317690558_MT_R2.fq > /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/X317690558_MGMT.R2.fq

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/X317690558_MGMT.R1.fq \
  -2 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/X317690558_MGMT.R2.fq \
  -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 8 -a idba-ud

rm -rf /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/X317690558_MGMT.R1.fq
rm -rf /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/X317690558_MGMT.R2.fq

date
