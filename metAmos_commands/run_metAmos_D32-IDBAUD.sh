#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/LAO_MGMT/D32_metAmos_MGMT-IDBAUD"

date

bzcat /mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metagenomic/time_series/D32/LAO_Metagenome-D32_TACCGAGC_L004_R1_001.fastq.bz2 /mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metatranscriptomic/time_series/D32/LAO_Metatranscriptome-D32_TAGCTT_L003_R1_001.fastq.bz2 > /mnt/md1200/snarayanasamy/archived_raw_data/LAO/LAO_MGMT-D32_R1.fastq

bzcat /mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metagenomic/time_series/D32/LAO_Metagenome-D32_TACCGAGC_L004_R2_001.fastq.bz2 /mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metatranscriptomic/time_series/D32/LAO_Metatranscriptome-D32_TAGCTT_L003_R2_001.fastq.bz2 > /mnt/md1200/snarayanasamy/archived_raw_data/LAO/LAO_MGMT-D32_R2.fastq

initPipeline -1 /mnt/md1200/snarayanasamy/archived_raw_data/LAO/LAO_MGMT-D32_R1.fastq -2 /mnt/md1200/snarayanasamy/archived_raw_data/LAO/LAO_MGMT-D32_R2.fastq -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 16 -a idba-ud

#rm -rf /mnt/md1200/snarayanasamy/archived_raw_data/LAO/LAO_MGMT-D32_R1.fastq
#rm -rf /mnt/md1200/snarayanasamy/archived_raw_data/LAO/LAO_MGMT-D32_R2.fastq

date
