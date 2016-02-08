#!/bin/bash -l

## Run IMP with MEGAHIT assembler on the simulated mock (SM) dataset

date

python3.4 IMP \
  -m /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MG/73_species_MG_R1_fixed.fq \
  -m /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MG/73_species_MG_R2_fixed.fq \
  -t /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MT/73_species_all_R1.fastq \
  -t /mnt/md1200/snarayanasamy/IMP_data/simulated_data/MT/73_species_all_R2.fastq \
  -o /home/snarayanasamy/Work/IMP_analysis/simulated_data_output_20151002-megahit \
  -c conf/bigbug_config.imp.json \
  -a megahit

date
