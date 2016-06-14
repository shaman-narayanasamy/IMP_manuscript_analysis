#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/D36/LAO_Metagenome_D36_TTACTCGC_L007_R1_001.fastq.bz2,/mnt/md1200/snarayanasamy/IMP_data/D36/LAO_Metatranscriptome_D36_CGATGT_L006_R1_001.fastq.bz2 -2 /mnt/md1200/snarayanasamy/IMP_data/D36/LAO_Metagenome_D36_TTACTCGC_L007_R2_001.fastq.bz2,/mnt/md1200/snarayanasamy/IMP_data/D36/LAO_Metatranscriptome_D36_CGATGT_L006_R2_001.fastq.bz2 -d /home/snarayanasamy/Work/metAmosAnalysis/D36_metAmos -i 250:500,250:500

runPipeline -d /home/snarayanasamy/Work/metAmosAnalysis/D36_metAmos -p 8

date
