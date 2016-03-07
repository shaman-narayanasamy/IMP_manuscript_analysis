#!/bin/bash -l

source preload_modules.sh

date

CMD="MGR1=$1 \
  MGR2=$2 \
  MTR1=$3 \
  MTR2=$4 \
  SAMPLE=$5 \
  OUT_DIR=$6 \
  snakemake ALL -np"
echo $CMD

date
