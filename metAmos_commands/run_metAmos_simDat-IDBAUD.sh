#!/bin/bash -l

### This script runs metAmos, using IDBA-UD as the assembler, on the simulated mock (SM) dataset 

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/

## Concatenate the fastq files
# For some reason, metAmos on IDBA-UD does parse the second library into the assembly step (with IDBA-UD).
# Therefore, the files are first concatenated prior to running metAmos

cat \
  /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MG/73_species_MG_R1_fixed.fq \
  /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MT/73_species_all_R1.fastq > \
  /mnt/md1200/snarayanasamy/IMP_data/simulated_data/73_species_MGMT.R1.fastq

cat \
  /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MG/73_species_MG_R2_fixed.fq \
  /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MT/73_species_all_R2.fastq > \
  /mnt/md1200/snarayanasamy/IMP_data/simulated_data/73_species_MGMT.R1.fastq

## Run metAmos with IDBA_UD

date
initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/simulated_data/73_species_MGMT.R1.fastq \
  -2 /mnt/md1200/snarayanasamy/IMP_data/simulated_data/73_species_MGMT.R2.fastq \
  -d /home/snarayanasamy/Work/metAmosAnalysis/simDat_metAmos-IDBAUD_corrected -i 250:500,250:500

runPipeline -d /home/snarayanasamy/Work/metAmosAnalysis/simDat_metAmos-IDBAUD_corrected -p 8 -a idba-ud

date
