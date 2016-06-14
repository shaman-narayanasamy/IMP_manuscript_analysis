#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/
OUTDIR="/mnt/md1200/snarayanasamy/metAmosAnalysis/PRJEB8813_metAmos_MT"

date

initPipeline -1 /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/MT/ERR843255_1.fastq.gz -2 /mnt/md1200/snarayanasamy/archived_raw_data/PRJEB8813/MT/ERR843255_2.fastq.gz -d $OUTDIR -i 250:500,250:500

runPipeline -d $OUTDIR -p 8

date
