#!/bin/R

require(ggplot2)
require(reshape)
library(grid)
library(gridExtra)
library(scales)
library(gtable)
library(cowplot)
require(stringr)

set_panel_size <- function(p=NULL, g=ggplotGrob(p), width=unit(3, "cm"), height=unit(3, "cm")){
  panel_index_w<- g$layout$l[g$layout$name=="panel"]
  panel_index_h<- g$layout$t[g$layout$name=="panel"]
  g$widths[[panel_index_w]] <- width
  g$heights[[panel_index_h]] <- height
  class(g) <- c("fixed", class(g), "ggplot")
  g
}

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
dat <- read.delim(dat.file)

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
se$additional_mapped[1]  <- se$mappable[1]

dat.1 <- as.data.frame(
		       cbind(iteration = as.character(1:6),
			     no.of_contigs = c(dat[1,3], dat[2:nrow(dat),c(3)] - dat[1:nrow(dat)-1,c(3)]),
			     total_length = c(dat[1,c(28)], dat[2:nrow(dat),c(28)] - dat[1:nrow(dat)-1,c(28)]),
			     no.of_genes = c(dat[1,22], dat[2:nrow(dat),c(22)] - dat[1:nrow(dat)-1,c(22)]),
			     additional_mapped = 2*(pe$additional_mapped) + se$additional_mapped
			     )
		       )

dat.1$additional_mapped <- as.numeric(as.character(dat.1$additional_mapped))
dat.1$total_length <- as.numeric(as.character(dat.1$total_length))
dat.1$no.of_contigs <- as.numeric(as.character(dat.1$no.of_contigs))
dat.1$no.of_genes <- as.numeric(as.character(dat.1$no.of_genes))
dat.1 <- dat.1[-nrow(dat.1),]

m.dat.1 <- melt(dat.1)
colnames(m.dat.1) <- c("iteration", "type", "count")
m.dat.1$count[m.dat.1$count==0] = NA

m.dat.1$type <- factor(m.dat.1$type, levels(m.dat.1$type)[c(2,4,3,1)])

p1 <- ggplot(data=m.dat.1, aes(x=iteration, y=log10(count), fill=type)) + 
geom_bar(stat="identity", position="dodge") +
scale_fill_manual(values = c("darkorange1", "lightseagreen", "salmon", "seagreen"), 
		    labels = c("no.of_contigs" = "no. of contigs \u2265 1kb", 
			       "total_length" = "total length", 
			       "no.of_genes" = "no. of genes",
			       "additional_mapped" = "mappable reads")
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

HF.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/X310763260-iterative_MG/collapsed_contigs_stats.tsv"
HF.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/X310763260-iterative_MG/pair_counts.tsv"
HF.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/X310763260-iterative_MG/single_counts.tsv"

HF.plots <- plot_dat(HF.dat, HF.pe, HF.se)

WW.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/A02-iterative_MG/collapsed_contigs_stats.tsv"
WW.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/A02-iterative_MG/pair_counts.tsv"
WW.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/A02-iterative_MG/single_counts.tsv"

WW.plots <- plot_dat(WW.dat, WW.pe, WW.se)

SD.dat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/simDat-iterative_MG/collapsed_contigs_stats-edited.tsv.csv"
SD.pe <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/simDat-iterative_MG/pair_counts-edited.tsv.csv"
SD.se <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/iterative_assembly/simDat-iterative_MG/single_counts-edited.tsv.csv"

SD.plots <- plot_dat(SD.dat, SD.pe, SD.se)

set_panel_size(SD.plots[[1]])
set_panel_size(HF.plots[[1]])
set_panel_size(WW.plots[[1]])

### Generate plots
pdf("/home/shaman/Documents/Publications/IMP-manuscript/figures/MG_iter_assm-v5.pdf", 
    height=16, width=20)
plot_grid(
	  SD.plots[[1]] + guides(fill=FALSE) + mytheme() +
	  theme(axis.ticks.x = element_line(size=1), 
		axis.title.x = element_blank(),
		axis.text.x = element_blank()),

	  HF.plots[[1]] + guides(fill=FALSE) + mytheme() +
	  theme(axis.ticks.x = element_line(size=1),
		axis.title.x = element_blank(),
		axis.text.x = element_blank()),

	  WW.plots[[1]] + mytheme() +
	  theme(axis.ticks.x = element_line(size=1),
		axis.title.x = element_blank(),
		axis.text.x = element_blank()),

	  ncol=1, align="v", labels=c("(A)", "(B)", "(C)"), label_size=45, hjust=-0.5)
dev.off()

### Produce the complementary table
table <- rbind(cbind(data = rep("SM", nrow(SD.plots[[2]])), SD.plots[[2]]), 
	       cbind(data = rep("HF", nrow(HF.plots[[2]])), HF.plots[[2]]), 
	       cbind(data = rep("WW", nrow(WW.plots[[2]])),  WW.plots[[2]]))

write.table(table, "/home/shaman/Documents/Publications/IMP-manuscript/tables/MG_iterative_assm.tsv",
	    quote = F, row.names = F, sep = "\t")

