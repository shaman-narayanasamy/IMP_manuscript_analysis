#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/

date
initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/D36/D36_MGMT.R1.fq \
  -2 /mnt/md1200/snarayanasamy/IMP_data/D36/D36_MGMT.R2.fq \
  -d /home/snarayanasamy/Work/metAmosAnalysis/D36_metAmos-IDBAUD_corrected -i 250:500,250:500

runPipeline -d /home/snarayanasamy/Work/metAmosAnalysis/D36_metAmos-IDBAUD_corrected -p 16 -a idba-ud

date
