#!/bin/bash -l


declare -a SAMPLES=("HF1" "HF2" "HF3" "HF4" "HF5")

for S in "${SAMPLES[@]}" 
do 

IMP_MG_BAM="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}/Assembly/MG.reads.sorted.bam"
IMP_MG_MEGAHIT_BAM="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}_megahit/Assembly/MG.reads.sorted.bam"
IGC_MG_BAM="/scratch/users/snarayanasamy/IMP_MS_data/HMP_IGC_mapping/${S}/MG_IMP_x_HMP.sorted.bam"
IMP_MT_BAM="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}/Assembly/MT.reads.sorted.bam"
IMP_MT_MEGAHIT_BAM="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}_megahit/Assembly/MT.reads.sorted.bam"
IGC_MT_BAM="/scratch/users/snarayanasamy/IMP_MS_data/HMP_IGC_mapping/${S}/MT_IMP_x_HMP.sorted.bam"

echo "IGC and IMP MG total reads"
sort <(samtools view -f 2 $IMP_MG_BAM | cut -f1) <(samtools view -f 2 $IGC_MG_BAM | cut -f1) | uniq | wc -l

echo "IGC and IMP-megahit MG total reads"
sort <(samtools view -f 2 $IMP_MG_MEGAHIT_BAM | cut -f1) <(samtools view -f 2 $IGC_MG_MEGAHIT_BAM | cut -f1) | uniq | wc -l

echo "IGC and IMP MT total reads"
sort <(samtools view -f 2 $IMP_MT_BAM | cut -f1) <(samtools view -f 2 $IGC_MT_BAM | cut -f1) | uniq | wc -l

echo "IGC and IMP-megahit MT total reads"
sort <(samtools view -f 2 $IMP_MT_MEGAHIT_BAM | cut -f1) <(samtools view -f 2 $IGC_MT_MEGAHIT_BAM | cut -f1) | uniq | wc -l

done
