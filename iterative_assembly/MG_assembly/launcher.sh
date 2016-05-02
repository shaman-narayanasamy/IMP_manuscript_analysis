#!/bin/bash -l

OARSUB="oarsub --notify "mail:shaman.narayanasamy@uni.lu" -t bigmem -t idempotent -t besteffort -l core=8/nodes=1,walltime=120"

#OARSUB=""
#
#oarsub --notify "mail:shaman.narayanasamy@uni.lu" -n "iterative_assm_HMP" -t bigsmp -t idempotent -t besteffort -l nodes=1/core=24,walltime=120 ./execution_X310763260.sh 
#
#oarsub --notify "mail:shaman.narayanasamy@uni.lu" -n "iterative_assm_A02" -t bigsmp -t idempotent -t besteffort -l nodes=1/core=24,walltime=120 ./execution_A02.sh
#
#oarsub --notify "mail:shaman.narayanasamy@uni.lu" -n "simDat-iterative_assm" -t bigsmp -t idempotent -t besteffort -l nodes=1/core=24,walltime=120 ./execution_simDat.sh
#


declare -a SAMPLES=("SM" "HF1" "HF2" "HF3" "HF4" "HF5" "WW1" "WW2" "WW3" "WW4" "BG")

### Repeat for all the data sets
for S in "${SAMPLES[@]}" 
do
    INDIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}/Preprocessing/"
    OUTDIR="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/${S}"
    OUTLOG="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/${S}/${S}_MG-iterative.log"
    TMPDIR="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/${S}/tmp"
    
    ${OARSUB} -n "${S}_MG_iterative" "./execution.sh $INDIR $OUTDIR $OUTLOG $TMPDIR"
    #CMD="./execution.sh $INDIR $OUTDIR $OUTLOG $TMPDIR"
    
#    echo $CMD
#    exec ${CMD}

done

