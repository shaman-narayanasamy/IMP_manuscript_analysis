#!/bin/bash -l

#OARSUB="oarsub --notify "mail:shaman.narayanasamy@uni.lu" -t bigmem -t idempotent -t besteffort -l core=8/nodes=1,walltime=120"
OARSUB="oarsub --notify "mail:shaman.narayanasamy@uni.lu" -l nodes=1,walltime=120"


IMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM/Assembly/MGMT.assembly.merged.fa"
IMP_MEGAHIT="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM_megahit/Assembly/MGMT.assembly.merged.fa"
METAMOS="/scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/SM/MGMT/default/SM/Assemble/out/soapdenovo.31.asm.contig"
MOCAT=""
OUTDIR="/scratch/users/snarayanasamy/IMP_MS_data/metaquast_analysis/SM"

${OARSUB} -n "SM_mapping" "./execution_SM.sh $IMP $IMP_MEGAHIT $METAMOS $MOCAT $OUTDIR"


declare -a SAMPLES=("HF1" "HF2" "HF3" "HF4" "HF5" "WW1" "WW2" "WW3" "WW4" "BG")


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
    IMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}/Assembly/MGMT.assembly.merged.fa"
    IMP_MEGAHIT="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}_megahit/Assembly/MGMT.assembly.merged.fa"
    METAMOS="/scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/${S1}/MGMT/default/${S}/Assemble/out/soapdenovo.31.asm.contig"
    MOCAT="/scratch/users/snarayanasamy/IMP_MS_data/MOCAT_analysis/Combined2/${S1}/${S}/"
    IMP_MG="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/${S}/MG_contigs_merged_2.fa"
    METAMOS_MG="/scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/${S1}/MG/default/${S}/Assemble/out/soapdenovo.31.asm.contig"
    MOCAT_MG=""
    IMP_MT="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MT_assemblies/${S}/MT_contigs_merged_2.fa"
    METAMOS_MT="/scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/${S1}/MT/default/${S}/Assemble/out/soapdenovo.31.asm.contig"
    MOCAT_MT=""

    OUTDIR="/scratch/users/snarayanasamy/IMP_MS_data/metaquast_analysis/${S}"
    
    ${OARSUB} -n "${S}_mapping" "./execution.sh $IMP $IMP_MEGAHIT $METAMOS $MOCAT $OUTDIR"
    #CMD="./execution.sh $INDIR $MG_REF $MT_REF $MGMT_REF $OUTDIR $OUTLOG $SAMPLE"
    
    #echo $CMD
    #$CMD

done
