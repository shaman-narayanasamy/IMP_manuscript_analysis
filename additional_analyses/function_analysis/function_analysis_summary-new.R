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
	
	return(c(mg.only, mgmt, mt.only, hypo.num, all, 
		 mg.only/all*100, mgmt/all*100, mt.only/all*100))
}

### Function: obtain contigs represented on MG, MT and MGMT levels
contig_summary <- function(workspace){
    load(workspace)
    mgmt <- nrow(all.dat) - length(which(is.na(all.dat$MG_depth))) - length(which(is.na(all.dat$MT_depth)))
    mg.only <- length(which(is.na(all.dat$MT_depth))) 
    mt.only <- length(which(is.na(all.dat$MG_depth))) 
    all <- nrow(all.dat)
    return(c(mg.only, mgmt, mt.only, all,
	     mg.only/all*100, mgmt/all*100, mt.only/all*100))
}

### Read in flagstat data
samples <- c("SM", "HF1", "HF2", "HF3", "HF4", "HF5", "WW1", "WW2", "WW3", "WW4", "BG")
indir <- "/scratch/users/snarayanasamy/IMP_MS_data/IMP_analysis"

dat <- data.frame(Dataset=as.character(),
		  MG_contigs=as.numeric(),
		  MGMT_contigs=as.numeric(),
		  MT_contigs=as.numeric(),
		  MG_fraction=as.numeric(),
		  MGMT_fraction=as.numeric(),
		  MT_fraction=as.numeric()
		  )

for(i in seq <- along(samples)){ 
    dat <- rbind(dat, c(samples[i], 
			contig_summary(paste(indir, samples[i], 
					     "Analysis/result/MGMT_results.Rdat", sep="/"))
			)
    )
}


