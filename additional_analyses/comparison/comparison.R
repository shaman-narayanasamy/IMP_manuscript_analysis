#!/bin/R

require(fmsb)
require(ggplot2)
require(grDevices)
library(dplyr)
library(plyr)
library(tidyr)
library(graphics)
library(cowplot)
library(stringr)

### Load data usage workspace
#load("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/comparison/data_usage/data_usage.Rdat")

######################################################################################################
##### Initialize functions
######################################################################################################
### FUNCTION: Create colours with transparency ###
makeTransparent = function(..., alpha=0.5) {

  if(alpha<0 | alpha>1) stop("alpha must be between 0 and 1")

  alpha = floor(255*alpha)  
  newColor = col2rgb(col=unlist(list(...)), alpha=FALSE)

  .makeTransparent = function(col, alpha) {
    rgb(red=col[1], green=col[2], blue=col[3], alpha=alpha, maxColorValue=255)
  }

  newColor = apply(newColor, 2, .makeTransparent, alpha=alpha)

  return(newColor)

}

###############################################################################################################################
### FUNCTION: 6-axis radar chart
plot.7axis <- function(dat, cols, dens, font, linetype, 
			     fsize, linewd, mcex, lwd, plwd, title = "") {
dat <- dat[,c("Assembly", 
       "contigs 1000.bp.", 
       "N50", 
       "predicted.genes..unique.",
       "Genome.fraction....",
       "MG_properly_paired",
       "MT_properly_paired",
       "CPM"
       )]

colnames(dat) = c("Assembly", "contigs \u2265 1kb", 
		  "N50 length", "no. of genes",  
		  "genome fraction (%)", "MG properly paired", 
		  "MT properly paired", "CPM")

dat$Assembly <- factor(dat$Assembly, levels=c(as.character(dat$Assembly), "max", "min")) 

dat <- rbind(
	     c("max", apply(dat[, 2:ncol(dat)], 2, max)), 
	     c("min", apply(dat[, 2:ncol(dat)], 2, min)), 
	     dat)

dat[,2:ncol(dat)] <- sapply(dat[,2:ncol(dat)], as.numeric)
	     
# Calculate maximum and minimum for positive values
dat[1, !names(dat) %in% c("Assembly")] <- 
    dat[1, !names(dat) %in% c("Assembly")] * 1.025
dat[2, !names(dat) %in% c("Assembly")] <- 
    dat[2, !names(dat) %in% c("Assembly")] * 0.75

# Set min and max for percentages
dat[1, names(dat) %in% c("genome fraction (%)")] <- 100
dat[2, names(dat) %in% c("genome fraction (%)")] <- 0

dat[1, names(dat) %in% c("MG properly paired")] <- 100
dat[2, names(dat) %in% c("MG properly paired")] <- 0

dat[1, names(dat) %in% c("MT properly paired")] <- 100
dat[2, names(dat) %in% c("MT properly paired")] <- 0

par(mar=c(0,0,8,0)) 
radarchart(dat[,-1], pcol=cols, pfcol=dens, plty=linetype, plwd=plwd,
	   cglwd=lwd, palcex=font, calcex=font, vlcex=font, cglcol="darkgray",
	   paxislabels = c("Assembly", "contigs \u2265 1kb", "N50 length", 
			   "no. of genes",
			   "genome fraction (%)", 
			   "MG mapped", "MG properly paired", 
			   "MT mapped", "MT properly paired",
			   "CPM"),
	   oma=c(0,0,0,0))#, title = title, cex.main = 6)
title(title, outer = FALSE, line = 2, font = 2, cex.main = 7.5)
}

