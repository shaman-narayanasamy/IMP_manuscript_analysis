#!/bin/bash -l

### This script takes in the necessary arguments for Snakemake and attaches them into the
### appropriate Snakemake command.

INDIR=$1
MG_REF=$2
MT_REF=$3
OUTDIR=$4
OUTLOG=$5
SAMPLE=$6
#
date
source ../preload_modules.sh


INPUT_DIR=$INDIR \
  REFERENCE_MG=$MG_REF \
  REFERENCE_MT=$MT_REF \
  OUT_DIR=$OUTDIR \
  SAMPLE=$SAMPLE \
  snakemake -np

date
