#!/bin/bash -l

OUTFILE="prodigal_summary.tsv"
declare -a SAMPLES=("SM" "HF1" "HF2" "HF3" "HF4" "HF5" "WW1" "WW2" "WW3" "WW4" "BG")

echo -e "Dataset\tAssembly\tProdigal_total_genes\tProdigal_complete_genes\tProdigal_incomplete_genes" > ${OUTFILE}

### Repeat for all the data sets
for S in "${SAMPLES[@]}" 
do
    IMP_MGMT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/IMP_MGMT/${S}/"
    IMP_MEGAHIT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/IMP-megahit/${S}/"
    IMP_MG="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/IMP_MG/${S}"
    IMP_MT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/IMP_MT/${S}"

    MOCAT_MGMT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/MOCAT_MGMT/${S}"
    MOCAT_MG="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/MOCAT_MG/${S}"
    MOCAT_MT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/MOCAT_MT/${S}"

    METAMOS_MGMT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/metAmos_MGMT/${S}"
    METAMOS_MG="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/metAmos_MG/${S}"
    METAMOS_MT="/scratch/users/snarayanasamy/IMP_MS_data/prodigal_analysis/metAmos_MT/${S}"

    paste <(echo ${S}) <(echo IMP) <(tail -n1 $IMP_MGMT/gene_count.Prodigal.tsv) >> ${OUTFILE}
    paste <(echo ${S}) <(echo IMP-megahit) <(tail -n1 $IMP_MEGAHIT/gene_count.Prodigal.tsv) >> ${OUTFILE}
    paste <(echo ${S}) <(echo MOCAT_MGMT) <(tail -n1 $MOCAT_MGMT/gene_count.Prodigal.tsv) >> ${OUTFILE}
    paste <(echo ${S}) <(echo MetAMOS_MGMT) <(tail -n1 $METAMOS_MGMT/gene_count.Prodigal.tsv) >> ${OUTFILE}

    paste <(echo ${S}) <(echo IMP_MG) <(tail -n1 $IMP_MG/gene_count.Prodigal.tsv) >> ${OUTFILE}
    paste <(echo ${S}) <(echo MOCAT_MG) <(tail -n1 $MOCAT_MG/gene_count.Prodigal.tsv) >> ${OUTFILE}
    paste <(echo ${S}) <(echo MetAMOS_MG) <(tail -n1 $METAMOS_MG/gene_count.Prodigal.tsv) >> ${OUTFILE}

    paste <(echo ${S}) <(echo IMP_MT) <(tail -n1 $IMP_MT/gene_count.Prodigal.tsv) >> ${OUTFILE}
    paste <(echo ${S}) <(echo MOCAT_MT) <(tail -n1 $MOCAT_MT/gene_count.Prodigal.tsv) >> ${OUTFILE}
    paste <(echo ${S}) <(echo MetAMOS_MT) <(tail -n1 $METAMOS_MT/gene_count.Prodigal.tsv) >> ${OUTFILE}

done

