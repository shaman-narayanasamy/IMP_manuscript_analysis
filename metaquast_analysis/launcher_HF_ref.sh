#!/bin/bash -l

OARSUB="oarsub --notify "mail:shaman.narayanasamy@uni.lu" -l nodes=1,walltime=24 -t besteffort -t idempotent"

declare -a SAMPLES=("HF1" "HF2" "HF3" "HF4" "HF5")

## Repeat for all the data sets
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
    ## MGMT assemblies
    IMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}/Assembly/MGMT.assembly.merged.fa"
    IMP_MEGAHIT="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}_megahit/Assembly/MGMT.assembly.merged.fa"
    METAMOS="/scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/${S1}/MGMT/default/${S}/Assemble/out/soapdenovo.31.asm.contig"
    MOCAT="/scratch/users/snarayanasamy/IMP_MS_data/MOCAT_analysis/Combined/${S1}/${S}_MOCAT_MGMT"

    ## MG assemblies
    IMP_MG="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/${S}/MG_contigs_merged_2.fa"
    METAMOS_MG="/scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/${S1}/MG/default/${S}/Assemble/out/soapdenovo.31.asm.contig"
    MOCAT_MG="/scratch/users/snarayanasamy/IMP_MS_data/MOCAT_analysis/MG/${S1}/${S}_MOCAT_MG"

    ## MT assemblies
    IMP_MT="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MT_assemblies/${S}/MT_contigs_merged_2.fa"
    METAMOS_MT="/scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/${S1}/MT/default/${S}/Assemble/out/soapdenovo.31.asm.contig"
    MOCAT_MT="/scratch/users/snarayanasamy/IMP_MS_data/MOCAT_analysis/MT/${S1}/${S}_MOCAT_MT"

    OUTDIR="/scratch/users/snarayanasamy/IMP_MS_data/metaquast_analysis/HF_ref/${S}"
    
    ${OARSUB} -n "${S}_ref_metaquast" "./execution_HF_ref.sh $IMP $IMP_MEGAHIT $METAMOS $MOCAT $IMP_MG $METAMOS_MG $MOCAT_MG $IMP_MT $METAMOS_MT $MOCAT_MT $OUTDIR"
done
