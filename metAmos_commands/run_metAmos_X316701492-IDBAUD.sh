#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/HF_MGMT/X316701492_metAmos-IDBAUD"

date

cat /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/MG/X316701492_MG_R1.fq /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/MT/X316701492_MT_R1.fq > /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/X316701492_MGMT.R1.fq

cat /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/MG/X316701492_MG_R2.fq /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/MT/X316701492_MT_R2.fq > /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/X316701492_MGMT.R2.fq

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/X316701492_MGMT.R1.fq \
  -2 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/X316701492_MGMT.R2.fq \
  -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 16 -a idba-ud

#rm -rf /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/X316701492_MGMT.R1.fq
#rm -rf /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/X316701492_MGMT.R2.fq

date
