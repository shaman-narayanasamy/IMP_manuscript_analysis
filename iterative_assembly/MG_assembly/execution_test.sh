#!/bin/bash -l

source ../preload_modules.sh
INDIR="/scratch/users/snarayanasamy/test_output/Preprocessing"
OUTDIR="/scratch/users/snarayanasamy/test_iterative_MG/"
OUTLOG="/scratch/users/snarayanasamy/test_iterative_MG/test_iterative_MG.log"
TMPDIR="/scratch/users/snarayanasamy/test_iterative_MG/tmp"

### Initialize first assembly ###
INPUT_DIR=$INDIR \
  OUT_DIR=$OUTDIR \
  OUT_LOG=$OUTLOG \
  TMP=$TMPDIR \
  snakemake ALL

  INPUT_DIR=$INDIR \
  OUT_DIR=$OUTDIR \
  OUT_LOG=$OUTLOG \
  TMP=$TMPDIR \
  snakemake EXTRACT_UNMAPPED

for ITER in {2..5}
do
  echo "Iteration $ITER"
  INPUT_DIR=$INDIR \
  OUT_DIR=$OUTDIR \
  OUT_LOG=$OUTLOG \
  TMP=$TMPDIR \
    STEP=${ITER} snakemake ALL
done
  
### Initialize second assembly ###
#INPUT_DIR="/scratch/users/snarayanasamy/test_output/Preprocessing" \
#  OUT_DIR="/scratch/users/snarayanasamy/test_iterative_MG/" \
#  OUT_LOG="/scratch/users/snarayanasamy/test_iterative_MG/test_iterative_MG.log" \
#  TMPDIR="/scratch/users/snarayanasamy/test_iterative_MG/tmp" \
#  STEP=2 snakemake -np ALL
# 
#### Initialize third assembly ###
#INPUT_DIR="/scratch/users/snarayanasamy/test_output/Preprocessing" \
#  OUT_DIR="/scratch/users/snarayanasamy/test_iterative_MG/" \
#  OUT_LOG="/scratch/users/snarayanasamy/test_iterative_MG/test_iterative_MG.log" \
#  TMPDIR="/scratch/users/snarayanasamy/test_iterative_MG/tmp" \
#  STEP=3 snakemake -np ALL
#
#### Initialize fourth assembly ###
#INPUT_DIR="/scratch/users/snarayanasamy/test_output/Preprocessing" \
#  OUT_DIR="/scratch/users/snarayanasamy/test_iterative_MG/" \
#  OUT_LOG="/scratch/users/snarayanasamy/test_iterative_MG/test_iterative_MG.log" \
#  TMPDIR="/scratch/users/snarayanasamy/test_iterative_MG/tmp" \
#  STEP=4 snakemake -np ALL
#
#### Initialize fifth assembly ###
#INPUT_DIR="/scratch/users/snarayanasamy/test_output/Preprocessing" \
#  OUT_DIR="/scratch/users/snarayanasamy/test_iterative_MG/" \
#  OUT_LOG="/scratch/users/snarayanasamy/test_iterative_MG/test_iterative_MG.log" \
#  TMPDIR="/scratch/users/snarayanasamy/test_iterative_MG/tmp" \
#  STEP=5 snakemake -np ALL
# 
