#!/bin/bash -l

module load bio/SAMtools/0.1.19-goolf-1.4.10

THREADS=12

declare -a SAMPLES=("HF1" "HF2" "HF3" "HF4" "HF5")

date
for S in "${SAMPLES[@]}" 
do 
IMP_MG_BAM="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}/Assembly/MG.reads.sorted.bam"
IMP_MG_MEGAHIT_BAM="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}_megahit/Assembly/MG.reads.sorted.bam"
IGC_MG_BAM="/scratch/users/snarayanasamy/IMP_MS_data/HMP_IGC_mapping/${S}/MG_IMP_x_HMP.sorted.bam"
IMP_MT_BAM="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}/Assembly/MT.reads.sorted.bam"
IMP_MT_MEGAHIT_BAM="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}_megahit/Assembly/MT.reads.sorted.bam"
IGC_MT_BAM="/scratch/users/snarayanasamy/IMP_MS_data/HMP_IGC_mapping/${S}/MT_IMP_x_HMP.sorted.bam"

paste <(echo -e "${S}_MG_IMP_IGC\t") <(sort <(samtools view -f 2 -@ ${THREADS} ${IMP_MG_BAM} | cut -f1) <(samtools view -f 2 -@ ${THREADS} ${IGC_MG_BAM} | cut -f1) | uniq | wc -l) >> IMP2IGC_mapping.txt

paste <(echo -e "${S}_MG_IMP-megahit_IGC\t") <(sort <(samtools view -f 2 -@ ${THREADS} ${IMP_MG_MEGAHIT_BAM} | cut -f1) <(samtools view -f 2 -@ ${THREADS} ${IGC_MG_BAM} | cut -f1) | uniq | wc -l) >> IMP2IGC_mapping.txt

<(echo -e "${S}_MT_IMP_IGC\t") <(sort <(samtools view -f 2 -@ ${THREADS} ${IMP_MT_BAM} | cut -f1) <(samtools view -f 2 -@ ${THREADS} ${IGC_MT_BAM} | cut -f1) | uniq | wc -l) >> IMP2IGC_mapping.txt

paste <(echo -e "${S}_MT_IMP-megahit_IGC\t") <(sort <(samtools view -f 2 -@ ${THREADS} ${IMP_MT_MEGAHIT_BAM} | cut -f1) <(samtools view -f 2 -@ ${THREADS} ${IGC_MT_BAM} | cut -f1) | uniq | wc -l) >> IMP2IGC_mapping.txt
done
date
