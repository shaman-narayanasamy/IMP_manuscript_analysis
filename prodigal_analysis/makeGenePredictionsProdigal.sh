#!/bin/bash

prodigal=/work/projects/ecosystem_biology/local_tools/MOCAT/bin/prodigal

contig=$1
gpdir=$2

mkdir -p $gpdir  
cd $gpdir

ln -s ../$contig

$prodigal -f gff -a contig.Prodigal.faa.tmp -d contig.Prodigal.fna.tmp -p meta -o contig.Prodigal.gff -i $contig -q 2>>gene.prediction.log >>gene.prediction.log 

/work/projects/ecosystem_biology/local_tools/MOCAT/src/MOCATGenePredictionProdigal_aux.pl contig.Prodigal.fna.tmp contig.Prodigal.faa.tmp contig.Prodigal.tab  2>> gene_prediction.log >> gene_prediction.log

perl /work/projects/ecosystem_biology/local_tools/MOCAT/fetchMG/fetchMG.pl -o marker_genes -t 4 -d contig.Prodigal.fna  -m extraction contig.Prodigal.faa

## Aggregate complete and incomplete genes in a table
echo -e "Prodigal_all\tProdigal_complete\tProdigal_incomplete" > gene_count.Prodigal.tsv
paste <(wc -l contig.Prodigal.tab | cut -f1 -d " ") <(grep -wc "complete" contig.Prodigal.tab) <(grep -wc "incomplete" contig.Prodigal.tab) -d "\t" >> gene_count.Prodigal.tsv

cd ..
