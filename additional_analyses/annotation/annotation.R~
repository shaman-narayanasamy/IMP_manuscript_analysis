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

source("./treemap_functions.R")
source("http://dl.dropbox.com/u/10640416/treemapbrewer.r")

### Generate R plot for genome fraction ###

tax.dat <- read.table("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/X310763260_20151004-idba/Analysis/results/quast/summary/TSV/genome_fraction.tsv", header=T)
colnames(tax.dat) <- c("genome", "genome_fraction")

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/genome_recovery.pdf", 
    width = 15, height = 15)
ggplot(data = tax.dat, aes(x = genome, y = genome_fraction, fill = genome)) +
geom_bar(stat = "identity") +
guides(fill = FALSE) +
theme(axis.title.y = element_blank(),
      axis.text.y = element_text(size=25),
      axis.title.x = element_text(size=30),
      axis.text.x = element_text(size=25)) +
ylab("Genome fraction (%)") +
coord_flip()

dev.off()


### Generate R plot from Krona plot data

MG.annot <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/X310763260_20151004-idba/Analysis/results/MG.gene_kegg_krona.txt", header=T)
colnames(MG.annot)[1] = "fraction"
MG.annot <- cbind(id = 1:nrow(MG.annot), MG.annot)
MG.annot <- cbind(MG.annot, area=rep(1, nrow(MG.annot)))
MG.annot <- MG.annot[MG.annot$Level1 == "Metabolism",]
MG.annot$rel <- MG.annot$fraction/sum(MG.annot$fraction)*100

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/MG_treemap.pdf", 
    width = 6.5, height = 5)
treemap(   id=MG.annot$Level3, 
	   area=MG.annot$area, 
	   group=MG.annot$Level2, 
	   color=MG.annot$rel,
	   pal="Blues",
	   linecol = "black",
	   textcol = "black",
	   main = "Functional potential")
dev.off()

MT.annot <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/X310763260_20151004-idba/Analysis/results/MT.gene_kegg_krona.txt", header=T)
colnames(MT.annot)[1] = "fraction"
MT.annot <- cbind(id = 1:nrow(MT.annot), MT.annot)
MT.annot <- cbind(MT.annot, area=rep(1, nrow(MT.annot)))
MT.annot <- MT.annot[MT.annot$Level1 == "Metabolism",]
MT.annot$rel <- MT.annot$fraction/sum(MT.annot$fraction)*100

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/MT_treemap.pdf", 
    width = 6.5, height = 5)
treemap(   id=MT.annot$Level3, 
	   area=MT.annot$area, 
	   group=MT.annot$Level2, 
	   color=MT.annot$rel,
	   pal="Reds",
	   linecol = "black",
	   textcol = "black",
	   main = "Functional expression")
dev.off()

