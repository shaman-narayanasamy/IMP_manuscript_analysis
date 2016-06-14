#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/HF_MT/X316701492_metAmos_MT-IDBAUD"

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/MT/X316701492_MT_R1.fq -2 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/MT/X316701492_MT_R2.fq -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 8 -a idba-ud

date
