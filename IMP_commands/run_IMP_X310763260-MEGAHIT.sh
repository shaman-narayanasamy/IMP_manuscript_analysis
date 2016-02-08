#!/bin/bash -l

## Run IMP with MEGAHIT assembler on the human fecal (HF) dataset

date

python3.4 IMP \
  -m /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MG_R1.fq \
  -m /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MG_R2.fq \
  -t /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MT_R1.fq \
  -t /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X310763260/X310763260_MT_R2.fq \
  -o /home/snarayanasamy/Work/IMP_analysis/X310763260_20151006-megahit \
  -c conf/bigbug_config.imp.json \
  -a megahit

date
