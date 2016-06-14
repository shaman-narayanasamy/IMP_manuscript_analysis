#!/bin/bash -l

export PATH=$PATH:/home/snarayanasamy/Work/tools/metAMOS-1.5rc3/

date

initPipeline -1 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X311245214/MG/X311245214_MG_R1.fq,/mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X311245214/MT/X311245214_MT_R1.fq -2 /mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X311245214/MG/X311245214_MG_R2.fq,/mnt/md1200/snarayanasamy/IMP_data/Huttenhower/X311245214/MT/X311245214_MT_R2.fq -d /home/snarayanasamy/Work/metAmosAnalysis/X311245214_metAmos_MGMT -i 250:500,250:500

runPipeline -d /home/snarayanasamy/Work/metAmosAnalysis/X311245214_metAmos_MGMT -p 8

date
