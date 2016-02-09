#!/bin/R

### This script is deprecated

require(stringr)
require(ggplot2)
require(xtable)

MG.list <- system("ls /home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/*/Analysis/results/MG.read_stats.txt", intern=T)
MT.list <- system("ls /home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/datasets/IMP_analysis/*/Analysis/results/MT.read_stats.txt", intern=T)

########################################################################
## Initialize functions

# Function to merge preprocessing statistics
merge.dat <- function(dat.list){
	dat <- read.delim(dat.list[1])
	labels <- str_split_fixed(dat.list, "/", 11)[,10]
	colnames(dat)[ncol(dat)] <- labels[1]
	
	for (i in 2:length(dat.list)){
	    dat <- merge(dat, read.delim(dat.list[i]), by=c("filtering","type"))
	    colnames(dat)[ncol(dat)] <- labels[i]
	}
	return(dat)
}

MG.dat <- merge.dat(MG.list)
MT.dat <- merge.dat(MT.list)
# Need to remove this later
MG.dat <- MG.dat[-3,]

write.table(MG.dat, "MG_preprocessing.txt", sep="\t", quote=F, row.names=F)
write.table(MT.dat, "MT_preprocessing.txt", sep="\t", quote=F, row.names=F)

sink(file="/home/shaman/Work/repository/IMP-manuscript/tables/MG_preprocessing.tex")
print(xtable(MG.dat), floating=F)
sink()

sink(file="/home/shaman/Work/repository/IMP-manuscript/tables/MT_preprocessing.tex")
print(xtable(MT.dat), floating=F)
sink()
