#!/bin/bash -l

### This script takes in the necessary arguments for Snakemake and attaches them into the
### appropriate Snakemake command.

IMP=$1
IMP_MEGAHIT=$2
METAMOS=$3
MOCAT=$4
IMP_MG=$5
METAMOS_MG=$6
MOCAT_MG=$7
IMP_MT=$8
METAMOS_MT=$9
MOCAT_MT=${10}

OUTDIR=${11}

date
#source ../preload_modules.sh
/mnt/gaiagpfs/projects/ecosystem_biology/local_tools/quast/metaquast.py \
    -o $OUTDIR -t 12 -f \
    -l "IMP, IMP-megahit, MetAmos_MGMT, MOCAT_MGMT, IMP_MG, MetAmos_MG, MOCAT_MG, IMP_MT, MetAmos_MT, MOCAT_MT" \
    -R /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/73_species/ \
    ${IMP} \
    ${IMP_MEGAHIT} \
    ${METAMOS} \
    ${MOCAT} \
    ${IMP_MG} \
    ${METAMOS_MG} \
    ${MOCAT_MG} \
    ${IMP_MT} \
    ${METAMOS_MT} \
    ${MOCAT_MT} \
    --no-plots

date

