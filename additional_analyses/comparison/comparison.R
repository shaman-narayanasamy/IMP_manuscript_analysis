#!/bin/R

require(fmsb)
require(ggplot2)
require(grDevices)
library(dplyr)
library(tidyr)
library(graphics)
library(cowplot)

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

######################################################################################################
## Read assessment of simulated dat

plot.basic.stats <- function(dat, cols, dens, font, linetype, 
			     fsize, linewd, mcex, lwd, plwd, title = "") 
{
dat <- dat[,c("Assembly", 
       "X..contigs.....1000.bp.", 
       "N50", 
       "X..predicted.genes..unique.",
       "Genome.fraction...."
       )]
colnames(dat) <- c("Assembly", "contigs \u2265 1kb", "N50 length", "no. of genes", "genome fraction (%)")

dat$Assembly <- factor(dat$Assembly, levels=c(levels(dat$Assembly), 'max', 'min'))
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

# Calculate maximum and minimum for negative values
#dat[1, names(dat) %in% c("Accuracy")] <- 
#    round(dat[1, names(dat) %in% c("Accuracy")] * 0.75)
#dat[2, names(dat) %in% c("Accuracy")] <- 
#    round(dat[2, names(dat) %in% c("Accuracy")] * 1.025)

# Set min and max for percentages
dat[1, names(dat) %in% c("Recovery")] <- 100
dat[2, names(dat) %in% c("Recovery")] <- 0

par(mar=c(0,0,8,0)) 
radarchart(dat[,-1], pcol=cols, pfcol=dens, plty=linetype, plwd=plwd,
	   cglwd=lwd, palcex=font, calcex=font, vlcex=font, cglcol="darkgray",
	   paxislabels = c("contigs \u2265 1kb", "N50 length", "no. of genes", "genome fraction (%)"),
	   oma=c(0,0,0,0))#, title = title, cex.main = 6)
title(title, outer = FALSE, line = 2, font = 2, cex.main = 7.5)
}

cols <- makeTransparent("darkred", "darkblue", "darkgreen", "darkorange2", alpha=0.75)
dens <- makeTransparent("red", "blue", "green", "orange", alpha=0.10)
font=10
linetype <- c(1,1,2,2)
fsize=10
linewd=15
mcex=8
lwd=16
plwd=15

## Produce radar chart for the basic assembly statistics

## Read in simulated data
dat1 <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/quast_output/quast_simDat_20151028/combined_reference/transposed_report.tsv", header=T)

## Read in HF
dat2 <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/quast_output/quast_X310763260-20151028/combined_reference/transposed_report.tsv", header=T)

## Read in WW vs Bio17-1
dat3 <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/quast_output/quast_A02_Microthrix_Bio17-20151208/combined_reference/transposed_report.tsv", header=T)

png("/home/shaman/Documents/Publications/IMP-manuscript/figures/comparison_all-v7.png", 
    width=2900, height=1500)

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/comparison_all-v8.pdf", 
    width=30, height=15)
par(mfrow=c(1,3), mar = c(10,0,0,0))
plot.basic.stats(dat1, cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd, title = "(A) SM") 
plot.basic.stats(dat2, cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd, title = "(B) HF") 
plot.basic.stats(dat3, cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd, title = "(C) WW") 

par(fig = c(0, 1, 0, 1), oma = c(0.5, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")
legend("bottom", legend=dat1[,1], xpd = TRUE, horiz = TRUE, inset = c(0, 
    0), bty = "o", col = cols, lty=linetype, lwd = c(4,4,4,4), cex = 4,
       text.font=c(4,4,4,4), box.lty=1, box.lwd=0, box.col="gray",
       text.col=cols)

dev.off()


pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/SM_radarChart_v2.pdf", 
    width=38, height=25)
plot.basic.stats(dat1, cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/HF_radarChart_v2.pdf", 
    width=38, height=25)
plot.basic.stats(dat2, cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/WW_radarChart_v2.pdf", 
    width=38, height=25)
plot.basic.stats(dat3, cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd) 
dev.off()

pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/radarChart_legend.pdf", 
    width=40, height=2.5)
par(fig = c(0, 1, 0, 1), oma = c(0.5, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")
legend("bottom", legend=dat1[,1], xpd = TRUE, horiz = TRUE, inset = c(0, 
    0), bty = "o", col = cols, lty=linetype, lwd = c(4,4,4,4), cex = 4,
       text.font=c(4,4,4,4), box.lty=1, box.lwd=0, box.col="gray",
       text.col=cols)

dev.off()


