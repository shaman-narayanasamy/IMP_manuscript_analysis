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
	axis.line = element_line(size = 1),
        plot.title = element_blank(),
        plot.margin = unit(c(0, 0, 0, 0), "lines")
	)
}

plot_dat <- function(dat.file, pe.file, se.file){
### Read in assembly assessment data
dat <- read.delim(dat.file, header=F)
colnames(dat) <- c("no.of_contigs", "avg.len", "N50", "total_length", "largest_contig", "no.of_genes")
dat <- cbind(iteration=1:6, dat)

### Read in unmappable read data
pe <- read.table(pe.file, header=F)
colnames(pe) <- c("file", "reads_used")
se <- read.table(se.file, header=F)
colnames(se) <- c("file", "reads_used")

# Reformulate tables
pe <- 
    cbind(pe, 
	    type=rep("PE", nrow(pe)),
	    iteration=1:6,
	    unmappable=c(pe$reads_used[2:nrow(pe)], NA),
	    mappable=c(pe$reads_used[1] - pe$reads_used[2:nrow(pe)], NA)
	    )

additional_mapped=c(NA, pe$mappable[2:nrow(pe)] - pe$mappable[1:nrow(pe)-1])
pe <- cbind(pe, additional_mapped)
pe$additional_mapped[1]  <- pe$mappable[1]

se <- 
    cbind(se, 
	  type=rep("SE", nrow(pe)), 
	  iteration=1:6, 
	  unmappable=c(se$reads_used[2:6], NA), 
	  mappable=c(se$reads_used[1] - se$reads_used[2:6], NA)
)

additional_mapped=c(NA, se$mappable[2:nrow(se)] - se$mappable[1:nrow(se)-1])
se <- cbind(se, additional_mapped)
se$additional_mapped[1] <- se$mappable[1]

## Obtain the incremental information and join tables
dat.1 <- as.data.frame(
		       cbind(iteration=as.character(1:6),
			     no.of_contigs=c(dat[1, "no.of_contigs"], 
					    dat[2:nrow(dat),"no.of_contigs"] - 
					    dat[1:nrow(dat)-1, "no.of_contigs"]),
			     total_length=c(dat[1, "total_length"], 
					    dat[2:nrow(dat),"total_length"] - 
					    dat[1:nrow(dat)-1, "total_length"]),
			     no.of_genes=c(dat[1, "no.of_genes"], 
					    dat[2:nrow(dat),"no.of_genes"] - 
					    dat[1:nrow(dat)-1, "no.of_genes"]),
			     additional_mapped=2*(pe$additional_mapped) + se$additional_mapped
			     )
		       )

dat.1$additional_mapped <- as.numeric(as.character(dat.1$additional_mapped))
dat.1$total_length <- as.numeric(as.character(dat.1$total_length))
dat.1$no.of_genes <- as.numeric(as.character(dat.1$no.of_genes))
dat.1$no.of_contigs <- as.numeric(as.character(dat.1$no.of_contigs))
dat.1 <- dat.1[-c((nrow(dat.1)-1):(nrow(dat.1))),]

## Melt the data
m.dat.1 <- melt(dat.1)
colnames(m.dat.1) <- c("iteration", "type", "count")
m.dat.1$count[m.dat.1$count==0] = NA
m.dat.1 <- m.dat.1[order(m.dat.1$count),]

## Reorder the bars from large to small
m.dat.1$type <- factor(m.dat.1$type, levels(m.dat.1$type)[c(2,4,3,1)])

### Plot all the values in a single plot

p1 <- ggplot(data=m.dat.1, aes(x=iteration, y=log10(count), fill=type, order=as.factor(type))) + 
geom_bar(stat="identity", position="dodge") +
scale_fill_manual(values = c("darkorange1", "lightseagreen", "salmon", "seagreen"), 
		    labels = c("total length", 
			       "mappable reads", 
			       "no. of genes", 
			       "no. of contigs (all)")
		    ) +
	  scale_x_discrete("iteration", 
			   labels = c("1" = "Initial assembly",
				      "2" = "First",
				      "3" = "Second",
				      "4" = "Third",
				      "5" = "Fourth")) +
guides(fill = guide_legend(title = "measure")) +
theme(axis.title.x = element_text(size = 35),
      axis.text.x = element_text(size = 30, vjust=0),
      plot.margin = unit(c(0.5, 0.5, 1, 4) , "lines")
      ) +
xlab("iteration")

list(p1, dat.1)
}

