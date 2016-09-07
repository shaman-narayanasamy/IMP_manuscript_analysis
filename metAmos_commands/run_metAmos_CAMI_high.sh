#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/CAMI_high"

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/CAMI/High_Complexity_Dataset/HCTD.1.fq -2 /mnt/md1200/snarayanasamy/IMP_data/CAMI/High_Complexity_Dataset/HCTD.1.fq -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 8

date
