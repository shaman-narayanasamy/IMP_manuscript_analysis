#!/bin/bash -l

source ../preload_modules.sh

date

### Initialize first assembly ###
#echo "Executing inital assembly"
#INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Preprocessing" \
#  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/" \
#  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/simDat_iterative_MG-2.log" \
#  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/tmp" \
#  snakemake ALL
#
#echo "Executing inital assembly"
#INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Preprocessing" \
#  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/" \
#  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/simDat_iterative_MG-2.log" \
#  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/tmp" \
#  snakemake EXTRACT_UNMAPPED

### For some reason, it is not possible to run cap3 on the fifth assembly. Therefore, we simply copy the 
### concatenated set of contigs to perform the mapping
#OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/"
#cp ${OUT_DIR}/MG_contigs_cat_5.fa ${OUT_DIR}/MG_contigs_merged_5.fa
#
#    INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Preprocessing" \
#      OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/" \
#      OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/simDat_iterative_MG-2.log" \
#      TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/tmp" \
#      STEP=4 snakemake --cleanup-metadata ${OUT_DIR}/MG_contigs_merged_5.fa
#

for ITER in 4 5
do
  echo "Iteration $ITER"
    INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Preprocessing" \
      OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/" \
      OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/simDat_iterative_MG-2.log" \
      TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/tmp" \
      STEP=${ITER} snakemake -f ALL
done

## Join tables
#OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/"
#
#cat <(cat ${OUT_DIR}/quast_1/transposed_report.tsv) \
#  <(tail -n1 ${OUT_DIR}/quast_[2-6]/transposed_report.tsv | \
#  grep -v "==>" | grep -v "^$") > ${OUT_DIR}/full_report.tsv
#
#ls ${OUT_DIR}/MG_contigs_cat_[1-6].fa | xargs -I{} getN50sizemax {} | \
#  cut -f1,2,3,4,6 | \
#  sed -e 's/NUM=//g' | \
#  sed -e 's/AVG=//g' | \
#  sed -e 's/N50=//g' | \
#  sed -e 's/GENOMESIZE=//g' | \
#  sed -e 's/MAX=//g' \
#  >> ${OUT_DIR}/uncollapsed_tmp.tsv
#
#paste <(ls ${OUT_DIR}/MG_contigs_cat_[1-6].fa) ${OUT_DIR}/uncollapsed_tmp.tsv > ${OUT_DIR}/uncollapsed_tmp2.tsv
#
#cat <(echo -e "assembly\tcontig_no\tavg_contig_len\tN50\tgenome_len\tmax_contig_len") <(cat ${OUT_DIR}/uncollapsed_tmp2.tsv) > ${OUT_DIR}/uncollapsed_contigs_stats.tsv
#
#ls ${OUT_DIR}/MG_contigs_merged_[1-6].fa | xargs -I{} getN50sizemax {} | \
#  cut -f2,4 | \
#  sed -e 's/AVG=//g' | \
#  sed -e 's/GENOMESIZE=//g' \
#  >> ${OUT_DIR}/merged_contigs_tmp.tsv
#
#paste <(cat $OUT_DIR/full_report.tsv) <(cat <(echo -e "avg_contig_len\tgenome_len") <(cat ${OUT_DIR}/merged_contigs_tmp.tsv)) > ${OUT_DIR}/collapsed_contigs_stats.tsv
#
#rm -rf ${OUT_DIR}/uncollapsed_tmp2.tsv  ${OUT_DIR}/uncollapsed_tmp.tsv ${OUT_DIR}/merged_contigs_tmp.tsv
#
#### Count reads within the fastq files
#INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Preprocessing"
#
#wc -l ${INPUT_DIR}/MG.R1.preprocessed.fq | grep -v "total" > ${OUT_DIR}/pairs-raw_counts.tsv
#wc -l ${OUT_DIR}/MG.R1.unmapped_[1-6].fq | grep -v "total" >> ${OUT_DIR}/pairs-raw_counts.tsv
#
#wc -l ${INPUT_DIR}/MG.SE.preprocessed.fq | grep -v "total" > ${OUT_DIR}/singles-raw_counts.tsv
#wc -l ${OUT_DIR}/MG.SE.unmapped_[1-6].fq | grep -v "total" >> ${OUT_DIR}/singles-raw_counts.tsv
#
#awk '{print $2, $1/4}' ${OUT_DIR}/pairs-raw_counts.tsv > ${OUT_DIR}/pair_counts.tsv
#
#awk '{print $2, $1/4}' ${OUT_DIR}/singles-raw_counts.tsv > ${OUT_DIR}/single_counts.tsv

date
