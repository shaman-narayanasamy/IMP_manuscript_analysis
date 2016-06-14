#!/bin/bash
#oarsub -lcpu=1,walltime=72:00:00  -p "memcpu='258538'" -n mocatLux ./run.sh

samples=samples
log=$samples.log

source $HOME/.profile
source $HOME/.bashrc

export PERL5LIB=$PERL5LIB:/work/projects/ecosystem_biology/local_tools/MOCAT/src
PATH=$PATH:/work/projects/ecosystem_biology/local_tools/MOCAT/src
export PATH
#MOCAT.pl -sf $samples -rtf -cpus 8 >$log 2>>$log 

#MOCAT.pl -sf $samples -s hg19 -cpus 8 >>$log 2>>$log
#MOCAT.pl -sf $samples -a -r hg19 -cpus 8 >>$log 2>>$log
#MOCAT.pl -sf $samples -ar -cpus 8 -r hg19 >>$log 2>>$log
#MOCAT.pl -sf $samples -gp assembly.revised -cpus 8 -r hg19 >>$log 2>>$log
#MOCAT.pl -sf $samples -ss -cpus 8  >>$log 2>>$log

MOCAT.pl -sf $samples -a -cpus 8 >>$log 2>>$log
MOCAT.pl -sf $samples -ar -cpus 8  >>$log 2>>$log
MOCAT.pl -sf $samples -gp assembly.revised -cpus 8 >>$log 2>>$log
MOCAT.pl -sf $samples -ss -cpus 8  >>$log 2>>$log

