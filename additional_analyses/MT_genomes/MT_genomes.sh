#!/bin/bash -l

# Add pullseq to path

PATH=/home/users/claczny/apps/software/pullseq/bin/:$PATH
DIR_HF=/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260_20151004-idba-virusContigs
DIR_WW=/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02_20151130-idba-virusContigs
INPUT_HF=/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260_20151004-idba/Assembly/MGMT.assembly.merged.fa
INPUT_WW=/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02_20151130-idba/Assembly/MGMT.assembly.merged.fa

### These steps were done on my local machine (commented out)
## Extract contig IDs from the tsv file.

#cut -f1 X310763260_MT_contigs.tsv | tail -n +2 | uniq > X310763260_MT_contigs.ids
#cut -f1 A02_MT_contigs.tsv | tail -n +2 | uniq > A02_MT_contigs.ids

## Copy the contig IDs onto gaia

#scp X310763260_MT_contigs.ids gaia:/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260_20151004-idba-virusContigs
#scp A02_MT_contigs.ids gaia:/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02_20151004-idba-virusContigs

## Extract the sequences
pullseq -i $INPUT_HF -n $DIR_HF/X310763260_MT_contigs.ids > $DIR_HF/X310763260_MT_contigs.fa
pullseq -i $INPUT_WW -n $DIR_WW/A02_MT_contigs.ids > $DIR_WW/A02_MT_contigs.fa

## The fasta files with the virus contigs are submitted to NCBI BLAST

