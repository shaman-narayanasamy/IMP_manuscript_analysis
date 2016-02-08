#!/bin/bash -l

### This script runs metAmos (default) on the simulated mock (SM) dataset 

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/

## Run metAmos

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MG_R1.fq,/mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MT_R1.fq -2 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MG_R2.fq,/mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MT_R2.fq -d /home/snarayanasamy/Work/metAmosAnalysis/X310763260_metAmos -i 250:500,250:500

runPipeline -d /home/snarayanasamy/Work/metAmosAnalysis/X310763260_metAmos -p 8

date
