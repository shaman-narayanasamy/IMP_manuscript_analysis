#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/A02_metAmos_MG-IDBAUD"

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/A02/Lux_Lipids_Community-250111_DNA_TACTTCGG_L007_R1_001.fastq -2 /mnt/md1200/snarayanasamy/IMP_data/A02/Lux_Lipids_Community-250111_DNA_TACTTCGG_L007_R2_001.fastq -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 8 -a idba-ud

date
