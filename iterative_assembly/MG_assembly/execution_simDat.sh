#!/bin/bash -l

source ../preload_modules.sh

date

### Initialize first assembly ###
echo "Executing inital assembly"
INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM/Preprocessing" \
  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/SM-iterative_MG/" \
  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/SM-iterative_MG/simDat_iterative_MG.log" \
  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/tmp" \
  snakemake ALL

echo "Executing inital assembly"
INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM/Preprocessing" \
  OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/SM-iterative_MG/" \
  OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/SM-iterative_MG/simDat_iterative_MG.log" \
  TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/tmp" \
  snakemake EXTRACT_UNMAPPED

for ITER in 2 3 4 5
do
  echo "Iteration $ITER"
    INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM/Preprocessing" \
      OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/SM-iterative_MG/" \
      OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/SM-iterative_MG/simDat_iterative_MG.log" \
     
      OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/" \
      OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/simDat_iterative_MG-2.log" \
      TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/tmp" \
      STEP=${ITER} snakemake -f ALL
done

## For some reason, it is not possible to run cap3 on the fifth assembly. Therefore, we simply copy the 
## concatenated set of contigs to perform the mapping
OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/iterative_assemblies/MG_assemblies/SM-iterative_MG/" \

cp ${OUT_DIR}/MG_contigs_cat_5.fa ${OUT_DIR}/MG_contigs_merged_5.fa

    INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM/Preprocessing" \
      OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/" \
      OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/simDat_iterative_MG-2.log" \
      TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/tmp" \
      STEP=4 snakemake --cleanup-metadata ${OUT_DIR}/MG_contigs_merged_5.fa


### Contigs cannot merged/assembled using cap3 because they are too long
### Using cd-hit-est to perform initial collapse

#/mnt/nfs/projects/ecosystem_biology/local_tools/cd-hit-v4.6.1-2012-08-27_OpenMP_MAX_SEQ-5MBP/cd-hit-est -i /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/MG_contigs_cat_5.fa -o /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/MG_contigs_cat_5-cdhit.fa -c 0.95 -t 120

### Using cd-hit-lap to extend contigs based on 100% identity
#/mnt/nfs/projects/ecosystem_biology/local_tools/cd-hit-auxtools-v0.5-2012-03-07/cd-hit-lap -i /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/MG_contigs_cat_5-cdhit.fa -o /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/MG_contigs_cat_5-cdhit-olap.fa -m 100

INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM/Preprocessing" \
OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/" \
OUT_LOG="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/simDat_iterative_MG-2.log" \
TMP="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/tmp" \
STEP=4 snakemake -np QUAST

ln -s /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/MG_contigs_cat_5-cdhit-olap.fa /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/MG_contigs_merged_5.fa

## Join tables
OUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM-iterative_MG/"

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

paste <(cat $OUT_DIR/full_report.tsv) <(cat <(echo -e "avg_contig_len\tgenome_len") <(cat ${OUT_DIR}/merged_contigs_tmp.tsv)) > ${OUT_DIR}/collapsed_contigs_stats.tsv

rm -rf ${OUT_DIR}/uncollapsed_tmp2.tsv  ${OUT_DIR}/uncollapsed_tmp.tsv ${OUT_DIR}/merged_contigs_tmp.tsv

### Count reads within the fastq files
INPUT_DIR="/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM/Preprocessing"

wc -l ${INPUT_DIR}/MG.R1.preprocessed.fq | grep -v "total" > ${OUT_DIR}/pairs-raw_counts.tsv
wc -l ${OUT_DIR}/MG.R1.unmapped_[1-6].fq | grep -v "total" >> ${OUT_DIR}/pairs-raw_counts.tsv

wc -l ${INPUT_DIR}/MG.SE.preprocessed.fq | grep -v "total" > ${OUT_DIR}/singles-raw_counts.tsv
wc -l ${OUT_DIR}/MG.SE.unmapped_[1-6].fq | grep -v "total" >> ${OUT_DIR}/singles-raw_counts.tsv

awk '{print $2, $1/4}' ${OUT_DIR}/pairs-raw_counts.tsv > ${OUT_DIR}/pair_counts.tsv

awk '{print $2, $1/4}' ${OUT_DIR}/singles-raw_counts.tsv > ${OUT_DIR}/single_counts.tsv

date
