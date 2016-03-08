#!/bin/bash -l

source preload_modules.sh

date
MGR1=$1
MGR2=$2
MTR1=$3
MTR2=$4
SAMPLE=$5
OUT_DIR=$6
OUT_LOG=$6/${5}_IGC.log

MGR1=$MGR1 \
  MGR2=$MGR2 \
  MTR1=$MTR1 \
  MTR2=$MTR2 \
  SAMPLE=$SAMPLE \
  OUT_DIR=$OUT_DIR \
  OUT_LOG=$OUT_LOG \
  snakemake ALL -np

date
