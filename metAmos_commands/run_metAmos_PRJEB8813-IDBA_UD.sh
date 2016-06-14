#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/PRJEB8813_metAmos_MGMT-IDBAUD"

date
zcat /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/MG/PRJEB8813_MG.R1.fq.gz /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/MT/ERR843255_1.fastq.gz > /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/PRJEB8813_MGMT.R1.fq
zcat /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/MG/PRJEB8813_MG.R2.fq.gz /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/MT/ERR843255_2.fastq.gz > /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/PRJEB8813_MGMT.R2.fq

initPipeline -1 /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/PRJEB8813_MGMT.R1.fq -2 /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/PRJEB8813_MGMT.R2.fq -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 16 -a idba-ud

#rm -rf /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/PRJEB8813_MGMT.R1.fq
#rm -rf /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/PRJEB8813_MGMT.R2.fq

date
