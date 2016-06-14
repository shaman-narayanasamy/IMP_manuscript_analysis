#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/LAO_MT_only/D32_metAmos_MT-IDBAUD"

date

initPipeline -1 /mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metatranscriptomic/time_series/D32/LAO_Metatranscriptome-D32_TAGCTT_L003_R1_001.fastq.bz2 -2 /mnt/md1200/snarayanasamy/archived_raw_data/LAO/Metatranscriptomic/time_series/D32/LAO_Metatranscriptome-D32_TAGCTT_L003_R2_001.fastq.bz2 -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 8 -a idba_ud

date
