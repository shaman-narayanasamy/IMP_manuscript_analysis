#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/SM_MG/simDat_metAmos_MG-IDBAUD"

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MG/73_species_MG_R1_new.fq -2 /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MG/73_species_MG_R2_new.fq -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 8 -a idba-ud

date
