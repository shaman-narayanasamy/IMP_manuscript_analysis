#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/CAMI_medium"

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/CAMI/Medium_Complexity_Test_Dataset/MCTD.1.fq -2 /mnt/md1200/snarayanasamy/IMP_data/CAMI/Medium_Complexity_Test_Dataset/MCTD.2.fq -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 8

date
