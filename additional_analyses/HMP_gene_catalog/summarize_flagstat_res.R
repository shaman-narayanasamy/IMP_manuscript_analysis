## Reading in the flagstat files
require(reshape2)
require(ggplot2)
require(gplots)

### Function: Read in and process flagstat data
read.flagstat <- function(flagstat.file){
dat <- cbind.data.frame( 
	     c(
	    "total",
	    "duplicates",
	    "mapped",
	    "paired_in_seq",
	    "read1",
	    "read2",
	    "properly_paired",
	    "itself_mate",
	    "singletons",
	    "mate_diff_chr",
	    "mate_diff_chr(mapq5)"
	    ), 
	  as.numeric(read.delim(flagstat.file, 
				header=F, sep=" ", stringsAsFactors=F)[-12,1])
    )
colnames(dat) <- c("reads", "count")
as.numeric(dat$count)

dat <- cbind.data.frame(dat, fraction=round(dat$count / dat[1,2] * 100, digits=2))
return(dat)
}

### Read in flagstat data
samples <- c("HF1", "HF2", "HF3", "HF4", "HF5")
indir.flagstat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/HMP_IGC_mapping"

#####################################################################################################################################
### IMP
#####################################################################################################################################
## MG data mapping to IGC
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MG_IMP_x_HMP", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MG_", "IMP_", "x_", "HMP.sorted_flagstat.txt", sep="")
		       ))
}

## MT data mapping to IGC
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MT_IMP_x_HMP", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MT_", "IMP_", "x_", "HMP.sorted_flagstat.txt", sep="")
		       ))
}

#####################################################################################################################################
### MOCAT
#####################################################################################################################################
## MG data mapping to IGC
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MG_MOCAT_x_HMP", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MG_", "MOCAT_", "x_", "HMP.sorted_flagstat.txt", sep="")
		       ))
}

## MT data mapping to IGC
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MT_MOCAT_x_HMP", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MT_", "MOCAT_", "x_", "HMP.sorted_flagstat.txt", sep="")
		       ))
}

#####################################################################################################################################
### metAmos
#####################################################################################################################################
## MG data mapping to IGC
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MG_metAmos_x_HMP", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MG_", "metAmos_", "x_", "HMP.sorted_flagstat.txt", sep="")
		       ))
}

## MT data mapping to IGC
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MT_metAmos_x_HMP", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MT_", "metAmos_", "x_", "HMP.sorted_flagstat.txt", sep="")
		       ))
}

assms <- c("IMP_IGC", "MOCAT_IGC", "MetAmos_IGC")

#####################################################################################################################################
### HF1 data summary
#####################################################################################################################################

HF1.reads <- 
rbind.data.frame(
		cbind.data.frame(rep("HF1", 3), assms,
		## MG total mapped
		c(
		  HF1_MG_IMP_x_HMP$fraction[3],
		  HF1_MG_MOCAT_x_HMP$fraction[3],
		  HF1_MG_metAmos_x_HMP$fraction[3]
		),
		## MG properly paired
		c(
		  HF1_MG_IMP_x_HMP$fraction[[7]],
		  HF1_MG_MOCAT_x_HMP$fraction[[7]],
		  HF1_MG_metAmos_x_HMP$fraction[[7]]
		),
	
		## MT total mapped
		c(
		  HF1_MT_IMP_x_HMP$fraction[3],
		  HF1_MT_MOCAT_x_HMP$fraction[3],
		  HF1_MT_metAmos_x_HMP$fraction[3]
		),
		## MT properly paired
		c(
		  HF1_MT_IMP_x_HMP$fraction[[7]],
		  HF1_MT_MOCAT_x_HMP$fraction[[7]],
		  HF1_MT_metAmos_x_HMP$fraction[[7]]
		)
)
)

