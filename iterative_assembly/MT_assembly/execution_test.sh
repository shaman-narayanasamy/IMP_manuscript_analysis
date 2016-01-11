#!/bin/bash -l

source ../preload_modules.sh

### Initialize first assembly ###
INPUT_DIR="/scratch/users/snarayanasamy/test_output/Preprocessing" \
  OUT_DIR="/scratch/users/snarayanasamy/test_iterative_MT/" \
  OUT_LOG="/scratch/users/snarayanasamy/test_iterative_MT/test_iterative_MT.log" \
  TMP="/scratch/users/snarayanasamy/test_iterative_MT/tmp" \
  snakemake ALL

for ITER in {2..5}
do
  echo "Iteration $ITER"
  INPUT_DIR="/scratch/users/snarayanasamy/test_output/Preprocessing" \
    OUT_DIR="/scratch/users/snarayanasamy/test_iterative_MT" \
    OUT_LOG="/scratch/users/snarayanasamy/test_iterative_MT/test_iterative_MT.log" \
    TMP="/scratch/users/snarayanasamy/test_iterative_MT/tmp" \
    STEP=${ITER} snakemake ALL
done
  
date 
