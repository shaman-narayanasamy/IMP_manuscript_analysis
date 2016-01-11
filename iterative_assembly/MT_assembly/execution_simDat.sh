#!/bin/bash -l

date
source ../preload_modules.sh

### Initialize first assembly ###
INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Preprocessing" \
  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT" \
  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/simDat_iterative_MT.log" \
  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/tmp" \
  snakemake ALL 

 INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Preprocessing" \
  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT" \
  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/simDat_iterative_MT.log" \
  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/tmp" \
  snakemake GENE_CALLING_INITIAL_ASSEMBLY

 
### Initialize second assembly ###
for ITER in {2..5}
do
  echo "Iteration $ITER"
INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Preprocessing" \
  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT" \
  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/simDat_iterative_MT.log" \
  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/tmp" \
  STEP=${ITER} snakemake ALL 
done

date
