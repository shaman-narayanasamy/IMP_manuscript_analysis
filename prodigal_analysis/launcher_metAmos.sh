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
    MG_REF="/scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/${S1}/MG/default/${S}/Assemble/out/soapdenovo.31.asm.contig"
    MT_REF="/scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/${S1}/MT/default/${S}/Assemble/out/soapdenovo.31.asm.contig"
    MGMT_REF="/scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/${S1}/MGMT/default/${S}/Assemble/out/soapdenovo.31.asm.contig"

    OUTDIR_MGMT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/metAmos_MGMT/${S}"
    ${OARSUB} -n "${S}_metAmos_MGMT_prodigal" "./makeGenePredictionsProdigal.sh $ $MGMT_REF $OUTDIR_MGMT"

    OUTDIR_MG="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/metAmos_MG/${S}"
    ${OARSUB} -n "${S}_metAmos_MG_prodigal" "./makeGenePredictionsProdigal.sh $ $MG_REF $OUTDIR_MG"

    OUTDIR_MT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/metAmos_MT/${S}"
    ${OARSUB} -n "${S}_metAmos_MT_prodigal" "./makeGenePredictionsProdigal.sh $ $MT_REF $OUTDIR_MT"

done
