#!/bin/bash -l

date
source ../preload_modules.sh

### Initialize first assembly ###
echo "Executing inital assembly"
INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02_20151130-idba/Preprocessing" \
  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02-iterative_MT/" \
  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02-iterative_MT/A02_iterative_MT.log" \
  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02-iterative_MT/tmp" \
  snakemake ALL

INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02_20151130-idba/Preprocessing" \
  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02-iterative_MT/" \
  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02-iterative_MT/A02_iterative_MT.log" \
  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02-iterative_MT/tmp" \
  snakemake GENE_CALLING_INITIAL_ASSEMBLY


for ITER in {2..5}
do
  echo "Iteration $ITER"
      INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02_20151130-idba/Preprocessing" \
        OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02-iterative_MT" \
        OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02-iterative_MT/A02_iterative_MT.log" \
        TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02-iterative_MT/tmp" \
        STEP=${ITER} snakemake ALL
done

date
