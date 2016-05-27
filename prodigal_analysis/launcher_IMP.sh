#!/bin/bash -l

OARSUB="oarsub --notify "mail:shaman.narayanasamy@uni.lu" -t bigsmp -t idempotent -t besteffort -l core=12/nodes=1,walltime=120"

declare -a SAMPLES=("SM" "HF1" "HF2" "HF3" "HF4" "HF5" "WW1" "WW2" "WW3" "WW4" "BG")

### Repeat for all the data sets
for S in "${SAMPLES[@]}" 
do
    MGMT_REF="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}/Assembly/MGMT.assembly.merged.fa"
    MG_REF="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/${S}/MG_contigs_merged_2.fa"
    MT_REF="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MT_assemblies/${S}/MT_contigs_merged_2.fa"

    OUTDIR_MGMT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/IMP_MGMT/${S}"
    ${OARSUB} -n "${S}_IMP_MGMT_prodigal" "./makeGenePredictionsProdigal.sh $MGMT_REF $OUTDIR_MGMT"

    OUTDIR_MG="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/IMP_MG/${S}"
    ${OARSUB} -n "${S}_IMP_MG_prodigal" "./makeGenePredictionsProdigal.sh $MG_REF $OUTDIR_MG"

    OUTDIR_MT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/IMP_MT/${S}"
    ${OARSUB} -n "${S}_IMP_MT_prodigal" "./makeGenePredictionsProdigal.sh $MT_REF $OUTDIR_MT"

done
