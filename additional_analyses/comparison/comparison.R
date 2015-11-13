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
			     fsize, linewd, mcex, lwd, plwd, title) 
{
dat <- dat[,c("Assembly", 
       "X..contigs.....1000.bp.", 
       "N50", 
       "X..predicted.genes..unique.",
       "X..misassemblies", 
       "Genome.fraction...."
       )]
colnames(dat) <- c("Assembly", "Volume", "Contiguity", "Information", "Accuracy", "Recovery")
dat$Accuracy <- -dat$Accuracy

dat$Assembly <- factor(dat$Assembly, levels=c(levels(dat$Assembly), 'max', 'min'))
dat <- rbind(
	     c("max", apply(dat[, 2:ncol(dat)], 2, max)), 
	     c("min", apply(dat[, 2:ncol(dat)], 2, min)), 
	     dat)

dat[,2:ncol(dat)] <- sapply(dat[,2:ncol(dat)], as.numeric)
	     
# Calculate maximum and minimum for positive values
dat[1, !names(dat) %in% c("Assembly", "Accuracy")] <- 
    dat[1, !names(dat) %in% c("Assembly", "Accuracy")] * 1.025
dat[2, !names(dat) %in% c("Assembly", "Accuracy")] <- 
    dat[2, !names(dat) %in% c("Assembly", "Accuracy")] * 0.75

# Calculate maximum and minimum for negative values
dat[1, names(dat) %in% c("Accuracy")] <- 
    round(dat[1, names(dat) %in% c("Accuracy")] * 0.75)
dat[2, names(dat) %in% c("Accuracy")] <- 
    round(dat[2, names(dat) %in% c("Accuracy")] * 1.025)

# Set min and max for percentages
dat[1, names(dat) %in% c("Recovery")] <- 100
dat[2, names(dat) %in% c("Recovery")] <- 0

par(mar=c(0,0,8,0)) 
radarchart(dat[,-1], pcol=cols, pfcol=dens, plty=linetype, plwd=plwd,
	   cglwd=lwd, palcex=font, calcex=font, vlcex=font, cglcol="gray",
	   oma=c(0,0,0,0))#, title = title, cex.main = 6)
title(title, outer = FALSE, line = 2, font = 2, cex.main = 7.5)
}

cols <- makeTransparent("darkred", "darkblue", "darkgreen", "darkorange2", alpha=0.75)
dens <- makeTransparent("red", "blue", "green", "orange", alpha=0.10)
font=5
linetype <- c(1,1,2,2)
fsize=4.5
linewd=4.5
mcex=4
lwd=4.5
plwd=3.5

## Produce radar chart for the basic assembly statistics

## Read in simulated data
dat1 <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/quast_output/quast_simDat_20151028/combined_reference/transposed_report.tsv", header=T)

## Read in HFD
dat2 <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/quast_output/quast_X310763260-20151028/combined_reference/transposed_report.tsv", header=T)

## Read in SD3 vs Bio17-1
dat3 <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/quast_output/quast_A02_Microthrix_Bio17-20151028/combined_reference/transposed_report.tsv", header=T)

png("/home/shaman/Documents/Publications/IMP-manuscript/figures/comparison_all-v3.png", 
    width=2900, height=900)
par(mfrow=c(1,3), mar = c(10,0,0,0))
plot.basic.stats(dat1, cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd, title = "(A) Mock") 
plot.basic.stats(dat2, cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd, title = "(B) HFD") 
plot.basic.stats(dat3, cols, dens, font, linetype, fsize, linewd, mcex, lwd, plwd, title = "(C) SD3") 
par(fig = c(0, 1, 0, 0.4), oma = c(0, 0, 0, 0), mar=c(0,0,0,0), new = TRUE)
legend("bottom", legend=dat1[1:nrow(dat1),1], xpd = TRUE, horiz = TRUE, 
       bty = "o", col = cols, lty=linetype, 
       lwd = c(2,2,2,2), cex = 5, box.lty=1, box.lwd=0, 
       box.col="gray", text.col=cols, text.font=c(2,2,2,2))
dev.off()
