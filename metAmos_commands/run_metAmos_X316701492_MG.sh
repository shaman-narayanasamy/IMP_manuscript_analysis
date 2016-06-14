#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/MG/X316701492_MG_R1.fq -2 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X316701492/MG/X316701492_MG_R2.fq -d /home/snarayanasamy/Work/metAmosAnalysis/X316701492_metAmos_MG -i 250:500,250:500

runPipeline -d /home/snarayanasamy/Work/metAmosAnalysis/X316701492_metAmos_MG -p 8

date
