#!/bin/R

require(fmsb)
require(ggplot2)
require(grDevices)
library(dplyr)
library(tidyr)
library(graphics)

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

### FUNCTION: Plot basic statistics ###
plot_basic_stats <- function(dat, title=NULL, font=1, lwd=1, plwd=c(2,2,2)) {
## Process basic satistics
data <- dat[,c(
	      "Assembly",
	      "X..contigs.....1000.bp.",
	      "N50",
	      "Total.length",
	      "Largest.contig",
	      "N75",
	      "Genome.fraction...."
	      )]
data$Assembly <- as.character(data$Assembly)

# Convert some values into negative values (to flip the axis)
data <- rbind(c("max", apply(data[, 2:ncol(data)], 2, max)), 
		     c("min", apply(data[, 2:ncol(data)], 2, min)), 
		     data)

# Change data to numeric
data[,2:ncol(data)] <- sapply(data[,2:ncol(data)], as.numeric)

# Calculate maximum and minimum for positive values
data[1, !names(data) %in% c("Assembly", "L50", "L75")] <- 
    data[1, !names(data) %in% c("Assembly", "L50", "L75")] * 1.1
data[2, !names(data) %in% c("Assembly", "L50", "L75")] <- 
    data[2, !names(data) %in% c("Assembly", "L50", "L75")] * 0.9

# Calculate maximum and minimum for positive values. Genome fraction set to 0 min and 100 max
data[1, "Genome.fraction...."] <- 100
data[2, "Genome.fraction...."] <- 0

axisnames <- c("contigs > 1kbp", 
	       "N50", 
	       "total length", 
	       "largest contig",
	       "N75",
	       "genome\nfraction"
	       )

# Produce radar chart for the basic assembly statistics
radarchart(data[,-1], pcol=cols, pfcol=dens, plty=linetype, plwd=plwd,
	   cglwd=lwd, palcex=font, calcex=font, vlcex=font, cglcol="gray",
	   vlabels=axisnames, title=title, oma=c(0,0,0,0))
}

### FUNCTION: Plot misassembly statistics ###
plot_misassembly_stats <- function(dat, title=NULL, font=1, lwd=1, plwd=c(2,2,2)) {
## Process misassembly statistics
data <- dat[, c("Assembly", 
		"X..misassemblies", 
		"Duplication.ratio", 
		"X..mismatches.per.100.kbp",
		"X..indels.per.100.kbp"
		)]

data$Assembly <- as.character(data$Assembly)

#data[ , !names(data) %in% c("Assembly", "Genome.fraction....")] <- 
#    -data[ , !names(data) %in% c("Assembly", "Genome.fraction....")] 

data <- rbind(c("max", apply(data[,2:ncol(data)],2,max)), 
		     c("min", apply(data[,2:ncol(data)],2,min)), 
		     data)
data[,2:ncol(data)] <- sapply(data[,2:ncol(data)], as.numeric)


# Calculate maximum and minimum for positive values
#data[1, !names(data) %in% c("Assembly", "Genome.fraction....")] <- 
#    data[1, !names(data) %in% c("Assembly", "Genome.fraction....")] * 0.9
#data[2, !names(data) %in% c("Assembly", "Genome.fraction....")] <- 
#    data[2, !names(data) %in% c("Assembly", "Genome.fraction....")] * 1.1

data[1, !names(data) %in% c("Assembly")] <- 
    data[1, !names(data) %in% c("Assembly")] * 1.1
data[2, !names(data) %in% c("Assembly")] <- 
    data[2, !names(data) %in% c("Assembly")] * 0.9


# Set duplication ratio max to 0 and min to -2
data[1, "Duplication.ratio"] <- 0
data[2, "Duplication.ratio"] <- 2

axisnames <- c("misassemblies", 
	       "duplication\nratio",
	       "mismatches per 100 kbp",
	       "indels\nper\n100kbp")

# Produce radar chart for the basic assembly statistics
radarchart(data[,-1], pcol=cols, pfcol=dens, plty=linetype, plwd=plwd,
	   cglwd=lwd, palcex=font, calcex=font, vlcex=font, cglcol="gray",
	   vlabels=axisnames,title=title, oma=c(0,0,0,0))
}

### FUNCTION: Plot gene statistics ###
plot_gene_stats <- function(dat, title=NULL, font=1, lwd=1, plwd=c(2,2,2)) {
## Process gene statistics
data <- 
    dat[, c(
	    "Assembly", 
	    "X..predicted.genes..unique.",
	    "X..predicted.genes.....0.bp.",
	    "X..predicted.genes.....300.bp.",
	    "X..predicted.genes.....1500.bp.",
	    "X..predicted.genes.....3000.bp."
	    )]

data$Assembly <- as.character(data$Assembly)

data <- rbind(c("max", apply(data[,2:ncol(data)],2,max)), 
		     c("min", apply(data[,2:ncol(data)],2,min)), 
		     data)
data[,2:ncol(data)] <- sapply(data[,2:ncol(data)], as.numeric)

# Calculate maximum and minimum for positive values
data[1, !names(data) %in% "Assembly"] <- 
data[1, !names(data) %in% "Assembly"] * 1.1

data[2, !names(data) %in% "Assembly"] <- 
data[2, !names(data) %in% "Assembly"] * 0.9

axisnames <- c(
	       "unique", 
	       "total", 
	       "> 300bp", 
	       "> 1.5kbp", 
	       "> 3kbp")

radarchart(data[,-1], pcol=cols, pfcol=dens, plty=linetype, plwd=plwd,
	   cglwd=lwd, palcex=font, calcex=font, vlcex=font, cglcol="gray",
	   vlabels=axisnames,title=title, oma=c(0,0,0,0))
}

