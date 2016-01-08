#!/bin/R

require(ggplot2)
require(reshape)
library(grid)
library(gridExtra)
library(scales)
library(gtable)
library(cowplot)
require(stringr)
require(portfolio)
require(RColorBrewer)

### Generate R plot for genome fraction ###

tax.dat <- read.table("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/X310763260_20151004-idba/Analysis/results/quast/summary/TSV/genome_fraction.tsv", header=T)
colnames(tax.dat) <- c("genome", "genome_fraction")

ggplot(data = tax.dat, aes(x = genome, y = genome_fraction, fill = genome)) +
geom_bar(stat = "identity") +
guides(fill = FALSE) +
theme(axis.title.y = element_blank()) +
ylab("Genome fraction (%)") +
coord_flip()


### Generate R plot from Krona plot data

MG.annot <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/X310763260_20151004-idba/Analysis/results/MG.gene_kegg_krona.txt", header=T)
colnames(MG.annot)[1] = "fraction"

MG.em <- MG.annot[MG.annot$Level2 == "Energy metabolism",]

map.market(id=MG.annot$Level3, 
	   area=MG.annot$fraction, 
	   group=MG.annot$Level2, 
	   color=MG.annot$fraction,
	   pal="Reds",
	   main = "Functional potential")


MT.annot <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/X310763260_20151004-idba/Analysis/results/MT.gene_kegg_krona.txt", header=T)
colnames(MT.annot)[1] = "fraction"

map.market(id=MT.annot$Level3, 
	   area=MT.annot$fraction, 
	   group=MT.annot$Level2, 
	   color=MT.annot$fraction,
	   main = "Functional expression")

