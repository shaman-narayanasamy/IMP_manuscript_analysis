#!/bin/bash -l

### This script runs metAmos, using IDBA-UD as the assembler, on the simulated mock (SM) dataset 

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/

## Concatenate the fastq files
# For some reason, metAmos on IDBA-UD does parse the second library into the assembly step (with IDBA-UD).
# Therefore, the files are first concatenated prior to running metAmos

cat \
  /mnt/md1200/snarayanasamy/IMP_data/A02/Lux_Lipids_Community-250111_DNA_TACTTCGG_L007_R1_001.fastq \
  /mnt/md1200/snarayanasamy/IMP_data/A02/Lux-Lipids-Community-RNAlater-50ng_CGATGT_L006_R1_001.fastq > \
  /mnt/md1200/snarayanasamy/IMP_data/A02/A02_MGMT.R1.fq
 
cat \
  /mnt/md1200/snarayanasamy/IMP_data/A02/Lux_Lipids_Community-250111_DNA_TACTTCGG_L007_R2_001.fastq \
  /mnt/md1200/snarayanasamy/IMP_data/A02/Lux-Lipids-Community-RNAlater-50ng_CGATGT_L006_R2_001.fastq > \
  /mnt/md1200/snarayanasamy/IMP_data/A02/A02_MGMT.R2.fq

## Run metAmos with IDBA_UD

date
initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/A02/A02_MGMT.R1.fq \
  -2 /mnt/md1200/snarayanasamy/IMP_data/A02/A02_MGMT.R2.fq \
  -d /home/snarayanasamy/Work/metAmosAnalysis/A02_metAmos-IDBAUD_corrected -i 250:500,250:500

runPipeline -d /home/snarayanasamy/Work/metAmosAnalysis/A02_metAmos-IDBAUD_corrected -p 8 -a idba-ud

date
