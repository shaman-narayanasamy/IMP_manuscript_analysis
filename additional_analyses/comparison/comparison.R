#!/bin/R

require(fmsb)
require(ggplot2)
require(grDevices)
library(dplyr)
library(plyr)
library(tidyr)
library(graphics)
library(cowplot)

### Load data usage workspace
load("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/comparison/data_usage/data_usage.Rdat")

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
### FUNCTION: 5-axis radar chart
plot.6axis <- function(dat, cols, dens, font, linetype, 
			     fsize, linewd, mcex, lwd, plwd, title = "") {
dat <- dat[,c("Assembly", 
       "X..contigs.....1000.bp.", 
       "N50", 
       "X..predicted.genes..unique.",
       "X..misassemblies",
       "Genome.fraction....",
       "MG_properly_paired",
       "MT_properly_paired"
       )]

colnames(dat) = c("Assembly", "contigs \u2265 1kb", "N50 length", "no. of genes", "misassemblies", 
		  "genome fraction (%)", "MG properly paired", "MT properly paired")

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

#dat[1, names(dat) %in% c("MG mapped")] <- 100
#dat[2, names(dat) %in% c("MG mapped")] <- 0

dat[1, names(dat) %in% c("MG properly paired")] <- 100
dat[2, names(dat) %in% c("MG properly paired")] <- 0

#dat[1, names(dat) %in% c("MT mapped")] <- 100
#dat[2, names(dat) %in% c("MT mapped")] <- 0

dat[1, names(dat) %in% c("MT properly paired")] <- 100
dat[2, names(dat) %in% c("MT properly paired")] <- 0

par(mar=c(0,0,8,0)) 
radarchart(dat[,-1], pcol=cols, pfcol=dens, plty=linetype, plwd=plwd,
	   cglwd=lwd, palcex=font, calcex=font, vlcex=font, cglcol="darkgray",
	   paxislabels = c("Assembly", "contigs \u2265 1kb", "N50 length", 
			   "no. of genes", "misassemblies", "genome fraction (%)", 
			   "MG mapped", "MG properly paired", "MT mapped", "MT properly paired"),
	   oma=c(0,0,0,0))#, title = title, cex.main = 6)
title(title, outer = FALSE, line = 2, font = 2, cex.main = 7.5)
}

###############################################################################################################################
### FUNCTION: 3-axis radar chart
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

#dat[1, names(dat) %in% c("MG mapped")] <- 100
#dat[2, names(dat) %in% c("MG mapped")] <- 0

dat[1, names(dat) %in% c("MG properly paired")] <- 100
dat[2, names(dat) %in% c("MG properly paired")] <- 0

#dat[1, names(dat) %in% c("MT mapped")] <- 100
#dat[2, names(dat) %in% c("MT mapped")] <- 0

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

## Remove NaN's from WW1 data!
WW1_quast[is.na(WW1_quast)] <- 0

cols <- makeTransparent("darkred", "darkblue", "darkgreen", "darkorange2", alpha=0.75)
dens <- makeTransparent("red", "blue", "green", "orange", alpha=0.10)
font=10
linetype <- c(1,1,2,2)
fsize=10
linewd=15
mcex=8
lwd=16
plwd=15


pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/SM_radarChart_v5.pdf", 
    width=38, height=25)
plot.6axis(SM_quast[SM_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/HF1_radarChart_v5.pdf", 
    width=38, height=25)
plot.5axis(HF1_quast[HF1_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/HF2_radarChart_v5.pdf", 
    width=38, height=25)
plot.5axis(HF2_quast[HF2_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/HF3_radarChart_v5.pdf", 
    width=38, height=25)
plot.5axis(HF3_quast[HF3_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/HF4_radarChart_v5.pdf", 
    width=38, height=25)
plot.5axis(HF4_quast[HF4_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/HF5_radarChart_v5.pdf", 
    width=38, height=25)
plot.5axis(HF5_quast[HF5_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/WW1_radarChart_v5.pdf", 
    width=38, height=25)
plot.5axis(WW1_quast[WW1_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/WW2_radarChart_v5.pdf", 
    width=38, height=25)
plot.5axis(WW2_quast[WW2_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/WW3_radarChart_v5.pdf", 
    width=38, height=25)
plot.5axis(WW3_quast[WW3_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/WW4_radarChart_v5.pdf", 
    width=38, height=25)
plot.5axis(WW4_quast[WW4_quast$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/BG_radarChart_v5.pdf", 
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

### Prepare for data summary radar chart
all.dat$Assembly <- as.factor(all.dat$Assembly)

all.dat.sum <- aggregate(all.dat[,-c(1:2, 28:47)], by=list(all.dat$Assembly), FUN=sum)
colnames(all.dat.sum)[1] <- "Assembly"

all.dat.mean <- aggregate(all.dat[,c(28:31)], by=list(all.dat$Assembly), FUN=mean)
colnames(all.dat.mean)[1] <- "Assembly"


all.dat.agg <- cbind.data.frame(all.dat.sum, all.dat.mean, ref.dat[1:10,])

## Generate summary/cummulative radar chart
pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/second_iteration/ALL_radarChart_v5.pdf", 
    width=38, height=25)
plot.6axis(all.dat.agg[all.dat.agg$Assembly%in%assm_mgmt,], cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

empty <- as.data.frame(matrix(NA,100,ncol(ref.dat)))
colnames(empty) <- colnames(ref.dat)
ref.dat <- rbind.data.frame(ref.dat, empty)
all.dat <- cbind.data.frame(all.dat, ref.dat)
colnames(all.dat) <- gsub("X..", "", colnames(all.dat))
colnames(all.dat) <- gsub("\\.\\.\\.\\.\\.", " ", colnames(all.dat))
colnames(all.dat)[1] <- "Dataset"

write.table(as.data.frame(all.dat), "/home/shaman/Documents/Publications/IMP-manuscript/tables/second_iteration/all_comparison.tsv",  
	    row.names=F, quote=F, sep = "\t")

save.image("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/comparison/data_usage/comparison.Rdat")
