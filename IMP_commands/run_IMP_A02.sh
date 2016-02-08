#!/bin/bash -l

## Run IMP on default mode, using IDBA-UD on the wastewater (WW) sludge dataset

date

python3.4 IMP \
  -m /mnt/md1200/snarayanasamy/IMP_data/A02/Lux_Lipids_Community-250111_DNA_TACTTCGG_L007_R1_001.fastq \
  -m /mnt/md1200/snarayanasamy/IMP_data/A02/Lux_Lipids_Community-250111_DNA_TACTTCGG_L007_R2_001.fastq \
  -t /mnt/md1200/snarayanasamy/IMP_data/A02/Lux-Lipids-Community-RNAlater-50ng_CGATGT_L006_R1_001.fastq \
  -t /mnt/md1200/snarayanasamy/IMP_data/A02/Lux-Lipids-Community-RNAlater-50ng_CGATGT_L006_R2_001.fastq \
  -o  /home/snarayanasamy/Work/IMP_analysis/A02_20151130-idba \
  -c conf/bigbug_config_noHGfilter.imp.json

date