### Read in data

## SM 
SM.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/SM/collapsed_contig_gene_stats.tsv"
SM.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/SM/pair_counts.tsv"
SM.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/SM/single_counts.tsv"

SM.plots <- plot_dat(SM.dat, SM.pe, SM.se)

## HF1 
HF1.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF1/collapsed_contig_gene_stats.tsv"
HF1.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF1/pair_counts.tsv"
HF1.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF1/single_counts.tsv"

HF1.plots <- plot_dat(HF1.dat, HF1.pe, HF1.se)

## HF2 
HF2.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF2/collapsed_contig_gene_stats.tsv"
HF2.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF2/pair_counts.tsv"
HF2.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF2/single_counts.tsv"

HF2.plots <- plot_dat(HF2.dat, HF2.pe, HF2.se)

## HF3 
HF3.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF3/collapsed_contig_gene_stats.tsv"
HF3.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF3/pair_counts.tsv"
HF3.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF3/single_counts.tsv"

HF3.plots <- plot_dat(HF3.dat, HF3.pe, HF3.se)

## HF4 
HF4.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF4/collapsed_contig_gene_stats.tsv"
HF4.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF4/pair_counts.tsv"
HF4.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF4/single_counts.tsv"

HF4.plots <- plot_dat(HF4.dat, HF4.pe, HF4.se)

## HF5 
HF5.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF5/collapsed_contig_gene_stats.tsv"
HF5.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF5/pair_counts.tsv"
HF5.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/HF5/single_counts.tsv"

HF5.plots <- plot_dat(HF5.dat, HF5.pe, HF5.se)

## WW1 
WW1.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/WW1/collapsed_contig_gene_stats.tsv"
WW1.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/WW1/pair_counts.tsv"
WW1.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/WW1/single_counts.tsv"

WW1.plots <- plot_dat(WW1.dat, WW1.pe, WW1.se)

## WW2 
WW2.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/WW2/collapsed_contig_gene_stats.tsv"
WW2.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/WW2/pair_counts.tsv"
WW2.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/WW2/single_counts.tsv"

WW2.plots <- plot_dat(WW2.dat, WW2.pe, WW2.se)

## WW3 
WW3.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/WW3/collapsed_contig_gene_stats.tsv"
WW3.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/WW3/pair_counts.tsv"
WW3.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/WW3/single_counts.tsv"

WW3.plots <- plot_dat(WW3.dat, WW3.pe, WW3.se)

## WW4 
WW4.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/WW4/collapsed_contig_gene_stats.tsv"
WW4.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/WW4/pair_counts.tsv"
WW4.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/WW4/single_counts.tsv"

WW4.plots <- plot_dat(WW4.dat, WW4.pe, WW4.se)

## BG 
BG.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/BG/collapsed_contig_gene_stats.tsv"
BG.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/BG/pair_counts.tsv"
BG.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/MT_assemblies/BG/single_counts.tsv"

BG.plots <- plot_dat(BG.dat, BG.pe, BG.se)

## Labels for all files
all.labels <- c("SM",
		"HF1",
		"HF2",
		"HF3",
		"HF4",
		"HF5",
		"WW1",
		"WW2",
		"WW3",
		"WW4",
		"BG")

