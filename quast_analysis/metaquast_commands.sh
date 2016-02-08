## This lists the commands for metaQUAST analyses.

################################################################################################################################################
### MetaQUAST analysis to compare single-omic iterative assemblies and multi-omic co-assemblies
################################################################################################################################################

### Compare SM IMP-based iterative co-assemblies against an MG and MT only SM assembly BASED ON REFERENCE GENOMES
/mnt/gaiagpfs/projects/ecosystem_biology/local_tools/quast/metaquast.py \
    -o /scratch/users/snarayanasamy/IMP_MS_data/quast_simDat_20160126 -t 12 \
    -l IMP,IMP-megahit,metAmos-IDBA_UD,MG-only,MT-only \
    -R /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/73_species/ \
    -f /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Assembly/MGMT.assembly.merged.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-megahit/Assembly/MGMT.assembly.merged.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/simDat_metAmos-IDBAUD_corrected/Assemble/out/idba-ud.31.asm/contig.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MG/MG_contigs_merged_2.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simDat-iterative_MT/MT_contigs_merged_2.fa \
    --max-ref-number 0

### Compare IMP-based iterative co-assemblies HF hybrid assemblies against an MG only HF assembly with MG-only and MT-only assemblies NO REFERENCES
/mnt/gaiagpfs/projects/ecosystem_biology/local_tools/quast/metaquast.py \
    -o /scratch/users/snarayanasamy/IMP_MS_data/quast_X310763260-20160126_vs_MG_MT -f  -t 12 \
    -l IMP,IMP-megahit,metAmos-IDBA_UD,MG-only,MT-only \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260_20151004-idba/Assembly/MGMT.assembly.merged.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260_20151006-megahit/Assembly/MGMT.assembly.merged.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/X310763260_metAmos-IDBAUD_corrected/Assemble/out/idba-ud.31.asm/contig.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260-iterative_MG/MG_contigs_merged_2.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260-iterative_MT/MT_contigs_merged_2.fa \
    --max-ref-number 0

### Compare WW IMP-based iterative co-assemblies against an MG and MT only WW assembly WITHOUT REFERENCE
/mnt/gaiagpfs/projects/ecosystem_biology/local_tools/quast/metaquast.py -f  \
    -o /scratch/users/snarayanasamy/IMP_MS_data/quast_A02-20160126_MG_MT_noref -t 12 \
    -l IMP,IMP-megahit,metAmos-IDBA_UD,MG-only,MT-only \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02_20151130-idba/Assembly/MGMT.assembly.merged.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02_20151202-megahit/Assembly/MGMT.assembly.merged.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/A02_metAmos-IDBAUD_corrected/Assemble/out/idba-ud.31.asm/contig.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02-iterative_MG/MG_contigs_merged_1.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02-iterative_MT/MT_contigs_merged_2.fa \
    --max-ref-number 0

################################################################################################################################################
### MetaQUAST analysis to compare multi-omic co-assemblies of IMP and MetAMOS
################################################################################################################################################

### Compare IMP-based iterative co-assemblies against MetAMOS based co-assemblies on the SM data
/mnt/gaiagpfs/projects/ecosystem_biology/local_tools/quast/metaquast.py \
    -o /scratch/users/snarayanasamy/IMP_MS_data/quast_simDat_20151028 -t 12 -f \
    -l IMP,IMP-megahit,metAmos,metAmos-IDBA_UD \
    -R /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/73_species/ \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-idba/Assembly/MGMT.assembly.merged.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/simulated_data_output_20151002-megahit/Assembly/MGMT.assembly.merged.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/simDat_metAmos/Assemble/out/soapdenovo.31.asm.contig \
    /scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/simDat_metAmos-IDBAUD_corrected/Assemble/out/idba-ud.31.asm/contig.fa

### Compare IMP-based iterative co-assemblies against MetAMOS based co-assemblies on the HF data
/mnt/gaiagpfs/projects/ecosystem_biology/local_tools/quast/metaquast.py \
    -o /scratch/users/snarayanasamy/IMP_MS_data/quast_X310763260-20151028 \
    -R /scratch/users/snarayanasamy/IMP_MS_data/quast_X310763260-20151022/quast_downloaded_references/ -f -t 12 \
    -l IMP,IMP-megahit,metAmos,metAmos-IDBA_UD \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260_20151004-idba/Assembly/MGMT.assembly.merged.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/X310763260_20151006-megahit/Assembly/MGMT.assembly.merged.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/X310763260_metAmos/Assemble/out/proba.asm.contig \
    /scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/X310763260_metAmos-IDBAUD_corrected/Assemble/out/idba-ud.31.asm/contig.fa

### Compare IMP-based iterative co-assemblies against MetAMOS based co-assemblies on the WW data
/mnt/gaiagpfs/projects/ecosystem_biology/local_tools/quast/metaquast.py -f \
    -o /scratch/users/snarayanasamy/IMP_MS_data/quast_A02_Microthrix_Bio17-20151208 \
    -R /mnt/nfs/projects/ecosystem_biology/LAO/Genomes/Microthrix/Assemblies/GCF_000299415.1_ASM29941v1_genomic.fna \
    -G /mnt/nfs/projects/ecosystem_biology/LAO/Genomes/Microthrix/Bio17_1/GCF_000299415.1_ASM29941v1_genomic.gff -t 12 \
    -l IMP,IMP-megahit,metAmos,metAmos-IDBA_UD \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02_20151130-idba/Assembly/MGMT.assembly.merged.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis/A02_20151202-megahit/Assembly/MGMT.assembly.merged.fa \
    /scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/A02_metAmos/Assemble/out/soapdenovo.31.asm.contig \
    /scratch/users/snarayanasamy/IMP_MS_data/metAmosAnalysis/A02_metAmos-IDBAUD_corrected/Assemble/out/idba-ud.31.asm/contig.fa

