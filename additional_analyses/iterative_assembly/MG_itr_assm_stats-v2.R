#!/bin/R

require(ggplot2)
require(reshape)
library(grid)
library(gridExtra)
library(scales)
library(gtable)
library(cowplot)

######################################################################################################
##### Initialize functions
######################################################################################################

### Left margin
leftmar <- 4

### Create custom themes
mytheme <- function(){
    theme(
        axis.text.y = element_text(size = 25),
	axis.title.y = element_text(size = 30, vjust=1.5),
	legend.position = c(1,0.75),
	legend.justification = c(1,1),
	legend.text = element_text(size = 30),
	legend.title = element_text(size = 30),
	legend.key.size = unit(1.5, "cm"),
	legend.key = element_rect(colour = NA, fill = NA),
	legend.background = element_rect(fill = NA),
        axis.text.x = element_blank(),
	axis.title.x = element_blank(),
        axis.ticks.x = element_blank(),
	axis.line = element_line(size = 1),
        plot.title = element_blank(),
        plot.margin = unit(c(0.5, 0.5, -1, leftmar), "lines")
	)
}

### Visualize iterative assembly statistics ###
plot_itr_assm <- function(MG.itr){

######################################################################################################
## Plot the total no. of contigs, no. of non redundant contigs and predicted ORFs

MG.itr.m <- melt(MG.itr[-1, c(2,3,9)])
MG.itr.m <- cbind(rep(1:4,3), MG.itr.m)
colnames(MG.itr.m) <- c("iter", "type", "number")

contigs.plot <- ggplot(data = MG.itr.m, aes(x = iter, y = log10(number))) + 
geom_bar(aes(colour = type, group = type), size = 4, alpha = 0.75, 
	 position="identity") + 
scale_colour_brewer(palette = "Set1", labels = c("contigs (cummulative)",
					     "non-redundant\ncontigs",
					     "ORFs")) +
theme_bw() + 
guides(colour = guide_legend(title = element_blank()),
       shape = FALSE) +
mytheme() +
ylab("log10 (count)")

ggplot(data = MG.itr.m, aes(type, fill = log10(number))) + 
geom_bar(stat="identity", position="dodge")

ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar(position="dodge")
ggplot(MG.itr.m, aes(iter, fill=type)) + geom_bar(position="dodge")

######################################################################################################
## Plot N50 and average contig size

MG.itr.m <- melt(MG.itr[-1, c(5,6)])
MG.itr.m <- cbind(rep(1:4,2), MG.itr.m)
colnames(MG.itr.m) <- c("iter", "type", "len")

len.plot <- ggplot(data=MG.itr.m, aes(x=iter, y=len))+
geom_line(aes(colour = type, group = type), size = 4, alpha = 0.75) +
geom_point(aes(colour = type, group = type, shape = type), size = 5,
	   show_guide = FALSE, alpha = 0.75) +
scale_colour_hue(l = 40, labels = c("mean",
				    "N50")) +
theme_bw() +
guides(colour = guide_legend(title = element_blank())) +
mytheme() +
ylab("length (bp)")

######################################################################################################
## Plot absolute no. of unmappable reads and difference of unmappable reads 
## from previous step

MG.itr.m <- melt(MG.itr[-1,4])
MG.itr.m <- cbind(MG.itr.m, 
		  c(0, abs(MG.itr.m$value[1:3] - MG.itr.m$value[2:4]))
		  ) 

colnames(MG.itr.m) <- c("unmappable", "additional\nmapped")
MG.itr.m <- melt(MG.itr.m)
MG.itr.m <- cbind(rep(1:4,2), MG.itr.m)
colnames(MG.itr.m)[1] <- "step"
MG.itr.m$value <- log10(MG.itr.m$value)

reads.um <- ggplot(data = MG.itr.m, aes(x = step,y = value, colour = variable))+
geom_line(size = 4, aes(colour = variable), alpha = 0.75)+
geom_point(size = 5, aes(colour = variable, shape = variable), show_guide = FALSE,  alpha = 0.75)+
theme_bw() +
guides(colour = guide_legend(title = element_blank()))+
mytheme() +
theme(axis.title.x = element_text(size = 35),
      axis.text.x = element_text(size = 30, vjust=1),
      plot.margin = unit(c(0.5, 0.5, 1, leftmar) , "lines")
      ) +
ylab("log10 (count)") +
xlab("Step")

# Join all plots
gp.ctg <- ggplot_gtable(ggplot_build(contigs.plot))
gp.len <- ggplot_gtable(ggplot_build(len.plot))
gp.rd <- ggplot_gtable(ggplot_build(reads.um))

maxWidth = unit.pmax(gp.ctg$widths[2:3], gp.len$widths[2:3], gp.rd$widths[2:3])
gp.ctg$widths[2:3] <- maxWidth
gp.len$widths[2:3] <- maxWidth
gp.rd$widths[2:3] <- maxWidth

## Plot the joint figure
plot_grid(gp.ctg, gp.len, gp.rd, ncol=1, labels=c("(A)", "(B)", "(C)"), label_size=45, hjust=-0.5)
}
### Function end
######################################################################################################

######################################################################################################
### MAIN
## Plot iterative assembly for A02 dataset
A02.dat <- read.delim("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/A02_MG_iter_assm_stats.csv")
png("/home/shaman/Documents/Publications/IMP-manuscript/figures/A02_MG_iter_assm_stats.png", 
    width = 1500,
    height = 1200)
plot_itr_assm(A02.dat)
dev.off()

## Plot iterative assembly for D36 dataset
D36.dat <- read.delim("D36_MG_iter_assm_stats.csv")
png("/home/shaman/Documents/Publications/IMP-manuscript/figures/D36_MG_iter_assm_stats.png", 
    width = 1500,
    height = 1200)
plot_itr_assm(D36.dat)
dev.off()

## end ##
######################################################################################################
