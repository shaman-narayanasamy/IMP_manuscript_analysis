#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/LAO_MGMT/D49_metAmos_MGMT-IDBAUD"

date
bzcat /mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metagenomic/time_series/D49/LAO_Metagenome_D49_TAGACGGA_L008_R1_001.fastq.bz2 /mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metatranscriptomic/time_series/D49/LAO_Metatranscriptome_D49_ATCACG_L008_R1_001.fastq.bz2 > /mnt/md1200/snarayanasamy/archived_raw_data/LAO/LAO_MGMT_D49_R1.fastq
bzcat /mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metagenomic/time_series/D49/LAO_Metagenome_D49_TAGACGGA_L008_R2_001.fastq.bz2 /mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metatranscriptomic/time_series/D49/LAO_Metatranscriptome_D49_ATCACG_L008_R2_001.fastq.bz2 > /mnt/md1200/snarayanasamy/archived_raw_data/LAO/LAO_MGMT_D49_R2.fastq

initPipeline -1 /mnt/md1200/snarayanasamy/archived_raw_data/LAO/LAO_MGMT_D49_R1.fastq -2 /mnt/md1200/snarayanasamy/archived_raw_data/LAO/LAO_MGMT_D49_R2.fastq -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 16 -a idba-ud

date
