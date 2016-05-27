#!/bin/bash -l

OARSUB="oarsub --notify "mail:shaman.narayanasamy@uni.lu" -t bigsmp -t idempotent -t besteffort -l core=12/nodes=1,walltime=120"

declare -a SAMPLES=("SM" "HF1" "HF2" "HF3" "HF4" "HF5" "WW1" "WW2" "WW3" "WW4" "BG")

### Repeat for all the data sets
for S in "${SAMPLES[@]}" 
do
    MGMT_REF="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}_megahit/Assembly/MGMT.assembly.merged.fa"

    OUTDIR_MGMT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/IMP-megahit/${S}"
    ${OARSUB} -n "${S}_IMP_MGMT_prodigal" "./makeGenePredictionsProdigal.sh $MGMT_REF $OUTDIR_MGMT"

done
