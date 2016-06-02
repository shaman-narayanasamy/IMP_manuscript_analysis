#!/bin/R
require(plyr)

load("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/HMP_IGC_mapping/HMP_IGC_mapping.Rdat")

prodigal.dat <- read.table("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/prodigal_analysis/prodigal_summary.tsv", header=T)

all.dat.3$Assembly <- mapvalues(all.dat.3$Assembly, from = c("MetAmos_MG", "MetAmos_MGMT", "IMP_IGC"),
				to = c("MetAMOS_MG", "MetAMOS_MGMT", "IGC_mapping")
)

all.dat.4 <- merge(all.dat.3, prodigal.dat, by=c("Dataset", "Assembly"), all=T)

all.dat.4 <- all.dat.4[-which(all.dat.4$Assembly%in%c("MetAMOS_MT", "MOCAT_MT", 
						      "MetAmos_IGC", "MOCAT_IGC")),]


write.table(all.dat.4, "/home/shaman/Documents/Publications/IMP-manuscript/tables/second_iteration/all_comparison-v5.tsv", sep="\t", quote=F, row.names=F)

#save.image("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/prodigal_analysis/prodigal_analyses.Rdat")
