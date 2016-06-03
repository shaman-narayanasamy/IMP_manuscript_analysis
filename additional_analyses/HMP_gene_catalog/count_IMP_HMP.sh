#!/bin/bash -l

module load bio/SAMtools/0.1.19-goolf-1.4.10

THREADS=12

declare -a SAMPLES=("HF1" "HF2" "HF3" "HF4" "HF5")

paste <(echo "Mappings") <(echo "proper_pairs") > IMP2IGC_mapping.txt

date
for S in "${SAMPLES[@]}" 
do 
IMP_MG_BAM="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}/Assembly/MG.reads.sorted.bam"
IMP_MG_MEGAHIT_BAM="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}_megahit/Assembly/MG.reads.sorted.bam"
IGC_MG_BAM="/scratch/users/snarayanasamy/IMP_MS_data/HMP_IGC_mapping/${S}/MG_IMP_x_HMP.sorted.bam"
IMP_MT_BAM="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}/Assembly/MT.reads.sorted.bam"
IMP_MT_MEGAHIT_BAM="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/${S}_megahit/Assembly/MT.reads.sorted.bam"
IGC_MT_BAM="/scratch/users/snarayanasamy/IMP_MS_data/HMP_IGC_mapping/${S}/MT_IMP_x_HMP.sorted.bam"

paste <(echo -e "${S}_MG_IMP_IGC") <(sort <(samtools view -f 2 -@ ${THREADS} ${IMP_MG_BAM} | cut -f1) <(samtools view -f 2 -@ ${THREADS} ${IGC_MG_BAM} | cut -f1) | uniq | wc -l) >> IMP2IGC_mapping.txt

paste <(echo -e "${S}_MG_IMP-megahit_IGC") <(sort <(samtools view -f 2 -@ ${THREADS} ${IMP_MG_MEGAHIT_BAM} | cut -f1) <(samtools view -f 2 -@ ${THREADS} ${IGC_MG_BAM} | cut -f1) | uniq | wc -l) >> IMP2IGC_mapping.txt

paste <(echo -e "${S}_MT_IMP_IGC") <(sort <(samtools view -f 2 -@ ${THREADS} ${IMP_MT_BAM} | cut -f1) <(samtools view -f 2 -@ ${THREADS} ${IGC_MT_BAM} | cut -f1) | uniq | wc -l) >> IMP2IGC_mapping.txt

paste <(echo -e "${S}_MT_IMP-megahit_IGC") <(sort <(samtools view -f 2 -@ ${THREADS} ${IMP_MT_MEGAHIT_BAM} | cut -f1) <(samtools view -f 2 -@ ${THREADS} ${IGC_MT_BAM} | cut -f1) | uniq | wc -l) >> IMP2IGC_mapping.txt
done
date


### For some reason, HF4 produced weird results
bwa mem -v 1 -t 12 -M -R "@RG\tID:HF4\tSM:MT" /work/projects/ecosystem_biology/MUST/databases/integrated_reference_catalog/IGC.fa /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/HF4/Preprocessing/MT.R1.preprocessed.fq /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/HF4/Preprocessing/MT.R2.preprocessed.fq | samtools view -@ 12 -bS - > new_IMP_IGC_mapping.bam

sort <(samtools view -f2 new_IMP_IGC_mapping.bam | cut -f1) <(samtools view -f2 /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/HF4/Assembly/MT.reads.sorted.bam | cut -f1) | uniq | wc -l

sort <(samtools view -f2 new_IMP_IGC_mapping.bam | cut -f1) <(samtools view -f2 /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/HF4_megahit/Assembly/MT.reads.sorted.bam | cut -f1) | uniq | wc -l
