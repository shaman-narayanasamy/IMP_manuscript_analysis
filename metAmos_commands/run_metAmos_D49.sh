#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/

date

initPipeline -1 /mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metagenomic/time_series/D49/LAO_Metagenome_D49_TAGACGGA_L008_R1_001.fastq.bz2,/mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metatranscriptomic/time_series/D49/LAO_Metatranscriptome_D49_ATCACG_L008_R1_001.fastq.bz2 -2 /mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metagenomic/time_series/D49/LAO_Metagenome_D49_TAGACGGA_L008_R2_001.fastq.bz2,/mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metatranscriptomic/time_series/D49/LAO_Metatranscriptome_D49_ATCACG_L008_R2_001.fastq.bz2 -d ./D49_metAmos_MGMT -i 250:500,250:500

runPipeline -d ./D49_metAmos_MGMT -p 8

date
