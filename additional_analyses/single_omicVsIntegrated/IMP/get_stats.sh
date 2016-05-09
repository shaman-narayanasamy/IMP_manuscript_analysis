#!/bin/bash -l

source ../preload_modules.sh

INDIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis"
OUTDIR="/scratch/users/snarayanasamy/IMP_MS_data/mappingSingleOmics/IMP"

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
  MG2MGMT="${INDIR}/$S/Assembly/MG.reads.sorted.bam"
  MT2MGMT="${INDIR}/$S/Assembly/MT.reads.sorted.bam"
  MG2MGMT_megahit="${INDIR}/${S}_megahit/Assembly/MG.reads.sorted.bam"
  MT2MGMT_megahit="${INDIR}/${S}_megahit/Assembly/MT.reads.sorted.bam"


  mkdir ${OUTDIR}/$S/default
  samtools flagstat $MG2MGMT > ${OUTDIR}/$S/default/MG_reads-x-_MGMT-assm.flagstat.txt
  samtools flagstat $MT2MGMT > ${OUTDIR}/$S/default/MT_reads-x-_MGMT-assm.flagstat.txt

  mkdir ${OUTDIR}/$S/megahit
  ls $MG2MGMT_megahit
  ls $MT2MGMT_megahit
  samtools flagstat $MG2MGMT_megahit > ${OUTDIR}/$S/megahit/MG_reads-x-_MGMT-assm.flagstat.txt
  samtools flagstat $MT2MGMT_megahit > ${OUTDIR}/$S/megahit/MT_reads-x-_MGMT-assm.flagstat.txt

done
