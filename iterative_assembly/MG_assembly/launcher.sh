#!/bin/bash -l

#oarsub --notify "mail:shaman.narayanasamy@uni.lu" -n "iterative_assm_HMP" -t bigsmp -t idempotent -t besteffort -l nodes=1/core=24,walltime=120 ./execution_X310763260.sh 

#oarsub --notify "mail:shaman.narayanasamy@uni.lu" -n "iterative_assm_A02" -t bigsmp -t idempotent -t besteffort -l nodes=1/core=24,walltime=120 ./execution_A02.sh

oarsub --notify "mail:shaman.narayanasamy@uni.lu" -n "simDat-iterative_assm" -t bigsmp -t idempotent -t besteffort -l nodes=1/core=24,walltime=120 ./execution_simDat.sh
