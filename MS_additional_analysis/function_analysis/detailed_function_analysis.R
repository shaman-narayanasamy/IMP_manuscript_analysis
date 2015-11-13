#!/bin/R
require(xtable)
require(genomeIntervals)
require(ggplot2)
require(gtable)
require(beanplot)

get_expressed <- function(MG.file, MT.file, workspace){
	# Read metagenomic depth of coverage table
	mg.dat <- read.table(MG.file)
	# Read metatranscriptomic depth of coverage table
	mt.dat <- read.table(MT.file)

        load(workspace)

	ID2function <- getGffAttribute(annot, c("ID", "product"))

        # Change column names
	colnames(mg.dat) <- c("ID", "MG_depth")
	colnames(mt.dat) <- c("ID", "MT_depth")
        
        # Merge data	
	dat <- merge(mg.dat, mt.dat, by="ID", incomparables=0)
	dat <- merge(dat, ID2function, by="ID", incomparables=0)

	return(dat)

}

get.MT.genes <- function(MG.file, MT.file, workspace){
    load(workspace)
    dat1 <- get_expressed(MG.file, MT.file, workspace)
    MT_only <-  dat1[dat1$MG_depth==0,]

    dat2 <- as.data.frame(cbind(as.character(attr(annot, "annotation")$seq_name), getGffAttribute(annot, c("ID", "product"))))
    colnames(dat2)[1] <- "contig"
    dat2 <- merge(dat2, all.dat, incomparables="NA")

    dat2 <- dat2[,c(1,2,3,4,12,13,30)]
    colnames(dat2)[4:6] <- c("contig_len", "MG_contig_depth", "MT_contig_depth")

    dat <- merge(MT_only, dat2, by=c("ID", "product"))
    dat <- unique(dat)
    #dat <- dat[is.na(dat$MG_contig_depth),]
    return(dat)
}


A02.MG <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/A02_20151006-idba/Analysis/MG.gene_depth.avg"
A02.MT <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/A02_20151006-idba/Analysis/MT.gene_depth.avg"
A02.wkspc <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/A02_20151006-idba/Analysis/results/MGMT_results.Rdat"

D36.MG <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/D36_20151007-idba/Analysis/MG.gene_depth.avg"
D36.MT <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/D36_20151007-idba/Analysis/MT.gene_depth.avg"
D36.wkspc <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/D36_20151007-idba/Analysis/results/MGMT_results.Rdat"

X310763260.MG <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/X310763260_20151004-idba/Analysis/MG.gene_depth.avg"
X310763260.MT <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/X310763260_20151004-idba/Analysis/MT.gene_depth.avg"
X310763260.wkspc <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/X310763260_20151004-idba/Analysis/results/MGMT_results.Rdat"


## Get genes only expressed in MT data sets
dat <- get_expressed(X310763260.MG, X310763260.MT, X310763260.wkspc)
MT_only <-  dat[dat$MG_depth==0,]
write.table(MT_only, "/home/shaman/Documents/Publications/IMP-manuscript/tables/X310763260_MT_only.csv", row.names=F, sep="\t", quote=F)

dat <- get_expressed(X310763260.MG, X310763260.MT, X310763260.wkspc)
MT_only <-  dat[dat$MG_depth==0,]
write.table(MT_only, "/home/shaman/Documents/Publications/IMP-manuscript/tables/X310763260_MT_only.tsv", row.names=F, sep="\t", quote=F)

dat <- get_expressed(A02.MG, A02.MT, A02.wkspc)
MT_only <-  dat[dat$MG_depth==0,]
write.table(MT_only, "/home/shaman/Documents/Publications/IMP-manuscript/tables/A02_MT_only.tsv", row.names=F, sep="\t", quote=F)

dat <- get_expressed(D36.MG, D36.MT, D36.wkspc)
MT_only <-  dat[dat$MG_depth==0,]
write.table(MT_only, "/home/shaman/Documents/Publications/IMP-manuscript/tables/D36_MT_only.tsv", row.names=F, sep="\t", quote=F)

## Get genes only expressed in MT data sets and on MT only contigs

dat <- get.MT.genes(X310763260.MG, X310763260.MT, X310763260.wkspc)
dat.MT <- dat[is.na(dat$MG_contig_depth) & dat$contig_len >= 500, 
	      c("contig", "contig_len", "MT_contig_depth", "ID", "product", "MT_depth")]
write.table(dat.MT, "/home/shaman/Documents/Publications/IMP-manuscript/tables/X310763260_MT_contigs.tsv", 
	    sep = "\t", quote = FALSE, row.names = FALSE)

dat <- get.MT.genes(A02.MG, A02.MT, A02.wkspc)
dat.MT <- dat[is.na(dat$MG_contig_depth) & dat$contig_len >= 500, 
	      c("contig", "contig_len", "MT_contig_depth", "ID", "product", "MT_depth")]
write.table(dat.MT, "/home/shaman/Documents/Publications/IMP-manuscript/tables/A02_MT_contigs.tsv", 
	    sep = "\t", quote = FALSE, row.names = FALSE)

dat <- get.MT.genes(D36.MG, D36.MT, D36.wkspc)
dat.MT <- dat[is.na(dat$MG_contig_depth) & dat$contig_len >= 500, 
	      c("contig", "contig_len", "MT_contig_depth", "ID", "product", "MT_depth")]
write.table(dat.MT, "/home/shaman/Documents/Publications/IMP-manuscript/tables/D36_MT_contigs.tsv", 
	    sep = "\t", quote = FALSE, row.names = FALSE)

