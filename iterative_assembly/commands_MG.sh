#!/bin/bash -l
source ~/.bashrc
#echo "Preprocessing started on:"
#date
#~/integrated-metaomic-pipeline/01b.preprocess.de_duplicate.sh -1 A02_MG.R1.fq -2 A02_MG.R2.fq -t 0
#
#~/integrated-metaomic-pipeline/01c.preprocess.trim.sh -t 0 -1 A02_MG.R1.uniq.fq -2 A02_MG.R2.uniq.fq -l 40
#
#echo "Preprocessing ended on:"
#date

#echo "Assembly started on:"
#date
#which idba_ud
#~/integrated-metaomic-pipeline/02a.assembly.idba_ud.sh A02_MG.R1.uniq.trim_mi0.9.L40.fq A02_MG.R2.uniq.trim_mi0.9.L40.fq A02_MG.SE.uniq.trim_mi0.9.L40.fq A02_MG_assm1 -t 30
#echo "Assembly ended on:"
#date
#
### Map to first assembly
#
#~/integrated-metaomic-pipeline/03a.mapping_bwa.sh -1 A02_MG.R1.uniq.trim_mi0.9.L40.fq -2 A02_MG.R2.uniq.trim_mi0.9.L40.fq -s A02_MG.SE.uniq.trim_mi0.9.L40.fq -r A02_MG_assm1/contig.fa -d "@RG\tID:A02\tSM:MG" -o A02_MG_x_A02_MG_assm1 -t 6
#
### Extract unmapped reads
#~/integrated-metaomic-pipeline/util.extract_unmapped.sh -t 0 -b A02_MG_x_A02_MG_assm1.sorted.bam -1 A02_MG_x_A02_MG_assm1.unmapped.R1.fq -2 A02_MG_x_A02_MG_assm1.unmapped.R2.fq

## Perform second assembly
#~/integrated-metaomic-pipeline/02a.assembly.idba_ud.sh -t 32 A02_MG_x_A02_MG_assm1.unmapped.R1.fq A02_MG_x_A02_MG_assm1.unmapped.R2.fq A02_MG_assm2

# Merge first and second assembly
#~/integrated-metaomic-pipeline/02c.merge_assemblies.sh A02_MG_assm1/contig.fa A02_MG_assm2/contig.fa A02_MG_assm1_assm2

# Map to merged first and second assembly
#~/integrated-metaomic-pipeline/03a.mapping_bwa.sh -1 A02_MG.R1.uniq.trim_mi0.9.L40.fq -2 A02_MG.R2.uniq.trim_mi0.9.L40.fq -s A02_MG.SE.uniq.trim_mi0.9.L40.fq -r A02_MG_assm1_assm2.merged.fa -d "@RG\tID:A02\tSM:MG" -o A02_MG_x_A02_MG_assm1_assm2 -t 32

## Extract unmapped reads
#~/integrated-metaomic-pipeline/util.extract_unmapped.sh -t 0 -b A02_MG_x_A02_MG_assm1_assm2.sorted.bam -1 A02_MG_x_A02_MG_assm1_assm2.unmapped.R1.fq -2 A02_MG_x_A02_MG_assm1_assm2.unmapped.R2.fq

## Perform third assembly
#~/integrated-metaomic-pipeline/02a.assembly.idba_ud.sh -t 32 A02_MG_x_A02_MG_assm1_assm2.unmapped.R1.fq A02_MG_x_A02_MG_assm1_assm2.unmapped.R2.fq A02_MG_assm3

# Merge first second and third assembly
#~/integrated-metaomic-pipeline/02c.merge_assemblies.sh A02_MG_assm1_assm2.merged.fa A02_MG_assm3/contig.fa A02_MG_assm1_assm2_assm3

#~/integrated-metaomic-pipeline/03a.mapping_bwa.sh -1 A02_MG.R1.uniq.trim_mi0.9.L40.fq -2 A02_MG.R2.uniq.trim_mi0.9.L40.fq -s A02_MG.SE.uniq.trim_mi0.9.L40.fq -r A02_MG_assm1_assm2_assm3.merged.fa -d "@RG\tID:A02\tSM:MG" -o A02_MG_x_A02_MG_assm1_assm2_assm3 -t 32
#
#### Extract unmapped reads
#~/integrated-metaomic-pipeline/util.extract_unmapped.sh -t 0 -b A02_MG_x_A02_MG_assm1_assm2_assm3.sorted.bam -1 A02_MG_x_A02_MG_assm1_assm2_assm3.unmapped.R1.fq -2 A02_MG_x_A02_MG_assm1_assm2_assm3.unmapped.R2.fq
##
#### Perform fourth assembly
#~/integrated-metaomic-pipeline/02a.assembly.idba_ud.sh -t 32 A02_MG_x_A02_MG_assm1_assm2_assm3.unmapped.R1.fq A02_MG_x_A02_MG_assm1_assm2_assm3.unmapped.R2.fq A02_MG_assm4
##
### Merge first second and third assembly
#~/integrated-metaomic-pipeline/02c.merge_assemblies.sh A02_MG_assm1_assm2_assm3.merged.fa A02_MG_assm4/contig.fa A02_MG_assm1_assm2_assm3_assm4
##
# Map to the final assembly
#~/integrated-metaomic-pipeline/03a.mapping_bwa.sh -1 A02_MG.R1.uniq.trim_mi0.9.L40.fq -2 A02_MG.R2.uniq.trim_mi0.9.L40.fq -s A02_MG.SE.uniq.trim_mi0.9.L40.fq -r A02_MG_assm1_assm2_assm3_assm4.merged.fa -d "@RG\tID:A02\tSM:MG" -o A02_MG_x_A02_MG_assm1_assm2_assm3_assm4 -t 32

~/integrated-metaomic-pipeline/util.extract_unmapped.sh -t 0 -b A02_MG_x_A02_MG_assm1_assm2_assm3_assm4.sorted.bam -1 A02_MG_x_A02_MG_assm1_assm2_assm3_assm4.unmapped.R1.fq -2 A02_MG_x_A02_MG_assm1_assm2_assm3_assm4.unmapped.R2.fq
