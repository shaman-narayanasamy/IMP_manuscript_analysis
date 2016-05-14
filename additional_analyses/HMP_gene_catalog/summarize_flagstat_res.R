## Reading in the flagstat files

### Function: Read in and process flagstat data
read.flagstat <- function(flagstat.file){
dat <- cbind.data.frame( 
	     c(
	    "total",
	    "duplicates",
	    "mapped",
	    "paired_in_seq",
	    "read1",
	    "read2",
	    "properly_paired",
	    "itself_mate",
	    "singletons",
	    "mate_diff_chr",
	    "mate_diff_chr(mapq5)"
	    ), 
	  as.numeric(read.delim(flagstat.file, 
				header=F, sep=" ", stringsAsFactors=F)[-12,1])
    )
colnames(dat) <- c("reads", "count")
as.numeric(dat$count)

dat <- cbind.data.frame(dat, fraction=round(dat$count / dat[1,2] * 100, digits=2))
return(dat)
}

### Read in flagstat data
samples <- c("HF1", "HF2", "HF3", "HF4", "HF5")
indir.flagstat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/HMP_IGC_mapping"

#####################################################################################################################################
### IMP
#####################################################################################################################################
## MG data mapping to IGC
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MG_IMP_x_HMP", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MG_", "IMP_", "x_", "HMP.sorted_flagstat.txt", sep="")
		       ))
}

## MT data mapping to IGC
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MT_IMP_x_HMP", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MT_", "IMP_", "x_", "HMP.sorted_flagstat.txt", sep="")
		       ))
}

#####################################################################################################################################
### MOCAT
#####################################################################################################################################
## MG data mapping to IGC
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MG_MOCAT_x_HMP", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MG_", "MOCAT_", "x_", "HMP.sorted_flagstat.txt", sep="")
		       ))
}

## MT data mapping to IGC
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MT_MOCAT_x_HMP", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MT_", "MOCAT_", "x_", "HMP.sorted_flagstat.txt", sep="")
		       ))
}

#####################################################################################################################################
### metAmos
#####################################################################################################################################
## MG data mapping to IGC
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MG_metAmos_x_HMP", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MG_", "metAmos_", "x_", "HMP.sorted_flagstat.txt", sep="")
		       ))
}

## MT data mapping to IGC
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MT_metAmos_x_HMP", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MT_", "metAmos_", "x_", "HMP.sorted_flagstat.txt", sep="")
		       ))
}

assms <- c("IMP", "MOCAT", "MetAmos")

#####################################################################################################################################
### HF1 data summary
#####################################################################################################################################

HF1.reads <- 
rbind.data.frame(
		cbind.data.frame(rep("HF1", 3), assms,
		## MG total mapped
		c(
		  HF1_MG_IMP_x_HMP$fraction[3],
		  HF1_MG_MOCAT_x_HMP$fraction[3],
		  HF1_MG_metAmos_x_HMP$fraction[3]
		),
		## MG properly paired
		c(
		  HF1_MG_IMP_x_HMP$fraction[[7]],
		  HF1_MG_MOCAT_x_HMP$fraction[[7]],
		  HF1_MG_metAmos_x_HMP$fraction[[7]]
		),
	
		## MT total mapped
		c(
		  HF1_MT_IMP_x_HMP$fraction[3],
		  HF1_MT_MOCAT_x_HMP$fraction[3],
		  HF1_MT_metAmos_x_HMP$fraction[3]
		),
		## MT properly paired
		c(
		  HF1_MT_IMP_x_HMP$fraction[[7]],
		  HF1_MT_MOCAT_x_HMP$fraction[[7]],
		  HF1_MT_metAmos_x_HMP$fraction[[7]]
		)
)
)