colnames(HF1.reads) <- c("Dataset", "Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### HF2 data summary
#####################################################################################################################################

HF2.reads <- 
rbind.data.frame(
		cbind.data.frame(rep("HF2", 3), assms,
		## MG total mapped
		c(
		  HF2_MG_IMP_x_HMP$fraction[3],
		  HF2_MG_MOCAT_x_HMP$fraction[3],
		  HF2_MG_metAmos_x_HMP$fraction[3]
		),
		## MG properly paired
		c(
		  HF2_MG_IMP_x_HMP$fraction[[7]],
		  HF2_MG_MOCAT_x_HMP$fraction[[7]],
		  HF2_MG_metAmos_x_HMP$fraction[[7]]
		),
	
		## MT total mapped
		c(
		  HF2_MT_IMP_x_HMP$fraction[3],
		  HF2_MT_MOCAT_x_HMP$fraction[3],
		  HF2_MT_metAmos_x_HMP$fraction[3]
		),
		## MT properly paired
		c(
		  HF2_MT_IMP_x_HMP$fraction[[7]],
		  HF2_MT_MOCAT_x_HMP$fraction[[7]],
		  HF2_MT_metAmos_x_HMP$fraction[[7]]
		)
)
)

colnames(HF2.reads) <- c("Dataset", "Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### HF3 data summary
#####################################################################################################################################

HF3.reads <- 
rbind.data.frame(
		cbind.data.frame(rep("HF3", 3), assms,
		## MG total mapped
		c(
		  HF3_MG_IMP_x_HMP$fraction[3],
		  HF3_MG_MOCAT_x_HMP$fraction[3],
		  HF3_MG_metAmos_x_HMP$fraction[3]
		),
		## MG properly paired
		c(
		  HF3_MG_IMP_x_HMP$fraction[[7]],
		  HF3_MG_MOCAT_x_HMP$fraction[[7]],
		  HF3_MG_metAmos_x_HMP$fraction[[7]]
		),
	
		## MT total mapped
		c(
		  HF3_MT_IMP_x_HMP$fraction[3],
		  HF3_MT_MOCAT_x_HMP$fraction[3],
		  HF3_MT_metAmos_x_HMP$fraction[3]
		),
		## MT properly paired
		c(
		  HF3_MT_IMP_x_HMP$fraction[[7]],
		  HF3_MT_MOCAT_x_HMP$fraction[[7]],
		  HF3_MT_metAmos_x_HMP$fraction[[7]]
		)
)
)

colnames(HF3.reads) <- c("Dataset", "Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### HF4 data summary
#####################################################################################################################################

HF4.reads <- 
rbind.data.frame(
		cbind.data.frame(rep("HF4", 3), assms,
		## MG total mapped
		c(
		  HF4_MG_IMP_x_HMP$fraction[3],
		  HF4_MG_MOCAT_x_HMP$fraction[3],
		  HF4_MG_metAmos_x_HMP$fraction[3]
		),
		## MG properly paired
		c(
		  HF4_MG_IMP_x_HMP$fraction[[7]],
		  HF4_MG_MOCAT_x_HMP$fraction[[7]],
		  HF4_MG_metAmos_x_HMP$fraction[[7]]
		),
	
		## MT total mapped
		c(
		  HF4_MT_IMP_x_HMP$fraction[3],
		  HF4_MT_MOCAT_x_HMP$fraction[3],
		  HF4_MT_metAmos_x_HMP$fraction[3]
		),
		## MT properly paired
		c(
		  HF4_MT_IMP_x_HMP$fraction[[7]],
		  HF4_MT_MOCAT_x_HMP$fraction[[7]],
		  HF4_MT_metAmos_x_HMP$fraction[[7]]
		)
)
)

colnames(HF4.reads) <- c("Dataset", "Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### HF5 data summary
#####################################################################################################################################

HF5.reads <- 
rbind.data.frame(
		cbind.data.frame(rep("HF5", 3), assms,
		## MG total mapped
		c(
		  HF5_MG_IMP_x_HMP$fraction[3],
		  HF5_MG_MOCAT_x_HMP$fraction[3],
		  HF5_MG_metAmos_x_HMP$fraction[3]
		),
		## MG properly paired
		c(
		  HF5_MG_IMP_x_HMP$fraction[[7]],
		  HF5_MG_MOCAT_x_HMP$fraction[[7]],
		  HF5_MG_metAmos_x_HMP$fraction[[7]]
		),
	
		## MT total mapped
		c(
		  HF5_MT_IMP_x_HMP$fraction[3],
		  HF5_MT_MOCAT_x_HMP$fraction[3],
		  HF5_MT_metAmos_x_HMP$fraction[3]
		),
		## MT properly paired
		c(
		  HF5_MT_IMP_x_HMP$fraction[[7]],
		  HF5_MT_MOCAT_x_HMP$fraction[[7]],
		  HF5_MT_metAmos_x_HMP$fraction[[7]]
		)
)
)

colnames(HF5.reads) <- c("Dataset", "Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

## Join all the dat
HMP.mapped <- rbind(HF1.reads, HF2.reads, HF3.reads, HF4.reads, HF5.reads)
colnames(HMP.mapped) <- c("Dataset", "Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#levels(HMP.mapped$Assembly) <- c(levels(HMP.mapped$Assembly), "IMP-megahit")
#
#tmp <- HMP.mapped[HMP.mapped$Assembly=="IMP",]
#tmp$Assembly= c(rep("IMP-megahit", nrow(tmp)))
#HMP.mapped <- rbind(HMP.mapped, tmp)

## read table from comparison
all.dat <- read.delim("/home/shaman/Documents/Publications/IMP-manuscript/tables/second_iteration/all_comparison.tsv")

hf.dat <- all.dat[all.dat$Dataset%in%samples, c(1:2,28:31)]
all.mapped <- all.dat[, c(1:2,28:31)]

all.hf.mapped <- rbind(HMP.mapped, all.mapped)
all.hf.mapped <- all.hf.mapped[order(all.hf.mapped$Dataset, all.hf.mapped$Assembly),]
m.dat <- melt(all.hf.mapped)
m.dat <- m.dat[-which(m.dat$Assembly%in%c("MetAmos_MGMT", "MOCAT_MGMT", "MetAmos_MT", "MOCAT_MT", "MetAmos_IGC", "MOCAT_IGC")),]

m.dat <- m.dat[m.dat$variable%in%c("MG_properly_paired", "MT_properly_paired"),]
levels(m.dat$Assembly)[match("IMP_IGC", levels(m.dat$Assembly))] <- "IGC"

#merge(hf.dat, HMP.mapped, by=c("Dataset", "Assembly"))

ggplot(m.dat, aes(x=Assembly, y=log(value), fill=variable)) + 
geom_bar(stat="identity", position="dodge") + 
scale_fill_manual(values=c("blue", "red", "lightblue", "salmon")) +
facet_grid(Dataset ~ .) 

heatmap.2(as.matrix(all.hf.mapped[,-c(1:2)]), scale="none", dendrogram="none", labRow=as.character(all.hf.mapped$Assembly))

### Plot MG and MT mapping separately
row.sort <- c("SM", "HF1", "HF2", "HF3", "HF4", "HF5", "WW1", "WW2", "WW3", "WW4", "BG")
#col.sort <- c("IMP", "IMP-megahit", "IMP_MG", "MOCAT_MG", "MetAmos_MG", "IMP_MT", "IGC")
#col.sort <- c("IMP", "IMP-megahit", "IMP_MG", "MOCAT_MG", "MetAmos_MG", "IGC")
col.sort <- c("IMP", "IMP-megahit", "IMP_MG", "MOCAT_MG", "MetAmos_MG")
#annot.cols <- c(rep("purple", 2), rep("darkblue", 3), "darkred", "black" )
annot.cols <- c(rep("purple", 2), rep("darkblue", 3))

### Plot MG reads mapping
MG.mapped <- acast(m.dat[m.dat$variable=="MG_properly_paired",-3], Dataset~Assembly)
MG.mapped <- MG.mapped[row.sort,col.sort]
colnames(MG.mapped)[5] <- "MetAMOS_MG"

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/MG_mapping-v5.pdf")
heatmap.2(as.matrix(MG.mapped), scale="row", dendrogram="none", 
	  col=colorRampPalette(c("white", "blue", "darkblue"), space="rgb"), na.color="gray25",
	  trace="none",
	  Rowv=F, Colv=F,
	  ColSideColors=annot.cols,
	  density.info="none",
	  cexRow=2,
	  cexCol=2
	  )
dev.off()

### Plot MT reads mapping
MT.mapped <- acast(m.dat[m.dat$variable=="MT_properly_paired",-3], Dataset~Assembly)
MT.mapped <- MT.mapped[row.sort,col.sort]
colnames(MT.mapped)[5] <- "MetAMOS_MG"

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/MT_mapping-v5.pdf")
heatmap.2(as.matrix(MT.mapped), scale="row", dendrogram="none", 
	  col=colorRampPalette(c("white", "red", "darkred"), space="rgb"), na.color="gray25",
	  trace="none",
	  Rowv=F, Colv=F,
          ColSideColors=annot.cols,
	  density.info="none",
	  cexRow=2,
	  cexCol=2
	  )
dev.off()

### Plot contigs and genes
m.all <- melt(all.dat)
m.all <- m.all[-which(m.all$Assembly%in%c("MetAmos_MGMT", "MOCAT_MGMT", "MetAmos_MT", "MOCAT_MT", "MetAmos_IGC", "MOCAT_IGC")),]
m.all <- m.all[m.all$variable%in%c("contigs.1000.bp.", "predicted.genes..unique."),]

### Plot contigs 
contigs <- acast(m.all[m.all$variable=="contigs.1000.bp.",-3], Dataset~Assembly)
contigs <- contigs[row.sort,col.sort[-length(col.sort)]]
colnames(contigs)[5] <- "MetAMOS_MG"

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/noContigs-v3.pdf")
heatmap.2(as.matrix(contigs), scale="row", dendrogram="none", 
	  col=colorRampPalette(c("white", "green", "darkgreen"), space="rgb"), na.color="gray25",
	  trace="none",
	  Rowv=F, Colv=F,
          ColSideColors=annot.cols[-length(annot.cols)],
	  density.info="none",
	  cexRow=2,
	  cexCol=2
	  )
dev.off()

### Plot genes
genes <- acast(m.all[m.all$variable=="predicted.genes..unique.",-3], Dataset~Assembly)
genes <- genes[row.sort,col.sort[-length(col.sort)]]
colnames(genes)[5] <- "MetAMOS_MG"

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/noGenes-v3.pdf")
heatmap.2(as.matrix(genes), scale="row", dendrogram="none", 
	  col=colorRampPalette(c("white", "magenta", "darkmagenta"), space="rgb"), na.color="gray25",
	  trace="none",
	  Rowv=F, Colv=F,
          ColSideColors=annot.cols[-length(annot.cols)],
	  density.info="none",
	  cexRow=2,
	  cexCol=2
	  )
legend("top", 
       legend = c("Co-assembly", "MG assembly", "MT assembly", "Reference"),
       col = unique(annot.cols),
       lty= 1,             
       lwd = 8,           
       cex= 1
    )
dev.off()



all.dat.2 <- merge(all.dat, HMP.mapped, by=c("Dataset", "Assembly", "MG_mapped", "MG_properly_paired", 
					     "MT_mapped", "MT_properly_paired"), all=T)
all.dat.3 <- all.dat.2[-which(all.dat.2$Assembly%in%c("IMP_MT", "MetAmos_MT", "MOCAT_MT", 
						      "MetAmos_IGC", "MOCAT_IGC")),
				 -which(colnames(all.dat.2)%in%c("MG_mapped", "MT_mapped"))]

write.table(all.dat.3, "/home/shaman/Documents/Publications/IMP-manuscript/tables/second_iteration/all_comparison-v3.tsv", sep="\t", quote=F, row.names=F)

#save.image("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/HMP_IGC_mapping/HMP_IGC_mapping.Rdat")
#load("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/HMP_IGC_mapping/HMP_IGC_mapping.Rdat")

