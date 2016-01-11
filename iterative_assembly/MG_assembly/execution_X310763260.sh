#!/bin/bash -l

source ../preload_modules.sh

### Initialize first assembly ###
INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260_20151004-idba/Preprocessing" \
  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260-iterative_MG" \
  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260-iterative_MG/X310763260_iterative_MG.log" \
  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260-iterative_MG/tmp" \
  snakemake ALL

INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260_20151004-idba/Preprocessing" \
  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260-iterative_MG" \
  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260-iterative_MG/X310763260_iterative_MG.log" \
  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260-iterative_MG/tmp" \
  snakemake EXTRACT_UNMAPPED
  
### Initialize second assembly ###
for ITER in 2 3 4 5
do
  echo "Iteration $ITER"
INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260_20151004-idba/Preprocessing" \
  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260-iterative_MG" \
  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260-iterative_MG/X310763260_iterative_MG.log" \
  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260-iterative_MG/tmp" \
  STEP=${ITER} snakemake ALL
done
 
### Join tables
OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260-iterative_MG"

cat <(cat ${OUT_DIR}/quast_1/transposed_report.tsv) \
  <(tail -n1 ${OUT_DIR}/quast_[2-6]/transposed_report.tsv | \
  grep -v "==>" | grep -v "^$") > ${OUT_DIR}/full_report.tsv

ls ${OUT_DIR}/MG_contigs_cat_[1-6].fa | xargs -I{} getN50sizemax {} | \
  cut -f1,2,3,4,6 | \
  sed -e 's/NUM=//g' | \
  sed -e 's/AVG=//g' | \
  sed -e 's/N50=//g' | \
  sed -e 's/GENOMESIZE=//g' | \
  sed -e 's/MAX=//g' \
  >> ${OUT_DIR}/uncollapsed_tmp.tsv

paste <(ls ${OUT_DIR}/MG_contigs_cat_[1-6].fa) ${OUT_DIR}/uncollapsed_tmp.tsv > ${OUT_DIR}/uncollapsed_tmp2.tsv

cat <(echo -e "assembly\tcontig_no\tavg_contig_len\tN50\tgenome_len\tmax_contig_len") <(cat ${OUT_DIR}/uncollapsed_tmp2.tsv) > ${OUT_DIR}/uncollapsed_contigs_stats.tsv

ls ${OUT_DIR}/MG_contigs_merged_[1-6].fa | xargs -I{} getN50sizemax {} | \
  cut -f2,4 | \
  sed -e 's/AVG=//g' | \
  sed -e 's/GENOMESIZE=//g' \
  >> ${OUT_DIR}/merged_contigs_tmp.tsv

paste <(cat full_report.tsv) <(cat <(echo -e "avg_contig_len\tgenome_len") <(cat ${OUT_DIR}/merged_contigs_tmp.tsv)) > ${OUT_DIR}/collapsed_contigs_stats.tsv

rm -rf ${OUT_DIR}/uncollapsed_tmp2.tsv  ${OUT_DIR}/uncollapsed_tmp.tsv ${OUT_DIR}/merged_contigs_tmp.tsv

### Count reads within the fastq files
INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260_20151004-idba/Preprocessing"

wc -l ${INPUT_DIR}/MG.R1.preprocessed.fq | grep -v "total" > ${OUT_DIR}/pairs-raw_counts.tsv
wc -l ${OUT_DIR}/MG.R1.unmapped_[1-6].fq | grep -v "total" >> ${OUT_DIR}/pairs-raw_counts.tsv

wc -l ${INPUT_DIR}/MG.SE.preprocessed.fq | grep -v "total" > ${OUT_DIR}/singles-raw_counts.tsv
wc -l ${OUT_DIR}/MG.SE.unmapped_[1-6].fq | grep -v "total" >> ${OUT_DIR}/singles-raw_counts.tsv

awk '{print $2, $1/4}' ${OUT_DIR}/pairs-raw_counts.tsv > ${OUT_DIR}/pair_counts.tsv

awk '{print $2, $1/4}' ${OUT_DIR}/singles-raw_counts.tsv > ${OUT_DIR}/single_counts.tsv

date