###############################################################################################################################
### FUNCTION: 5-axis radar chart
plot.5axis <- function(dat, cols, dens, font, linetype, 
			     fsize, linewd, mcex, lwd, plwd, title = "") {
dat <- dat[,c("Assembly", 
       "X..contigs.....1000.bp.", 
       "N50", 
       "X..predicted.genes..unique.",
       "MG_properly_paired",
       "MT_properly_paired"
       )]

colnames(dat)  <- c("Assembly", "contigs \u2265 1kb", "N50 length", 
		    "no. of genes", "MG properly paired", "MT properly paired")

dat$Assembly <- factor(dat$Assembly, levels=c(as.character(dat$Assembly), "max", "min")) 
dat <- rbind(
	     c("max", apply(dat[, 2:ncol(dat)], 2, max)), 
	     c("min", apply(dat[, 2:ncol(dat)], 2, min)), 
	     dat)

dat[,2:ncol(dat)] <- sapply(dat[,2:ncol(dat)], as.numeric)
	     
# Calculate maximum and minimum for positive values
dat[1, !names(dat) %in% c("Assembly")] <- 
    dat[1, !names(dat) %in% c("Assembly")] * 1.025
dat[2, !names(dat) %in% c("Assembly")] <- 
    dat[2, !names(dat) %in% c("Assembly")] * 0.75

dat[1, names(dat) %in% c("MG properly paired")] <- 100
dat[2, names(dat) %in% c("MG properly paired")] <- 0

dat[1, names(dat) %in% c("MT properly paired")] <- 100
dat[2, names(dat) %in% c("MT properly paired")] <- 0

par(mar=c(0,0,8,0)) 
radarchart(dat[,-1], pcol=cols, pfcol=dens, plty=linetype, plwd=plwd,
	   cglwd=lwd, palcex=font, calcex=font, vlcex=font, cglcol="darkgray",
	   paxislabels = c("Assembly", "contigs \u2265 1kb", "N50 length", "no. of genes", 
			   "MG mapped", "MG properly paired", "MT mapped", "MT properly paired"),
	   oma=c(0,0,0,0))#, title = title, cex.main = 6)
title(title, outer = FALSE, line = 2, font = 2, cex.main = 7.5)
}


indir <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/metaquast_output/"
samples <- c("SM", "HF1", "HF2", "HF3", "HF4", "HF5", "WW1", "WW2", "WW3", "WW4", "BG")

for(i in seq_along(samples)){
   dat1 <- read.delim(paste(indir, "/", samples[i],  "/", "transposed_report.tsv", sep=""), header=T, stringsAsFactors=F) 
   dat2 <- get(paste(samples[i], "reads", sep="."))
   dat <- merge(dat1, dat2, by = "Assembly")


   assign(paste(samples[i], "_quast", sep=""), dat )
   rm(dat, dat1, dat2)
}

assm_mgmt <- c("IMP","IMP-megahit","MOCAT_MGMT","MetAmos_MGMT")

cols <- makeTransparent("darkred", "darkblue", "darkgreen", "darkorange2", alpha=0.75)
dens <- makeTransparent("red", "blue", "green", "orange", alpha=0.10)
font=10
linetype <- c(1,1,2,2)
fsize=10
linewd=15
mcex=8
lwd=16
plwd=15


pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/HF1_radarChart_v6.pdf", 
    width=38, height=25)
