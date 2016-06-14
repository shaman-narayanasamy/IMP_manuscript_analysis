#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/HF_MT/X317690558_metAmos_MT"

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/MT/X317690558_MT_R1.fq -2 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X317690558/MT/X317690558_MT_R2.fq -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 8

date

