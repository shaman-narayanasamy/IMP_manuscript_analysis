#!/bin/R

require(ggplot2)
require(reshape)
library(grid)
library(gridExtra)
library(scales)
library(gtable)
library(cowplot)
require(stringr)

### Read in assembly assessment data
dat <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/X310763260-iterative_MG/collapsed_contigs_stats.tsv")

### Read in unmappable read data
pe <- read.table("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/X310763260-iterative_MG/pair_counts.tsv", header=F)
colnames(pe) <- c("file", "reads_used")
se <- read.table("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/X310763260-iterative_MG/single_counts.tsv", header=F)
colnames(se) <- c("file", "reads_used")

# Reformulate table
pe <- 
    cbind(pe, 
	    type=rep("PE", nrow(pe)),
	    Assembly=1:6,
	    unmappable=c(pe$reads_used[2:nrow(pe)], NA),
	    mappable=c(pe$reads_used[1] - pe$reads_used[2:nrow(pe)], NA)
	    )

additional_mapped=c(NA, pe$mappable[2:nrow(pe)] - pe$mappable[1:nrow(pe)-1])
pe <- cbind(pe, additional_mapped)

se <- 
    cbind(se, 
	  unmappable=c(se$reads_used[2:6], NA), 
	  type=rep("SE", nrow(pe)), 
	  Assembly=1:6, 
	  mappable=c(se$reads_used[1] - se$reads_used[2:6], NA)
)

additional_mapped=c(NA, se$mappable[2:nrow(se)] - se$mappable[1:nrow(se)-1])
se <- cbind(se, additional_mapped)

reads <- rbind(pe, se)

### Plot raw number of total contigs and genes
dat$Assembly=as.character(1:6)
m.dat <- melt(dat[, c(1,2,3,23)])
colnames(m.dat)[2:3] <- c("type", "value")

contigs <- ggplot(data=m.dat, aes(x=Assembly, y=value, fill=type)) + 
geom_bar(stat="identity", position="dodge") +
ggtitle("All contigs")

### Plot gain of contigs and genes relative to previous assembly
d.dat <- dat[2:nrow(dat),c(3,22)] - dat[1:nrow(dat)-1,c(3,22)]
d.dat <- rbind(dat[1,c(3,22)], d.dat)
d.dat <- cbind(as.character(dat[,1]), d.dat)
colnames(d.dat)[1] <- "Assembly"

m.d.dat <- melt(d.dat)
m.d.dat$value[m.d.dat$value==0] = NA
colnames(m.d.dat)[2:3] <- c("type", "value")

contig.gain <- ggplot(data=m.d.dat, aes(x=Assembly, y=log10(value), fill=type)) + 
geom_bar(stat="identity", position="dodge") +
ggtitle("Additional contigs")

### Plot N50 values
c.dat <- dat[1:nrow(dat),c(1,27,17,18)]
m.c.dat <- melt(c.dat)
colnames(m.c.dat)[2:3] <- c("type", "value")

contig.len <- ggplot(data=m.c.dat, aes(x=Assembly, y=value, fill=type)) + 
geom_bar(stat="identity", position="dodge") +
ggtitle("Contiguity")

### Plot number of unmappable reads
mappable <- ggplot(data=reads, aes(x=Assembly, y=mappable, fill=type)) + 
geom_bar(stat="identity", position="dodge") +
ggtitle("Mappabe reads")

unmappable <- ggplot(data=reads, aes(x=Assembly, y=unmappable, fill=type)) + 
geom_bar(stat="identity", position="dodge") +
ggtitle("Unmappable reads")

add.mapped <- ggplot(data=reads, aes(x=Assembly, y=log10(additional_mapped), fill=type)) + 
geom_bar(stat="identity", position="dodge") +
ggtitle("Additonal mapped")

png("iterative_assm-draft_all.png", height=1200, width=600)
plot_grid(contigs, contig.gain, contig.len, mappable, unmappable, add.mapped, ncol=1, align="v")
dev.off()

png("iterative_assm-draft_informative.png", height=600, width=600)
plot_grid(contig.gain, add.mapped, ncol=1, align="v")
dev.off()

### Plot as a heatmap
#m.dat <- t(matrix(as.numeric(unlist(dat)),nrow=nrow(dat)))
#
#
#heatmap(m.dat, Rowv=NA, Colv=NA, scale="column")
#heatmap(m.dat, Rowv=NA, Colv=NA, scale="row")
#heatmap.2(m.dat, Rowv=FALSE, Colv=FALSE, symm=FALSE, scale="column")
#
