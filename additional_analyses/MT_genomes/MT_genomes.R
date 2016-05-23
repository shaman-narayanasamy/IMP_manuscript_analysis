#!/bin/R
require(xtable)
require(genomeIntervals)
require(ggplot2)
require(gtable)
require(beanplot)
require(reshape)

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
####################################################################################################################
### Initialize all the data sets and the input folders
### This needs to be redone
samples <- c("SM", "HF1", "HF2", "HF3", "HF4", "HF5", "WW1", "WW2", "WW3", "WW4", "BG")
indir.flagstat <- "/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis"

### Read in all the data
for(i in seq_along(samples)){
  assign(paste(samples[i], "_IMP_MG_x_MGMT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "IMP", "/", "default", "/", "MG_reads-x-_MGMT-assm.flagstat.txt", sep="")
		       ))
}
####################################################################################################################

A02.MG <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/A02_20150725/Analysis/MG.gene_depth.avg"
A02.MT <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/A02_20150725/Analysis/MT.gene_depth.avg"
A02.wkspc <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/A02_20150725/Analysis/results/MGMT_results.Rdat"

D36.MG <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/D36_20150827/Analysis/MG.gene_depth.avg"
D36.MT <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/D36_20150827/Analysis/MT.gene_depth.avg"
D36.wkspc <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/D36_20150827/Analysis/results/MGMT_results.Rdat"

X310763260.MG <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/X310763260_20150728/Analysis/MG.gene_depth.avg"
X310763260.MT <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/X310763260_20150728/Analysis/MT.gene_depth.avg"
X310763260.wkspc <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/X310763260_20151004-idba/Analysis/results/MGMT_results.Rdat"

## Get genes only expressed in MT data sets
dat <- get_expressed(X310763260.MG, X310763260.MT, X310763260.wkspc)
MT_only <-  dat[dat$MG_depth==0,]
write.table(MT_only, "/home/shaman/Work/repository/IMP-manuscript/tables/X310763260_MT_only.csv", row.names=F, sep="\t", quote=F)

dat <- get_expressed(X310763260.MG, X310763260.MT, X310763260.wkspc)
MT_only <-  dat[dat$MG_depth==0,]
write.table(MT_only, "/home/shaman/Work/repository/IMP-manuscript/tables/X310763260_MT_only.tsv", row.names=F, sep="\t", quote=F)

dat <- get_expressed(A02.MG, A02.MT, A02.wkspc)
MT_only <-  dat[dat$MG_depth==0,]
write.table(MT_only, "/home/shaman/Work/repository/IMP-manuscript/tables/A02_MT_only.tsv", row.names=F, sep="\t", quote=F)

dat <- get_expressed(D36.MG, D36.MT, D36.wkspc)
MT_only <-  dat[dat$MG_depth==0,]
write.table(MT_only, "/home/shaman/Work/repository/IMP-manuscript/tables/D36_MT_only.tsv", row.names=F, sep="\t", quote=F)

## Get genes only expressed in MT data sets and on MT only contigs
dat <- get.MT.genes(X310763260.MG, X310763260.MT, X310763260.wkspc)
dat.MT <- dat[is.na(dat$MG_contig_depth) & dat$contig_len >= 500, c(5,1,2,4,6,8,9)]
sink("/home/shaman/Work/repository/IMP-manuscript/tables/X310763260_MT_contigs.tex")
print(xtable(dat.MT[,c(1:3)]), floating=F, include.rownames=F)
sink()

dat <- get.MT.genes(A02.MG, A02.MT, A02.wkspc)
dat.MT <- dat[is.na(dat$MG_contig_depth) & dat$contig_len >= 500, c(5,1,2,4,6,8,9)]
sink("/home/shaman/Work/repository/IMP-manuscript/tables/A02_MT_contigs.tex")
print(xtable(dat.MT[,c(1:3)]), floating=F, include.rownames=F)
sink()

dat <- get.MT.genes(D36.MG, D36.MT, D36.wkspc)
dat.MT <- dat[is.na(dat$MG_contig_depth) & dat$contig_len >= 500, c(5,1,2,4,6,8,9)]
sink("/home/shaman/Work/repository/IMP-manuscript/tables/D36_MT_contigs.tex")
print(xtable(dat.MT[,c(1:3)]), floating=F, include.rownames=F)
sink()

##### Analysis of MT contigs in human microbiome data set aligning to Ecoli
load(X310763260.wkspc)
source("~/Work/repository/IMP/src/IMP_plot_functions.R")