plot.5axis(HF1_quast[HF1_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/HF2_radarChart_v6.pdf", 
    width=38, height=25)
plot.5axis(HF2_quast[HF2_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/HF3_radarChart_v6.pdf", 
    width=38, height=25)
plot.5axis(HF3_quast[HF3_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/HF4_radarChart_v6.pdf", 
    width=38, height=25)
plot.5axis(HF4_quast[HF4_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/HF5_radarChart_v6.pdf", 
    width=38, height=25)
plot.5axis(HF5_quast[HF5_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/WW1_radarChart_v6.pdf", 
    width=38, height=25)
plot.5axis(WW1_quast[WW1_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/WW2_radarChart_v6.pdf", 
    width=38, height=25)
plot.5axis(WW2_quast[WW2_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/WW3_radarChart_v6.pdf", 
    width=38, height=25)
plot.5axis(WW3_quast[WW3_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/WW4_radarChart_v6.pdf", 
    width=38, height=25)
plot.5axis(WW4_quast[WW4_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/BG_radarChart_v6.pdf", 
    width=38, height=25)
plot.5axis(BG_quast[BG_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

### Prepare complete table
all.dat <- cbind.data.frame(dataset=rep(samples[1],nrow(SM_quast)), SM_quast[,colnames(SM_quast)%in%colnames(HF1_quast)])
samples_1 <- samples[-1]

for(i in seq_along(samples_1)){ 
    dat.now <- get(paste(samples_1[i], "_quast", sep=""))
    all.dat <- rbind.data.frame(all.dat, 
				cbind.data.frame(
						 dataset=rep(samples_1[i], nrow(dat.now)), 
						 dat.now[,colnames(dat.now)%in%colnames(all.dat)]
						 )
				)
}

ref.dat <- SM_quast[,!colnames(SM_quast)%in%colnames(all.dat)]


## Generate legend for figure
legend_labels <- c("IMP","IMP-megahit","MOCAT_MGMT","MetAMOS_MGMT")

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/radarChart_legend_v6.pdf", 
    width=45, height=25)
plot(1, type="n", axes=FALSE, xlab="", ylab="")
legend("bottom", legend=legend_labels, xpd = TRUE, horiz = TRUE,
       bty = "o", col = cols, lty=linetype,
       lwd = c(8,8,8,8), cex = 5, box.lty=1, box.lwd=0,
       box.col="gray", text.col=cols, text.font=c(2,2,2,2))
dev.off()

### Write out table
empty <- as.data.frame(matrix(NA,100,ncol(ref.dat)))
colnames(empty) <- colnames(ref.dat)
ref.dat <- rbind.data.frame(ref.dat, empty)
all.dat <- cbind.data.frame(all.dat, ref.dat)
colnames(all.dat) <- gsub("X..", "", colnames(all.dat))
colnames(all.dat) <- gsub("\\.\\.\\.\\.\\.", " ", colnames(all.dat))
colnames(all.dat)[1] <- "Dataset"

write.table(as.data.frame(all.dat), "/home/shaman/Documents/Publications/IMP-manuscript/tables/second_iteration/all_comparison_v2.tsv",  
	    row.names=F, quote=F, sep = "\t")

#save.image("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/comparison/data_usage/comparison.Rdat")
#load("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/comparison/data_usage/comparison.Rdat")

### Obtain composite performance metric (CPM) from data
sm.dat <- subset(all.dat, Dataset=="SM")

cpm.dat <- cbind.data.frame(str_split_fixed(sm.dat$unaligned.contigs, " \\+ ", 2))
colnames(cpm.dat) <- c("fully.unaligned.contigs", "partially.unaligned.contigs")
cpm.dat$fully.unaligned.contigs <- as.numeric(cpm.dat$fully.unaligned.contigs)
cpm.dat$partially.unaligned.contigs <- as.numeric(gsub(" part", "", cpm.dat$partially.unaligned.contigs))
cpm.dat <- cbind.data.frame(cpm.dat, C500 = sm.dat$contigs - (cpm.dat$fully.unaligned.contigs + cpm.dat$partially.unaligned.contigs))
cpm.dat <- cbind.data.frame(cpm.dat,Aligned.length = sm.dat$Total.length - sm.dat$Unaligned.length)
cpm.dat <- cbind.data.frame(cpm.dat, MACR = sm.dat$Largest.alignment/sm.dat$Reference.length)
cpm.dat <- cbind.data.frame(cpm.dat, MACRP = cpm.dat$MACR * 100)
cpm.dat <- cbind.data.frame(cpm.dat, Chimeric.index = sm.dat$Unaligned.length/(sm.dat$Unaligned.length + cpm.dat$Aligned.length) * 100)
cpm.dat <- cbind.data.frame(cpm.dat, nC500 = 5 * cpm.dat$MACRP / max(cpm.dat$C500))
cpm.dat <- cbind.data.frame(cpm.dat, nMACR = 5 * sm.dat$Largest.alignment / max(sm.dat$Largest.alignment))
cpm.dat <- cbind.data.frame(cpm.dat, n.Chimeric.index = 5 * cpm.dat$Chimeric.index / max(cpm.dat$Chimeric.index))
cpm.dat <- cbind.data.frame(cpm.dat, CPM = 0.25 * (cpm.dat$nMACR + cpm.dat$nC500) + 0.5 * cpm.dat$n.Chimeric.index)

empty <- as.data.frame(matrix(NA,100,ncol(cpm.dat)))
colnames(empty) <- colnames(cpm.dat)
cpm.dat <- rbind.data.frame(cpm.dat, empty)
all.dat <- cbind.data.frame(all.dat, cpm.dat)

## Plot new version version of SM data
pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/third_iteration/SM_radarChart_v8.pdf", 
    width=38, height=25)
plot.7axis(subset(all.dat[all.dat$Assembly%in%assm_mgmt,], Dataset=="SM"), cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

### Prepare for data summary radar chart
all.dat$Assembly <- as.factor(all.dat$Assembly)
all.dat$Total.length <- as.numeric(all.dat$Total.length)
all.dat.sum <- aggregate(all.dat[,-c(1:2, 28:31, 37)], by=list(all.dat$Assembly), FUN=sum, na.rm=T, na.action=NULL)
colnames(all.dat.sum)[1] <- "Assembly"
all.dat.mean <- aggregate(all.dat[,c(28:31)], by=list(all.dat$Assembly), FUN=mean, na.rm=T, na.action=NULL)
colnames(all.dat.mean)[1] <- "Assembly"
all.dat.agg <- cbind.data.frame(all.dat.sum, all.dat.mean)

## Generate new version of summary/cummulative radar chart
pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/third_iteration/ALL_radarChart_v8.pdf", 
    width=38, height=25)
plot.7axis(all.dat.agg[all.dat.agg$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

#save.image("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/comparison/data_usage/comparison_revision.Rdat")
#load("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/comparison/data_usage/comparison_revision.Rdat")


