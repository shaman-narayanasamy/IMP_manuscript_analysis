#!/bin/R
require(xtable)
require(genomeIntervals)
require(ggplot2)
require(gtable)
require(beanplot)
require(reshape)

dat.1 <- read.table("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/MT_genomes/HF_ref/Escherichia_coli_P12b-stats.tsv", header=T, na.strings="-")
dat.1 <- cbind.data.frame(Dataset=c("HF1", "HF2", "HF3", "HF4", "HF5"), dat.1)
colnames(dat.1)[c(2,4)] <- c("Species", "IMP-megahit")

dat.2 <- read.table("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/MT_genomes/HF_ref/Collinsella_intestinalis_DSM_13280-stats.tsv", header=T, na.strings="-")
dat.2 <- cbind.data.frame(Dataset=c("HF1", "HF2", "HF3", "HF4", "HF5"), dat.2)
colnames(dat.2)[c(2,4)] <- c("Species", "IMP-megahit")

dat <- rbind.data.frame(dat.1, dat.2)

## Visualize HF1 data

HF1.dat <- dat[which(dat$Dataset=="HF1"), which(colnames(dat)%in%c("Dataset", 
								     "Species", 
								     "IMP", "IMP-megahit", "MetAmos_MGMT", "MOCAT_MGMT", 
								     "IMP_MG", "MetAmos_MG", "MOCAT_MG", 
								     "IMP_MT"))]
m.HF1.dat <- melt(HF1.dat)
colnames(m.HF1.dat)[3:4] <- c("Assembly","value")

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/genome_recovery.pdf", width=5, height=2.5)
ggplot(m.HF1.dat, aes(x=Assembly, y=value, fill=Assembly)) + 
geom_bar(stat="identity", position="dodge") +
ylab("% recovery") +
facet_grid(.~Species) +
theme_bw() +
theme(legend.position="bottom",
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank()
      )
dev.off()

## Visualize all data for E coli
all.dat <- dat.1[, which(colnames(dat.1)%in%c("Dataset",
					  "IMP", "IMP-megahit", "MetAmos_MGMT", "MOCAT_MGMT", 
					  "IMP_MG", "MetAmos_MG", "MOCAT_MG", 
					  "IMP_MT"))]

m.dat <- melt(all.dat)
colnames(m.dat) <- c("Dataset", "Assembly","value")

png("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/genome_recovery-Supp-v2.png", 
    width=7.5, height=7.5, units='in', res=200)
ggplot(m.dat, aes(x=Assembly, y=value, fill=Assembly)) + 
geom_bar(stat="identity", position="dodge") + 
facet_grid(Dataset~.) +
ylab("Genome fraction (%)") +
theme_bw() +
theme(legend.position="none",
      axis.text.x=element_text(angle=45, hjust=1)
      )
dev.off()

write.table(dat, "/home/shaman/Documents/Publications/IMP-manuscript/tables/second_iteration/genome_recovery.tsv",
	    row.names=F, sep="\t", quote=F)

#save.image("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/MT_genomes/HF_ref/MT_genomes_new.Rdat")
#load("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/MT_genomes/HF_ref/MT_genomes_new.Rdat")

