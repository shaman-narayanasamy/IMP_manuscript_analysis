#!/bin/bash -l

#oarsub --notify "mail:shaman.narayanasamy@uni.lu" -n "HMP_MT_iterative_assm" -t bigsmp -t idempotent -t besteffort -l core=24/nodes=1,walltime=120 ./execution_X310763260.sh 

oarsub --notify "mail:shaman.narayanasamy@uni.lu" -n "A02_MT_iterative_assm" -t bigsmp -t idempotent -t besteffort -l core=24/nodes=1,walltime=120 ./execution_A02.sh

#oarsub --notify "mail:shaman.narayanasamy@uni.lu" -n "simDat_MT_iterative_assm" -t bigsmp -t idempotent -t besteffort -l core=24/nodes=1,walltime=120 ./execution_simDat.sh

#myoarsub -t bigsmp -t idempotent -t besteffort -l nodes=1/core=24,walltime=120 ./execution_simDat.sh
