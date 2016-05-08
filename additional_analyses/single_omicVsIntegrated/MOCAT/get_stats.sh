#!/bin/bash -l

source ../preload_modules.sh

MGMT_ROOT="/scratch/users/snarayanasamy/IMP_MS_data/mappingSingleOmics/MOCAT/Combined"
MG_ROOT="/scratch/users/snarayanasamy/IMP_MS_data/mappingSingleOmics/MOCAT/MG"
MT_ROOT="/scratch/users/snarayanasamy/IMP_MS_data/mappingSingleOmics/MOCAT/MT"

declare -a SAMPLES=("SM" "HF1" "HF2" "HF3" "HF4" "HF5" "WW1" "WW2" "WW3" "WW4" "BG")

for S in "${SAMPLES[@]}" 
do
  check=${#S}
  echo $check
  if [ $check -eq 3 ]
  then 
    S1="${S::-1}"
    echo "$S1" 
  else 
    S1="$S"
    echo "Continue"
  fi
  MG2MGMT="${MGMT_ROOT}/${S1}/$S/${S}_MG-mapping.bam"
  MT2MGMT="${MGMT_ROOT}/${S1}/$S/${S}_MT-mapping.bam"
  MG2MG="${MG_ROOT}/${S1}/${S}/${S}_MG-mapping.bam"
  MT2MG="${MG_ROOT}/${S1}/${S}/${S}_MT-mapping.bam"
  MG2MT="${MT_ROOT}/${S1}/${S}/${S}_MG-mapping.bam"
  MT2MT="${MT_ROOT}/${S1}/${S}/${S}_MT-mapping.bam"

  ls $MG2MGMT
  samtools flagstat $MG2MGMT > ${MGMT_ROOT}/${S1}/$S/MG_reads-x-_MGMT-assm.flagstat.txt

  ls $MT2MGMT
  samtools flagstat $MG2MGMT > ${MGMT_ROOT}/${S1}/$S/MT_reads-x-_MGMT-assm.flagstat.txt

  ls $MG2MG
  samtools flagstat $MG2MGMT > ${MG_ROOT}/${S1}/$S/MG_reads-x-_MG-assm.flagstat.txt

  ls $MT2MG
  samtools flagstat $MG2MGMT > ${MG_ROOT}/${S1}/$S/MT_reads-x-_MG-assm.flagstat.txt

  ls $MG2MT
  samtools flagstat $MG2MGMT > ${MG_ROOT}/${S1}/$S/MG_reads-x-_MT-assm.flagstat.txt

  ls $MT2MT
  samtools flagstat $MG2MGMT > ${MG_ROOT}/${S1}/$S/MT_reads-x-_MT-assm.flagstat.txt

done
