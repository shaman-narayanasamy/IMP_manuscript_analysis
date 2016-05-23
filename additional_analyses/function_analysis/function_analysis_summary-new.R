#!/bin/R
require(xtable)
require(genomeIntervals)
require(ggplot2)
require(reshape)
require(cowplot)
require(grid)
require(gridExtra)

### Function: obtain genes represented on MG, MT and MGMT levels
get_expressed <- function(MG.file, MT.file, workspace){
	# Read metagenomic depth of coverage table
	mg.dat <- read.table(MG.file)
	# Read metatranscriptomic depth of coverage table
	mt.dat <- read.table(MT.file)

        load(workspace)

	ID2function <- getGffAttribute(annot, c("ID", "product"))

        # Change column names
	colnames(mg.dat) <- c("ID", "MG_depth")
	colnames(mt.dat) <- c("ID", "MT_depth")
        
        # Merge data	
	dat <- merge(mg.dat, mt.dat, by="ID", incomparables=0)
	dat <- merge(dat, ID2function, by="ID", incomparables=0)

	# all rows
	all <- nrow(dat)

	# Genes only in MT
	mt.only <- nrow(dat[dat$MG_depth==0, ])

	# Genes only in MG
	mg.only <- nrow(dat[dat$MT_depth==0, ])

	# Genes only in both MG and MT
	mgmt <- all-mg.only-mt.only
        
	# Obtain hypothetical proteins
	hypo <- dat[grep("hypothetical", dat$product),]

	hypo.num <- nrow(hypo[hypo$MT_depth > 5,])
	
	return(c(all, mg.only, mgmt, mt.only,
		 mg.only/all*100, mgmt/all*100, mt.only/all*100))
}

### Function: obtain contigs represented on MG, MT and MGMT levels
contig_summary <- function(workspace){
    load(workspace)
    mgmt <- nrow(all.dat) - length(which(is.na(all.dat$MG_depth))) - length(which(is.na(all.dat$MT_depth)))
    mg.only <- length(which(is.na(all.dat$MT_depth))) 
    mt.only <- length(which(is.na(all.dat$MG_depth))) 
    all <- nrow(all.dat)
    return(c(all, mg.only, mgmt, mt.only,
	     mg.only/all*100, mgmt/all*100, mt.only/all*100))
    #rm(list=ls())
}

### Read in all the different Rdat workspaces
samples <- c("SM", "HF1", "HF2", "HF3", "HF4", "HF5", "WW1", "WW2", "WW3", "WW4", "BG")
indir <- "/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis"

contigs <- data.frame(Dataset=as.character(),
		  ALL_contigs=as.numeric(),
		  MG_contigs=as.numeric(),
		  MGMT_contigs=as.numeric(),
		  MT_contigs=as.numeric(),
		  MG_contigs_fraction=as.numeric(),
		  MGMT_contigs_fraction=as.numeric(),
		  MT_contigs_fraction=as.numeric()
		  )

### Bind the contigsa together
for(i in seq_along(samples)){ 
    line <- c(samples[i], contig_summary(paste(indir, samples[i], "Analysis/results/MGMT_results.Rcontigs", sep="/")))
   
    contigs <- rbind.data.frame(contigs, 
	    data.frame(Dataset=as.character(line[1]),
	    		  ALL_contigs=as.numeric(line[2]),
	    		  MG_contigs=as.numeric(line[3]),
	    		  MGMT_contigs=as.numeric(line[4]),
	    		  MT_contigs=as.numeric(line[5]),
	    		  MG_contigs_fraction=as.numeric(line[6]),
	    		  MGMT_contigs_fraction=as.numeric(line[7]),
	    		  MT_contigs_fraction=as.numeric(line[8])
	    		  ) 
	    )
}

genes <- data.frame(Dataset=as.character(),
		  ALL_genes=as.numeric(),
		  MG_genes=as.numeric(),
		  MGMT_genes=as.numeric(),
		  MT_genes=as.numeric(),
		  MG_genes_fraction=as.numeric(),
		  MGMT_genes_fraction=as.numeric(),
		  MT_genes_fraction=as.numeric()
		  )

for(i in seq_along(samples)){ 
    line <- c(samples[i], get_expressed(
					paste(indir, samples[i], "Analysis/MG.gene_depth.avg", sep="/"),
					paste(indir, samples[i], "Analysis/MT.gene_depth.avg", sep="/"),
					paste(indir, samples[i], "Analysis/results/MGMT_results.Rdat", sep="/")
					))
   
    genes <- rbind.data.frame(genes, 
	    data.frame(Dataset=as.character(line[1]),
	    		  ALL_genes=as.numeric(line[2]),
	    		  MG_genes=as.numeric(line[3]),
	    		  MGMT_genes=as.numeric(line[4]),
	    		  MT_genes=as.numeric(line[5]),
	    		  MG_genes_fraction=as.numeric(line[6]),
	    		  MGMT_genes_fraction=as.numeric(line[7]),
	    		  MT_genes_fraction=as.numeric(line[8])
	    		  ) 
	    )
}



write.table(dat, "/scratch/users/snarayanasamy/IMP_MS_data/IMP_data_usage/IMP_data_usage.tsv", sep="\t", quote=F, row.names=F)