logDepth_label <- expression(bold(paste(log[10], depth)))
depthRatio_label <- expression(bold(paste(log[10], frac(depth[MT], depth[MG]))))
alignmentLen_label <- expression(bold(paste(log[10], " ", "(", alignment, " ", length, ")")))
contigLen_label <- expression(bold(paste(log[10], " ", "(", contig, " ", length, ")")))
short_labels  <- list(expression(paste(italic(C.~intestinalis))), 
		   expression(paste(italic(E.~coli)))
		   )

dat <- unique(all.dat[,c("contig","MG_depth", "MT_depth", "ref_id")])
dat$log_MG_depth <- log10(dat$MG_depth)
dat$log_MG_depth[is.infinite(dat$log_MG_depth)]=NA

dat$log_MT_depth <- log10(dat$MT_depth)
dat$log_MT_depth[is.infinite(dat$log_MT_depth)]=NA
m.dat <- melt(dat[,c("ref_id","log_MG_depth","log_MT_depth")])

m.dat.2 <- rbind(
      cbind(m.dat, 
      which = rep("all", nrow(m.dat))),

      cbind(m.dat[which(m.dat$ref_id=="Collinsella_intestinalis_DSM_13280"),],
      which = rep(short_labels[1], length(which(m.dat$ref_id=="Collinsella_intestinalis_DSM_13280")))),

      cbind(m.dat[which(m.dat$ref_id=="Escherichia_coli_P12b"),],
      which = rep(short_labels[2], length(which(m.dat$ref_id=="Escherichia_coli_P12b"))))
)

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/beanplot_comparison.pdf", 
    width=25, height=25)
par(mar=c(5.1,10,4.1,2.1))
beanplot(value ~ variable*which,
	 data = m.dat.2,
	 side = "both",
	 log = "auto",
	 bw = "nrd0",
	 what = c(1,1,1,0),
	 col = list("blue", c("red", "white")),
	 border = NA,
	 ylim = c(-2.5,2.5),
	 ylab = logDepth_label,
	 cex.axis = 3,
	 cex.lab = 4,
	 show.names = FALSE,
	 frame.plot = FALSE
	 )
axis(1, at=c(1,2,3), labels=c(expression(paste(bolditalic(all))), 
			      expression(paste(bolditalic(C.~intestinalis))),
			      expression(paste(bolditalic(E.~coli)))
			      ), 
     pos=-2, cex.axis=3, font = 2, las=2)
legend("bottomleft", fill = c("blue", "red"), legend = c("MG", "MT"), cex = 4, box.lwd = 0)
dev.off()

png("/home/shaman/Documents/Publications/IMP-manuscript/figures/IMP-vizbin_vs_Ecoli.png", 
    width=1500, height=1200)
ggplot(vb_dat, aes(x=x, y=y)) + 
geom_point(aes(size=log10(length)), colour="gray85", alpha=0.5) +
geom_point(data=rbind(vb_dat[which(vb_dat$ref_id == "Escherichia_coli_P12b"),],
	   vb_dat[which(vb_dat$ref_id == "Collinsella_intestinalis_DSM_13280"),])
	   , aes(x=x, y=y, 
		 size=log10(length), 
		 fill=log_depth_ratio, 
		 colour=ref_id,
		 shape=ref_id)
	   ) +
		 scale_size_continuous("log10(length)", range = c(3,30)) +
		 scale_shape_manual(values=c(24, 22), 
				    labels=short_labels) +
		 scale_fill_gradient(low="blue", high="red") +
		 scale_colour_manual(values=c("green", "black"),
				     labels=short_labels
				     ) +
		 guides(size=guide_legend(title=contigLen_label),
			fill=guide_colourbar(title=depthRatio_label),
			shape=guide_legend(title="Taxa"
					   ),
			colour=guide_legend(title="Taxa", 
					   override.aes = list(size=10)
					   )
			) + 
theme_nothing()
dev.off()

###

# Check no. of reads constituting E. coli
ecoli.reads <- colSums(unique(all.dat[grep("Escherichia_coli_P12b", all.dat$ref_id),c(3,6)])) 
cintest.reads <- colSums(unique(all.dat[grep("Collinsella_intestinalis_DSM_13280", all.dat$ref_id),c(3,6)])) 

# Check no. of reads constituting C. intestinalis
all.reads <- colSums(unique(all.dat[,c(1,3,6)])[,-1]) 

ecoli.reads/all.reads * 100
cintest.reads/all.reads * 100

