#!/bin/bash -l

IMP_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis"
OUTDIR="/scratch/users/snarayanasamy/IMP_MS_data/preprocessing"
declare -a SAMPLES=("SM" "HF1" "HF2" "HF3" "HF4" "HF5" "WW1" "WW2" "WW3" "WW4" "BG")

for S in "${SAMPLES[@]}"
do
DIR="${IMP_DIR}/${S}/Preprocessing"
  parallel \
    "echo {} && cat {} | wc -l | awk '{d=\$1; print d/4;}'" ::: \
    ${IMP_DIR}/${S}/Preprocessing/*.fq > \
    ${OUTDIR}/${S}_read_count.txt
done
