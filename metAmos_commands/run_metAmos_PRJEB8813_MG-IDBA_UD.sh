#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/PRJEB8813_metAmos_MG-IDBAUD"

date

initPipeline -1 /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/MG/PRJEB8813_MG.R1.fq.gz -2 /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/MG/PRJEB8813_MG.R2.fq.gz -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 16 -a idba-ud

date