######################################################################################################

## Read in simulated data
dat1 <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/quast_output/quast_simDat_20151028/combined_reference/transposed_report.tsv", header=T)

## Read in HFD
dat2 <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/quast_output/quast_X310763260-20151028/combined_reference/transposed_report.tsv", header=T)

## Read in SD3 vs Bio17-1
dat3 <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/quast_output/quast_A02_Microthrix_Bio17-20151028/combined_reference/transposed_report.tsv", header=T)

# Initialize colours, lines and fonts
cols <- makeTransparent("darkred", "darkblue", "darkgreen", "orange", alpha=0.75)
dens <- makeTransparent("red", "blue", "green", "yellow", alpha=0.10)
font=3.5
linetype <- c(1,1,2,2)
fsize=4.5
linewd=3.5
mcex=5

# Generate figure
png("/home/shaman/Documents/Publications/IMP-manuscript/figures/comparison_detailed_v2.png", 
    width=2400, height=2000)

## Bottom, left, top, right
par(oma = c(4, 1.5, 3, 0))
par(mfrow=c(3,3))
plot_basic_stats(dat1, font=fsize, lwd=linewd, plwd=linewd)
mtext("Assembly", side=3, line=2, cex=mcex, font=2)
mtext("Mock", side=2, line=1, srt=90, cex=mcex, font=4) 
plot_misassembly_stats(dat1, font=fsize, lwd=linewd, plwd=linewd)
mtext("Reference", side=3, line=2, cex=mcex, font=2)
plot_gene_stats(dat1, font=fsize, lwd=linewd, plwd=linewd)
mtext("Genes", side=3, line=2, cex=mcex, font=2)

plot_basic_stats(dat2, font=fsize, lwd=linewd, plwd=linewd)
mtext("HFD", side=2, line=1, srt=90, cex=mcex, font=4) 
plot_misassembly_stats(dat2, font=fsize, lwd=linewd, plwd=linewd)
plot_gene_stats(dat2, font=fsize, lwd=linewd, plwd=linewd)

plot_basic_stats(dat3, font=fsize, lwd=linewd, plwd=linewd)
mtext("SD3 vs Bio17-1", side=2, line=0, srt=90, cex=mcex, font=4) 
plot_misassembly_stats(dat3, font=fsize, lwd=linewd, plwd=linewd)
plot_gene_stats(dat3, font=fsize, lwd=linewd, plwd=linewd)

par(fig = c(0, 1, 0, 1), oma = c(0.5, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")
legend("bottom", legend=dat1[,1], xpd = TRUE, horiz = TRUE, inset = c(0, 
    0), bty = "o", col = cols, lty=linetype, lwd = c(4,4,4,4), cex = 4,
       text.font=c(4,4,4,4), box.lty=1, box.lwd=3, box.col="gray",
       text.col=cols)
dev.off()

# Generate figure
png("/home/shaman/Documents/Publications/IMP-manuscript/figures/comparison_detailed2.png", 
    width=2000, height=2000)
par(oma = c(4, 1.5, 3, 0))
par(mfrow=c(3,3))

plot_basic_stats(dat4, font=fsize, lwd=linewd, plwd=linewd)
mtext("Assembly", side=3, line=2, cex=mcex, font=2)
mtext("SD3 Sludge vs RN1", side=2, line=0, srt=90, cex=mcex, font=4) 
plot_misassembly_stats(dat3, font=fsize, lwd=linewd, plwd=linewd)
mtext("Reference", side=3, line=2, cex=mcex, font=2)
plot_gene_stats(dat3, font=fsize, lwd=linewd, plwd=linewd)
mtext("Genes", side=3, line=2, cex=mcex, font=2)

plot_basic_stats(dat5, font=fsize, lwd=linewd, plwd=linewd)
mtext("SD6 Sludge vs Bio17", side=2, line=0, srt=90, cex=mcex, font=4) 
plot_misassembly_stats(dat3, font=fsize, lwd=linewd, plwd=linewd)
plot_gene_stats(dat3, font=fsize, lwd=linewd, plwd=linewd)

plot_basic_stats(dat6, font=fsize, lwd=linewd, plwd=linewd)
mtext("SD6 Sludge vs RN1", side=2, line=0, srt=90, cex=mcex, font=4) 
plot_misassembly_stats(dat3, font=fsize, lwd=linewd, plwd=linewd)
plot_gene_stats(dat3, font=fsize, lwd=linewd, plwd=linewd)

par(fig = c(0, 1, 0, 1), oma = c(0.5, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")
legend("bottom", legend=dat1[,1], xpd = TRUE, horiz = TRUE, inset = c(0, 
    0), bty = "o", col = cols, lty=linetype, lwd = c(4,4,4), cex = 4,
       text.font=c(4,4,4), box.lty=1, box.lwd=3, box.col="gray",
       text.col=c("darkblue", "darkred", "darkgreen"))

dev.off()
