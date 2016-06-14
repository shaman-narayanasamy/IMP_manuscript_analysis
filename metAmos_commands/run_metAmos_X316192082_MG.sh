#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/HF_MG/X316192082_metAmos_MG"

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316192082/MG/X316192082_MG_R1.fq -2 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316192082/MG/X316192082_MG_R2.fq -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 8

date
