#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/

date
initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/A02/A02_MGMT.R1.fq \
  -2 /mnt/md1200/snarayanasamy/IMP_data/A02/A02_MGMT.R2.fq \
  -d /home/snarayanasamy/Work/metAmosAnalysis/A02_metAmos-IDBAUD_corrected -i 250:500,250:500

runPipeline -d /home/snarayanasamy/Work/metAmosAnalysis/A02_metAmos-IDBAUD_corrected -p 8 -a idba-ud

date
