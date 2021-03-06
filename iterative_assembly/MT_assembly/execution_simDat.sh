#!/bin/bash -l

#date
#source ../preload_modules.sh
#
#### Initialize first assembly ###
#INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Preprocessing" \
#  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT" \
#  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/simDat_iterative_MT.log" \
#  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/tmp" \
#  snakemake ALL 
#
# INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Preprocessing" \
#  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT" \
#  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/simDat_iterative_MT.log" \
#  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/tmp" \
#  snakemake GENE_CALLING_INITIAL_ASSEMBLY
#
# 
#### Initialize second assembly ###
#for ITER in {2..5}
#do
#  echo "Iteration $ITER"
#INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Preprocessing" \
#  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT" \
#  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/simDat_iterative_MT.log" \
#  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/tmp" \
#  STEP=${ITER} snakemake ALL 
#done
#
#date

OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/"

## Obtain stats from the uncollapsed contigs
ls ${OUT_DIR}/MT_contigs_cat_[1-6].fa | xargs -I{} getN50sizemax {} | \
  cut -f1,2,3,4,6 | \
  sed -e 's/NUM=//g' | \
  sed -e 's/AVG=//g' | \
  sed -e 's/N50=//g' | \
  sed -e 's/GENOMESIZE=//g' | \
  sed -e 's/MAX=//g' \
  > ${OUT_DIR}/uncollapsed_contigs_stats.tsv

## Obtain stats from the collapsed contigs
ls ${OUT_DIR}/MT_contigs_merged_[1-6].fa | xargs -I{} getN50sizemax {} | \
  cut -f1,2,3,4,6 | \
  sed -e 's/NUM=//g' | \
  sed -e 's/AVG=//g' | \
  sed -e 's/N50=//g' | \
  sed -e 's/GENOMESIZE=//g' | \
  sed -e 's/MAX=//g' \
  > ${OUT_DIR}/collapsed_contig_stats.tsv

## Calculate number of genes
paste ${OUT_DIR}/collapsed_contig_stats.tsv <(grep -hc "^>" $OUT_DIR/*.faa) > $OUT_DIR/collapsed_contig_gene_stats.tsv

### Count reads within the fastq files
INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Preprocessing"

wc -l ${INPUT_DIR}/MT.R1.preprocessed.fq | grep -v "total" > ${OUT_DIR}/pairs-raw_counts.tsv
wc -l ${OUT_DIR}/MT.R1.unmapped_[1-5].fq | grep -v "total" >> ${OUT_DIR}/pairs-raw_counts.tsv

wc -l ${INPUT_DIR}/MT.SE.preprocessed.fq | grep -v "total" > ${OUT_DIR}/singles-raw_counts.tsv
wc -l ${OUT_DIR}/MT.SE.unmapped_[1-5].fq | grep -v "total" >> ${OUT_DIR}/singles-raw_counts.tsv

awk '{print $2, $1/4}' ${OUT_DIR}/pairs-raw_counts.tsv > ${OUT_DIR}/pair_counts.tsv

awk '{print $2, $1/4}' ${OUT_DIR}/singles-raw_counts.tsv > ${OUT_DIR}/single_counts.tsv

