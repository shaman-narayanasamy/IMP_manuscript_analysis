#!/bin/bash -l

### This script takes in the necessary arguments for Snakemake and attaches them into the
### appropriate Snakemake command.

IMP=$1
IMP_MEGAHIT=$2
METAMOS=$3
MOCAT=$4
OUTDIR=$5

date
source ../preload_modules.sh
/mnt/gaiagpfs/projects/ecosystem_biology/local_tools/quast/metaquast.py \
    -o $OUTDIR -t 12 \
    -l IMP,IMP-megahit,MetAmos,MOCAT \
    -f $IMP \
    $IMP_MEGAHIT \
    $METAMOS \
    $MOCAT \
    --max-ref-number 0

date
