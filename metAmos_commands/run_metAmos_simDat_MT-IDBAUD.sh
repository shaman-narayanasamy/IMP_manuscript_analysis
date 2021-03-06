#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/SM_MT/simDat_metAmos_MT-IDBAUD"

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MT/73_species_MT_R1_new.fq -2 /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MT/73_species_MT_R2_new.fq -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 8 -a idba-ud

date
