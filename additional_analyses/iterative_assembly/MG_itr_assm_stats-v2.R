#!/bin/R

require(ggplot2)
require(reshape)
library(grid)
library(gridExtra)
library(scales)
library(gtable)
library(cowplot)
require(stringr)

mytheme <- function(){
    theme(
        axis.text.y = element_text(size = 25),
	axis.title.y = element_text(size = 30, vjust=1.5),
	legend.position = c(1,1),
	legend.justification = c(1,1),
	legend.text = element_text(size = 30),
	legend.title = element_text(size = 30),
	legend.key.size = unit(1.5, "cm"),
	legend.key = element_rect(colour = NA, fill = NA),
	legend.background = element_rect(fill = NA, colour = "gray"),
        axis.text.x = element_blank(),
	axis.title.x = element_blank(),
        axis.ticks.x = element_blank(),
	axis.line = element_line(size = 1),
        plot.title = element_blank(),
        plot.margin = unit(c(0, 0, 0, 0), "lines")
	)
}

plot_dat <- function(dat.file, pe.file, se.file){
### Read in assembly assessment data
dat <- read.delim(dat.file)

### Read in unmappable read data
pe <- read.table(pe.file, header=F)
colnames(pe) <- c("file", "reads_used")
se <- read.table(se.file, header=F)
colnames(se) <- c("file", "reads_used")

# Reformulate table
pe <- 
    cbind(pe, 
	    type=rep("PE", nrow(pe)),
	    Assembly=1:6,
	    unmappable=c(pe$reads_used[2:nrow(pe)], NA),
	    mappable=c(pe$reads_used[1] - pe$reads_used[2:nrow(pe)], NA)
	    )

additional_mapped=c(NA, pe$mappable[2:nrow(pe)] - pe$mappable[1:nrow(pe)-1])
pe <- cbind(pe, additional_mapped)
pe$additional_mapped[1]  <- pe$mappable[1]



se <- 
    cbind(se, 
	  type=rep("SE", nrow(pe)), 
	  Assembly=1:6, 
	  unmappable=c(se$reads_used[2:6], NA), 
	  mappable=c(se$reads_used[1] - se$reads_used[2:6], NA)
)

additional_mapped=c(NA, se$mappable[2:nrow(se)] - se$mappable[1:nrow(se)-1])
se <- cbind(se, additional_mapped)
se$additional_mapped[1]  <- se$mappable[1]

dat.1 <- as.data.frame(
		       cbind(Assembly=as.character(1:6),
			     genome_size=c(dat[1,c(28)], dat[2:nrow(dat),c(28)] - dat[1:nrow(dat)-1,c(28)]),
			     additional_mapped=2*(pe$additional_mapped) + se$additional_mapped
			     )
		       )
dat.1$additional_mapped <- as.numeric(as.character(dat.1$additional_mapped))
dat.1$genome_size <- as.numeric(as.character(dat.1$genome_size))

### Plot number of reads and total assembly bases
m.dat.1 <- melt(dat.1)
colnames(m.dat.1) <- c("Assembly", "type", "count")

p1 <- ggplot(data=m.dat.1, aes(x=Assembly, y=log10(count), fill=type)) + 
geom_bar(stat="identity", position="dodge") +
scale_fill_manual(values = c("darkorange1", "lightseagreen"), 
		    labels = c("Base pairs", "Mappable reads")
		    ) +
guides(fill = guide_legend(title = "Additional")) +
mytheme() 

### Plot gain of contigs and genes relative to previous assembly
dat.2 <- dat[2:nrow(dat),c(22,3)] - dat[1:nrow(dat)-1,c(22,3)]
dat.2 <- rbind(dat[1,c(22,3)], dat.2)
dat.2 <- cbind(as.character(dat[,1]), dat.2)
colnames(dat.2) <- c("Assembly", "Information", "Volume")
dat.2$Assembly <- as.character(1:6)

m.dat.2 <- melt(dat.2)
colnames(m.dat.2)[2:3] <- c("type", "count")
m.dat.2$count[m.dat.2$count==0] = NA

p2 <- ggplot(data=m.dat.2, aes(x=Assembly, y=log10(count), fill=type)) + 
geom_bar(stat="identity", position="dodge") +
scale_fill_manual(values = c("seagreen", "salmon1"), 
		    labels = c("Information", "Volume")
		    ) +
guides(fill = guide_legend(title = "Additional")) +
mytheme() +
theme(axis.title.x = element_text(size = 35),
      axis.text.x = element_text(size = 30, vjust=0),
      plot.margin = unit(c(0.5, 0.5, 1, 4) , "lines")
      ) +
xlab("Assembly")

### Plot all the values in a single plot
m.dat <- rbind(m.dat.1, m.dat.2)

p3 <- ggplot(data=m.dat, aes(x=Assembly, y=log10(count), fill=type)) + 
geom_bar(stat="identity", position="dodge") +
scale_fill_manual(values = c("darkorange1", "lightseagreen", "salmon", "seagreen"), 
		    labels = c("Base pairs", "Mappable reads", 
			       "Information", "Volume")
		    ) +
guides(fill = guide_legend(title = "Additional")) +
mytheme() +
theme(axis.title.x = element_text(size = 35),
      axis.text.x = element_text(size = 30, vjust=0),
      plot.margin = unit(c(0.5, 0.5, 1, 4) , "lines")
      ) +
xlab("Assembly")

list(p1, p2, p3)
}

HF.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/X310763260-iterative_MG/collapsed_contigs_stats.tsv"
HF.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/X310763260-iterative_MG/pair_counts.tsv"
HF.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/X310763260-iterative_MG/single_counts.tsv"

HF.plots <- plot_dat(HF.dat, HF.pe, HF.se)

WW.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/A02-iterative_MG/collapsed_contigs_stats.tsv"
WW.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/A02-iterative_MG/pair_counts.tsv"
WW.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/A02-iterative_MG/single_counts.tsv"

WW.plots <- plot_dat(WW.dat, WW.pe, WW.se)

### Generate plots
pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/MG_iter_assm.pdf", 
    height=15, width=15)
plot_grid(HF.plots[[3]] + mytheme() + theme(axis.ticks.x = element_line(size=1)), 
	  WW.plots[[3]] + guides(fill=FALSE) + theme(axis.ticks.x = element_line(size=1)), 
	  ncol=1, align="v", labels=c("(A)", "(B)"), label_size=45, hjust=-0.5)
dev.off()