colnames(HF1.reads) <- c("Dataset", "Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### HF2 data summary
#####################################################################################################################################

HF2.reads <- 
rbind.data.frame(
		cbind.data.frame(rep("HF2", 3), assms,
		## MG total mapped
		c(
		  HF2_MG_IMP_x_HMP$fraction[3],
		  HF2_MG_MOCAT_x_HMP$fraction[3],
		  HF2_MG_metAmos_x_HMP$fraction[3]
		),
		## MG properly paired
		c(
		  HF2_MG_IMP_x_HMP$fraction[[7]],
		  HF2_MG_MOCAT_x_HMP$fraction[[7]],
		  HF2_MG_metAmos_x_HMP$fraction[[7]]
		),
	
		## MT total mapped
		c(
		  HF2_MT_IMP_x_HMP$fraction[3],
		  HF2_MT_MOCAT_x_HMP$fraction[3],
		  HF2_MT_metAmos_x_HMP$fraction[3]
		),
		## MT properly paired
		c(
		  HF2_MT_IMP_x_HMP$fraction[[7]],
		  HF2_MT_MOCAT_x_HMP$fraction[[7]],
		  HF2_MT_metAmos_x_HMP$fraction[[7]]
		)
)
)

colnames(HF2.reads) <- c("Dataset", "Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### HF3 data summary
#####################################################################################################################################

HF3.reads <- 
rbind.data.frame(
		cbind.data.frame(rep("HF3", 3), assms,
		## MG total mapped
		c(
		  HF3_MG_IMP_x_HMP$fraction[3],
		  HF3_MG_MOCAT_x_HMP$fraction[3],
		  HF3_MG_metAmos_x_HMP$fraction[3]
		),
		## MG properly paired
		c(
		  HF3_MG_IMP_x_HMP$fraction[[7]],
		  HF3_MG_MOCAT_x_HMP$fraction[[7]],
		  HF3_MG_metAmos_x_HMP$fraction[[7]]
		),
	
		## MT total mapped
		c(
		  HF3_MT_IMP_x_HMP$fraction[3],
		  HF3_MT_MOCAT_x_HMP$fraction[3],
		  HF3_MT_metAmos_x_HMP$fraction[3]
		),
		## MT properly paired
		c(
		  HF3_MT_IMP_x_HMP$fraction[[7]],
		  HF3_MT_MOCAT_x_HMP$fraction[[7]],
		  HF3_MT_metAmos_x_HMP$fraction[[7]]
		)
)
)

colnames(HF3.reads) <- c("Dataset", "Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### HF4 data summary
#####################################################################################################################################

HF4.reads <- 
rbind.data.frame(
		cbind.data.frame(rep("HF4", 3), assms,
		## MG total mapped
		c(
		  HF4_MG_IMP_x_HMP$fraction[3],
		  HF4_MG_MOCAT_x_HMP$fraction[3],
		  HF4_MG_metAmos_x_HMP$fraction[3]
		),
		## MG properly paired
		c(
		  HF4_MG_IMP_x_HMP$fraction[[7]],
		  HF4_MG_MOCAT_x_HMP$fraction[[7]],
		  HF4_MG_metAmos_x_HMP$fraction[[7]]
		),
	
		## MT total mapped
		c(
		  HF4_MT_IMP_x_HMP$fraction[3],
		  HF4_MT_MOCAT_x_HMP$fraction[3],
		  HF4_MT_metAmos_x_HMP$fraction[3]
		),
		## MT properly paired
		c(
		  HF4_MT_IMP_x_HMP$fraction[[7]],
		  HF4_MT_MOCAT_x_HMP$fraction[[7]],
		  HF4_MT_metAmos_x_HMP$fraction[[7]]
		)
)
)

colnames(HF4.reads) <- c("Dataset", "Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### HF5 data summary
#####################################################################################################################################

HF5.reads <- 
rbind.data.frame(
		cbind.data.frame(rep("HF5", 3), assms,
		## MG total mapped
		c(
		  HF5_MG_IMP_x_HMP$fraction[3],
		  HF5_MG_MOCAT_x_HMP$fraction[3],
		  HF5_MG_metAmos_x_HMP$fraction[3]
		),
		## MG properly paired
		c(
		  HF5_MG_IMP_x_HMP$fraction[[7]],
		  HF5_MG_MOCAT_x_HMP$fraction[[7]],
		  HF5_MG_metAmos_x_HMP$fraction[[7]]
		),
	
		## MT total mapped
		c(
		  HF5_MT_IMP_x_HMP$fraction[3],
		  HF5_MT_MOCAT_x_HMP$fraction[3],
		  HF5_MT_metAmos_x_HMP$fraction[3]
		),
		## MT properly paired
		c(
		  HF5_MT_IMP_x_HMP$fraction[[7]],
		  HF5_MT_MOCAT_x_HMP$fraction[[7]],
		  HF5_MT_metAmos_x_HMP$fraction[[7]]
		)
)
)

colnames(HF5.reads) <- c("Dataset", "Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

## Join all the dat
HMP.mapped <- rbind(HF1.reads, HF2.reads, HF3.reads, HF4.reads, HF5.reads)
colnames(HMP.mapped) <- c("Dataset", "Assembly", "MG_mapped_IGC","MG_properly_paired_IGC","MT_mapped_IGC","MT_properly_paired_IGC")

#levels(HMP.mapped$Assembly) <- c(levels(HMP.mapped$Assembly), "IMP-megahit")
#
#tmp <- HMP.mapped[HMP.mapped$Assembly=="IMP",]
#tmp$Assembly= c(rep("IMP-megahit", nrow(tmp)))
#HMP.mapped <- rbind(HMP.mapped, tmp)

## read table from comparison
all.dat <- read.delim("/home/shaman/Documents/Publications/IMP-manuscript/tables/second_iteration/all_comparison.tsv")

hf.dat <- all.dat[all.dat$Dataset==samples,c(1:2,28:31)]

#merge(hf.dat, HMP.mapped, by=c("Dataset", "Assembly"))

## Save image
save.image("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/HMP_IGC_mapping/HMP_IGC_mapping.Rdat")


