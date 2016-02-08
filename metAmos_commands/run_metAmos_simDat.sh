#!/bin/bash -l

### This script runs metAmos (default) on the simulated mock (SM) dataset 

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/

## Run metAmos

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MG/73_species_MG_R1_fixed.fq,/mnt/md1200/snarayanasamy/IMP_data/simulated_data/MT/73_species_all_R1.fastq -2 /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MG/73_species_MG_R2_fixed.fq,/mnt/md1200/snarayanasamy/IMP_data/simulated_data/MT/73_species_all_R2.fastq -d /home/snarayanasamy/Work/metAmosAnalysis/simDat_metAmos -i 250:500,250:500

runPipeline -d /home/snarayanasamy/Work/metAmosAnalysis/simDat_metAmos -p 8

date
