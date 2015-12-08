#!/bin/R

require(ggplot2)
require(reshape)
library(grid)
library(gridExtra)
library(scales)
library(gtable)
library(cowplot)

dat.1 <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/X310763260-iterative_MG/full_report.tsv")
dat.2 <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/X310763260-iterative_MG/uncollapse_contig_no.tsv", header=F)
dat <- cbind(dat.1, dat.2$V2)
colnames(dat)[ncol(dat)] <- "uncollapsed_contigs"

#read.table("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/A02-iterative_MG/full_report.tsv")

dat$X..contigs.....0.bp.[2:nrow(dat)] - dat$X..contigs.....0.bp.[1:nrow(dat)-1]
dat$uncollapsed_contigs[2:nrow(dat)] - dat$uncollapsed_contigs[1:nrow(dat)-1]

m.dat <- t(matrix(as.numeric(unlist(dat)),nrow=nrow(dat)))

heatmap(m.dat, Rowv=NA, Colv=NA, scale="column")
heatmap(m.dat, Rowv=NA, Colv=NA, scale="row")
heatmap.2(m.dat, Rowv=FALSE, Colv=FALSE, symm=FALSE, scale="column")

