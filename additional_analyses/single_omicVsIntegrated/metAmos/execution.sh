#!/bin/bash -l

### This script takes in the necessary arguments for Snakemake and attaches them into the
### appropriate Snakemake command.

INDIR=$1
MG_REF=$2
MT_REF=$3
MGMT_REF=$4
OUTDIR=$5
OUTLOG=$6
SAMPLE=$7

date
source ../preload_modules.sh

INPUT_DIR=$INDIR \
  REFERENCE_MG=$MG_REF \
  REFERENCE_MT=$MT_REF \
  REFERENCE_MGMT=$MGMT_REF \
  OUT_DIR=$OUTDIR \
  OUT_LOG=$OUTLOG \
  SAMPLE=$SAMPLE \
  snakemake -F

date
