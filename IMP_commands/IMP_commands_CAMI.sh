#!/bin/bash -l

## CAMI is a benchmark simulated data set. This runs IMP when only MG data is povided

COMMAND=$1

## Low complexity
LOG=CAMI_low-idba.log
CMD="
 time python3.4 /home/snarayanasamy/Work/tools/IMP_new/IMP/IMP \
    -m /mnt/md1200/snarayanasamy/IMP_data/CAMI/Low_Complexity_Test_Dataset/LCTD.1.fq \
    -m /mnt/md1200/snarayanasamy/IMP_data/CAMI/Low_Complexity_Test_Dataset/LCTD.2.fq \
    -o /mnt/md1200/snarayanasamy/IMP_analysis/CAMI_low-idba \
    -c conf/bigbug.conf.imp.json --current -a idba \
    -d /home/snarayanasamy/Work/tools/IMP_new/IMP/db \
    $COMMAND" 
echo $CMD > $LOG
$CMD >> 2&>> $LOG 

LOG=CAMI_low-megahit.log 
CMD="
 time python3.4 /home/snarayanasamy/Work/tools/IMP_new/IMP/IMP \
    -m /mnt/md1200/snarayanasamy/IMP_data/CAMI/Low_Complexity_Test_Dataset/LCTD.1.fq \
    -m /mnt/md1200/snarayanasamy/IMP_data/CAMI/Low_Complexity_Test_Dataset/LCTD.2.fq \
    -o /mnt/md1200/snarayanasamy/IMP_analysis/CAMI_low-megahit \
    -c conf/bigbug.conf.imp.json --current -a megahit \
    -d /home/snarayanasamy/Work/tools/IMP_new/IMP/db \
    $COMMAND" 
echo $CMD > $LOG
$CMD >> 2&>> $LOG 

#
### Medium complexity
LOG=CAMI_medium-idba.log 
CMD="
 time python3.4 /home/snarayanasamy/Work/tools/IMP_new/IMP/IMP \
    -m /mnt/md1200/snarayanasamy/IMP_data/CAMI/Medium_Complexity_Test_Dataset/MCTD.1.fq \
    -m /mnt/md1200/snarayanasamy/IMP_data/CAMI/Medium_Complexity_Test_Dataset/MCTD.2.fq \
    -o /mnt/md1200/snarayanasamy/IMP_analysis/CAMI_medium-idba \
    -c conf/bigbug.conf.imp.json --current -a idba \
    -d /home/snarayanasamy/Work/tools/IMP_new/IMP/db \
    $COMMAND" 
echo $CMD > $LOG
$CMD >> 2&>> $LOG 

LOG=CAMI_medium-megahit.log 
CMD="
 time python3.4 /home/snarayanasamy/Work/tools/IMP_new/IMP/IMP \
    -m /mnt/md1200/snarayanasamy/IMP_data/CAMI/Medium_Complexity_Test_Dataset/MCTD.1.fq \
    -m /mnt/md1200/snarayanasamy/IMP_data/CAMI/Medium_Complexity_Test_Dataset/MCTD.2.fq \
    -o /mnt/md1200/snarayanasamy/IMP_analysis/CAMI_medium-megahit \
    -c conf/bigbug.conf.imp.json --current -a megahit \
    -d /home/snarayanasamy/Work/tools/IMP_new/IMP/db \
    $COMMAND" 
echo $CMD > $LOG
$CMD >> 2&>> $LOG 

### High complexity
LOG=CAMI_high-idba.log
CMD="
 time python3.4 /home/snarayanasamy/Work/tools/IMP_new/IMP/IMP \
    -m /mnt/md1200/snarayanasamy/IMP_data/CAMI/High_Complexity_Dataset/HCTD.1.fq \
    -m /mnt/md1200/snarayanasamy/IMP_data/CAMI/High_Complexity_Dataset/HCTD.2.fq \
    -o /mnt/md1200/snarayanasamy/IMP_analysis/CAMI_high-idba \
    -c conf/bigbug.conf.imp.json --current -a idba \
    -d /home/snarayanasamy/Work/tools/IMP_new/IMP/db \
    $COMMAND" 
echo $CMD > $LOG
$CMD >> 2&>> $LOG 

LOG=CAMI_high-megahit.log
CMD="
 time python3.4 /home/snarayanasamy/Work/tools/IMP_new/IMP/IMP \
    -m /mnt/md1200/snarayanasamy/IMP_data/CAMI/High_Complexity_Dataset/HCTD.1.fq \
    -m /mnt/md1200/snarayanasamy/IMP_data/CAMI/High_Complexity_Dataset/HCTD.2.fq \
    -o /mnt/md1200/snarayanasamy/IMP_analysis/CAMI_high-megahit \
    -c conf/bigbug.conf.imp.json --current -a megahit \
    -d /home/snarayanasamy/Work/tools/IMP_new/IMP/db \
    $COMMAND" 
echo $CMD > $LOG
$CMD >> 2&>> $LOG 
