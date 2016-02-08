#!/bin/bash -l

### This script runs metAmos, using IDBA-UD as the assembler, on the simulated mock (SM) dataset 

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/

## Concatenate the fastq files
# For some reason, metAmos on IDBA-UD does parse the second library into the assembly step (with IDBA-UD).
# Therefore, the files are first concatenated prior to running metAmos

cat \
  /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MG_R1.fq \
  /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MT_R1.fq > \
  /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MGMT.R1.fq

cat \
  /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MG_R2.fq \
  /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MT_R2.fq > \
  /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MGMT.R2.fq


## Run metAmos with IDBA_UD

date
initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MGMT.R1.fq \
  -2 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MGMT.R2.fq \
  -d /home/snarayanasamy/Work/metAmosAnalysis/X310763260_metAmos-IDBAUD_corrected -i 250:500,250:500

runPipeline -d /home/snarayanasamy/Work/metAmosAnalysis/X310763260_metAmos-IDBAUD_corrected -p 8 -a idba-ud

date
