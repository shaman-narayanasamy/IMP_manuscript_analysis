#!/bin/bash -l

OARSUB="oarsub --notify "mail:shaman.narayanasamy@uni.lu" -t bigmem -t idempotent -t besteffort -l core=8/nodes=1,walltime=120"
#OARSUB="oarsub --notify "mail:shaman.narayanasamy@uni.lu" -l nodes=1,walltime=120"

#OARSUB=""
#
#oarsub --notify "mail:shaman.narayanasamy@uni.lu" -n "iterative_assm_HMP" -t bigsmp -t idempotent -t besteffort -l nodes=1/core=24,walltime=120 ./execution_X310763260.sh 
#
#oarsub --notify "mail:shaman.narayanasamy@uni.lu" -n "iterative_assm_A02" -t bigsmp -t idempotent -t besteffort -l nodes=1/core=24,walltime=120 ./execution_A02.sh
#
#oarsub --notify "mail:shaman.narayanasamy@uni.lu" -n "simDat-iterative_assm" -t bigsmp -t idempotent -t besteffort -l nodes=1/core=24,walltime=120 ./execution_simDat.sh
#


#declare -a SAMPLES=("SM" "HF1" "HF2" "HF3" "HF4" "HF5" "WW1" "WW2" "WW3" "WW4" "BG")
declare -a SAMPLES=("BG")

### Repeat for all the data sets
for S in "${SAMPLES[@]}" 
do
    INDIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}"
    MG_REF="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/${S}/MG_contigs_merged_2.fa"
    MT_REF="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MT_assemblies/${S}/MT_contigs_merged_2.fa"
    OUTDIR="/scratch/users/snarayanasamy/IMP_MS_data/mappingSingleOmics/IMP/${S}"
    OUTLOG="${OUTDIR}/${S}.log"
    
    ${OARSUB} -n "${S}_mapping" "./execution.sh $INDIR $MG_REF $MT_REF $OUTDIR $OUTLOG $SAMPLE"
    #CMD="./execution.sh $INDIR $MG_REF $MT_REF $OUTDIR $OUTLOG $SAMPLE"
    
    #echo $CMD
    #$CMD

done
