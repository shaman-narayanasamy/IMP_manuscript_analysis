#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/LAO_MT_only/A02_metAmos_MT-IDBAUD"

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/A02/Lux-Lipids-Community-RNAlater-50ng_CGATGT_L006_R1_001.fastq -2 /mnt/md1200/snarayanasamy/IMP_data/A02/Lux-Lipids-Community-RNAlater-50ng_CGATGT_L006_R2_001.fastq -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 8 -a idba-ud

date
