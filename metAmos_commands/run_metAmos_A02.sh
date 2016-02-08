#!/bin/bash -l

### This script runs metAmos (default) on the simulated mock (SM) dataset 

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/

## Run metAmos

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/A02/Lux_Lipids_Community-250111_DNA_TACTTCGG_L007_R1_001.fastq,/mnt/md1200/snarayanasamy/IMP_data/A02/Lux-Lipids-Community-RNAlater-50ng_CGATGT_L006_R1_001.fastq -2 /mnt/md1200/snarayanasamy/IMP_data/A02/Lux_Lipids_Community-250111_DNA_TACTTCGG_L007_R2_001.fastq,/mnt/md1200/snarayanasamy/IMP_data/A02/Lux-Lipids-Community-RNAlater-50ng_CGATGT_L006_R2_001.fastq -d ./A02_metAmos -i 250:500,250:500

runPipeline -d ./A02_metAmos -p 8

date
