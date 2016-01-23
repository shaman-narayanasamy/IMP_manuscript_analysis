#!/bin/bash -l
source /home/users/snarayanasamy/repositories/IMP_manuscript_analysis/iterative_assembly/preload_modules.sh

### This script maps reads to the single omic assemblies, i.e. MT reads to MG-only assembly and MG reads to MT-only assembly, using bwa.

# Define input

R1=$1
R2=$2
SE=$3
REF=$4
OUTDIR=$5
READS=$6
ASSEMBLY=$7
SAMPLE=$8
TMP_FILE=${OUTDIR}/TMP
THREADS=12
MEMCORE=48
SAMHEADER="@RG\\tID:${SAMPLE}\\tSM:${READS}"
PREFIX=${OUTDIR}/${READS}_reads-x-${SAMPLE}_${ASSEMBLY}-assm


echo $PREFIX

# index
bwa index $REF
#
# merge paired and se
samtools merge -@ ${THREADS} -f $PREFIX.merged.bam \
<(bwa mem -v 1 -t ${THREADS} -M -R "$SAMHEADER" $REF $R1 $R2 | \
samtools view -@ ${THREADS} -bS -) \
<(bwa mem -v 1 -t ${THREADS} -M -R "$SAMHEADER" $REF $SE | \
samtools view -@ ${THREADS} -bS -)

# sort
samtools sort -@ ${THREADS} -m ${MEMCORE}G $PREFIX.merged.bam $PREFIX.sorted
rm $PREFIX.merged.bam

# index
samtools index $PREFIX.sorted.bam

# Get the stats

samtools flagstat $PREFIX.sorted.bam > $PREFIX.flagstat.txt
