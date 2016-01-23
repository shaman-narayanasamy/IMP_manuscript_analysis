#!/bin/bash

# Map SM MG to MT-only assembly
./readMappingSingleOmics.sh \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM_IMP/Preprocessing/MG.R1.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM_IMP/Preprocessing/MG.R2.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM_IMP/Preprocessing/MG.SE.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/MT_contigs_merged_2.fa \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/mappingSingleOmics/SM \
	MG \
	MT \
	SM

# Map SM MT to MT-only assembly
./readMappingSingleOmics.sh \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM_IMP/Preprocessing/MT.R1.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM_IMP/Preprocessing/MT.R2.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/SM_IMP/Preprocessing/MT.SE.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/MG_contigs_merged_2.fa \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/mappingSingleOmics/SM \
	MT \
	MG \
	SM

# Map HF MG to MT-only assembly
./readMappingSingleOmics.sh \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/HF_IMP/Preprocessing/MG.R1.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/HF_IMP/Preprocessing/MG.R2.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/HF_IMP/Preprocessing/MG.SE.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/MT_contigs_merged_2.fa \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/mappingSingleOmics/HF \
	MG \
	MT \
	HF

# Map HF MT to MT-only assembly
./readMappingSingleOmics.sh \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/HF_IMP/Preprocessing/MT.R1.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/HF_IMP/Preprocessing/MT.R2.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/HF_IMP/Preprocessing/MT.SE.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/MG_contigs_merged_2.fa \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/mappingSingleOmics/HF \
	MT \
	MG \
	HF

# Map WW MG to MT-only assembly
./readMappingSingleOmics.sh \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/WW_IMP/Preprocessing/MG.R1.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/WW_IMP/Preprocessing/MG.R2.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/WW_IMP/Preprocessing/MG.SE.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/MT_contigs_merged_2.fa \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/mappingSingleOmics/WW \
	MG \
	MT \
	WW

# Map WW MT to MT-only assembly
./readMappingSingleOmics.sh \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/WW_IMP/Preprocessing/MT.R1.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/WW_IMP/Preprocessing/MT.R2.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/WW_IMP/Preprocessing/MT.SE.preprocessed.fq \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/MG_contigs_merged_2.fa \
	/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/mappingSingleOmics/WW \
	MT \
	MG \
	WW

