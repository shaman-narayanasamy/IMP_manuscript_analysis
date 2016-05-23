#!/bin/bash -l

OARSUB="oarsub --notify "mail:shaman.narayanasamy@uni.lu" -t bigsmp -t idempotent -t besteffort -l core=12/nodes=1,walltime=120"

declare -a SAMPLES=("SM" "HF1" "HF2" "HF3" "HF4" "HF5" "WW1" "WW2" "WW3" "WW4" "BG")

### Repeat for all the data sets
for S in "${SAMPLES[@]}" 
do
  check=${#S}
  echo $check
  if [ $check -eq 3 ]
  then 
    S1="${S::-1}"
    echo "$S1" 
  else 
    S1="$S"
    echo "Continue"
  fi
    REF_MGMT="/scratch/users/snarayanasamy/IMP_MS_data/MOCAT_analysis/Combined/${S1}/${S}_MOCAT_MGMT"
    REF_MG="/scratch/users/snarayanasamy/IMP_MS_data/MOCAT_analysis/MG/${S1}/${S}_MOCAT_MG"
    REF_MT="/scratch/users/snarayanasamy/IMP_MS_data/MOCAT_analysis/MT/${S1}/${S}_MOCAT_MT"

    OUTDIR_MGMT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/MOCAT_MGMT/${S}"
    ${OARSUB} -n "${S}_MOCAT_MGMT_prodigal" "./makeGenePredictionsProdigal.sh $ $MGMT_REF $OUTDIR_MGMT"

    OUTDIR_MG="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/MOCAT_MG/${S}"
    ${OARSUB} -n "${S}_MOCAT_MG_prodigal" "./makeGenePredictionsProdigal.sh $ $MG_REF $OUTDIR_MG"

    OUTDIR_MT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/MOCAT_MT/${S}"
    ${OARSUB} -n "${S}_MOCAT_MT_prodigal" "./makeGenePredictionsProdigal.sh $ $MT_REF $OUTDIR_MT"

done
