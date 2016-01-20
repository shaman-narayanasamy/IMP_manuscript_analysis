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

### Reorder according to value
tax.dat <- transform(tax.dat, genome = reorder(genome, genome_fraction))

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/genome_recovery-v3.pdf", 
    width = 15, height = 15)
ggplot(data = tax.dat, aes(x = genome, y = genome_fraction)) +
geom_bar(stat = "identity", position="dodge", fill = "mediumorchid4") +
guides(fill = FALSE) +
theme(axis.title.y = element_blank(),
      axis.text.y = element_text(size=25, face="italic"),
      axis.title.x = element_text(size=30),
      axis.text.x = element_text(size=25)) +
coord_flip() +
scale_x_discrete(labels = c(gsub("_", " ", levels(tax.dat$genome)))) +
ylab("Genome fraction (%)") 

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

load("/home/shaman/Documents/Publications/IMP-manuscript/figures/X310763260_20151004-idba/Analysis/results/MGMT_results.Rdat")
source()

vb.MGvarden.new <- vb.MGvarden + scale_size(range = c(2,20))
vb.depRatio.new <- vb.depRatio + scale_size(range = c(2,20))


png("/home/shaman/Documents/Publications/IMP-manuscript/figures/IMP-vizbin_length_MGvardens.png", width=1500, height=1500)
vb.MGvarden.new + guides(colour=F, size=F, alpha=F) 
dev.off()

png("/home/shaman/Documents/Publications/IMP-manuscript/figures/IMP-vizbin_length_depRatio.png", width=1500, height=1500)
vb.depRatio.new + guides(colour=F, size=F, alpha=F) 
dev.off()

## Extract the legend
a.gplot <- vb.MGvarden.new

g_legend<-function(a.gplot){ 
  tmp <- ggplot_gtable(ggplot_build(a.gplot)) 
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box") 
  legend <- tmp$grobs[[leg]] 
  return(legend)} 

legend <- g_legend(vb.MGvarden.new) 

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/IMP-vizbin_length_MGvardens_legend.pdf", width=10, height=25)
grid.draw(legend) 
dev.off()

legend <- g_legend(vb.depRatio.new) 

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/IMP-vizbin_length_depRatio_legend.pdf", width=10, height=25)
grid.draw(legend) 
dev.off()



