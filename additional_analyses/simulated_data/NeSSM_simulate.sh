#!/bin/bash -l


### Initialize scripts and binaries
SCRIPTS="/home/users/snarayanasamy/NeSSM/scripts"
BIN="/home/users/snarayanasamy/NeSSM/NeSSM_CPU/NeSSM"

### Run NeSSM
perl $SCRIPTS/mk_index.pl /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/73_species /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/indexes
mv /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/indexes/index /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/indexes/index_back

paste <(cut -f5 /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/indexes/index_back | cut -f9 -d "/") <(cat /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/indexes/index_back) > /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/indexes/index
paste <(cut -f1 /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/indexes/index) <(cut -f2 /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/73_species_abundance.txt) -d "\t" > /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/73_species_abundance-new.txt

perl $SCRIPTS/adjust.pl /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/73_species_abundance-new.txt indexes/index

$BIN -list  /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/new-percentage.txt -index  /mnt/nfs/projects/ecosystem_biology/test_datasets/CelajEtAl/indexes/index -m illumina -o 73_species_MG -r 10000000 -l 120 -e 1 -c /home/users/snarayanasamy/NeSSM/NeSSM_CPU/simulation.config