plots <- list(  
	  SM.plots[[1]] + guides(fill=FALSE) + mytheme() +
	  theme(axis.ticks.x = element_line(size=1), 
		axis.title.x = element_blank(),
		axis.text.x = element_blank()),

	  HF1.plots[[1]] + guides(fill=FALSE) + mytheme() +
	  theme(axis.ticks.x = element_line(size=1),
		axis.title.x = element_blank(),
		axis.text.x = element_blank()),

	  HF2.plots[[1]] + guides(fill=FALSE) + mytheme() +
	  theme(axis.ticks.x = element_line(size=1),
		axis.title.x = element_blank(),
		axis.text.x = element_blank()),

	  HF3.plots[[1]] + guides(fill=FALSE) + mytheme() +
	  theme(axis.ticks.x = element_line(size=1),
		axis.title.x = element_blank(),
		axis.text.x = element_blank()),

	  HF4.plots[[1]] + guides(fill=FALSE) + mytheme() +
	  theme(axis.ticks.x = element_line(size=1),
		axis.title.x = element_blank(),
		axis.text.x = element_blank()),

	  HF5.plots[[1]] + guides(fill=FALSE) + mytheme() +
	  theme(axis.ticks.x = element_line(size=1),
		axis.title.x = element_blank(),
		axis.text.x = element_blank()),

	  WW1.plots[[1]] + guides(fill=FALSE) + mytheme() +
	  theme(axis.ticks.x = element_line(size=1),
		axis.title.x = element_blank(),
		axis.text.x = element_blank()),

	  WW2.plots[[1]] + guides(fill=FALSE) + mytheme() +
	  theme(axis.ticks.x = element_line(size=1),
		axis.title.x = element_blank(),
		axis.text.x = element_blank()),

	  WW3.plots[[1]] + guides(fill=FALSE) + mytheme() +
	  theme(axis.ticks.x = element_line(size=1),
		axis.title.x = element_blank(),
		axis.text.x = element_blank()),
	  
          WW4.plots[[1]] + guides(fill=FALSE) + mytheme() +
	  theme(axis.ticks.x = element_line(size=1),
		axis.title.x = element_blank(),
		axis.text.x = element_blank()),

	  BG.plots[[1]] + mytheme() +
	  theme(axis.ticks.x = element_line(size=1),
		axis.title.x = element_blank(),
		axis.text.x = element_blank())
	  )

grobs = lapply(plots, ggplotGrob)
g = do.call(rbind, grobs) #  uses gridExtra::rbind.gtable
panels <- g$layout[g$layout$name=="panel",]
g <- gtable::gtable_add_grob(g, lapply(all.labels[1:nrow(panels)],
                                       textGrob, vjust=2, y=1, 
                                       gp=gpar(fontface=2, fontsize=20)), 
                             t=panels$t, l=2)

### Generate plots
pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/MT_iter_assm-supp.pdf", 
    height=48, width=20, onefile=FALSE)
grid.newpage()
grid.draw(g)
dev.off()


### Produce the complementary table
table <- rbind(cbind(data = rep("SM", nrow(SM.plots[[2]])), SM.plots[[2]]), 
	       cbind(data = rep("HF1", nrow(HF1.plots[[2]])), HF1.plots[[2]]), 
	       cbind(data = rep("HF2", nrow(HF2.plots[[2]])), HF2.plots[[2]]), 
	       cbind(data = rep("HF3", nrow(HF3.plots[[2]])), HF3.plots[[2]]), 
	       cbind(data = rep("HF4", nrow(HF4.plots[[2]])), HF4.plots[[2]]), 
	       cbind(data = rep("HF5", nrow(HF5.plots[[2]])), HF5.plots[[2]]), 
	       cbind(data = rep("WW1", nrow(WW1.plots[[2]])), WW1.plots[[2]]), 
	       cbind(data = rep("WW2", nrow(WW2.plots[[2]])), WW2.plots[[2]]), 
	       cbind(data = rep("WW3", nrow(WW3.plots[[2]])), WW3.plots[[2]]), 
	       cbind(data = rep("WW4", nrow(WW4.plots[[2]])), WW4.plots[[2]]), 
	       cbind(data = rep("BG", nrow(BG.plots[[2]])),  BG.plots[[2]]))

write.table(table, "/home/shaman/Documents/Publications/IMP-manuscript/tables/MT_iterative_assm-supp.tsv",
	    quote = F, row.names = F, sep = "\t")

