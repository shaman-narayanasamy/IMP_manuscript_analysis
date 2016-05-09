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
samples <- c("SM", "HF1", "HF2", "HF3", "HF4", "HF5", "WW1", "WW2", "WW3", "WW4", "BG")
indir.flagstat <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/comparison/data_usage"

#####################################################################################################################################
### IMP
#####################################################################################################################################

## MG data usage of IMP default
for(i in seq_along(samples)){
  assign(paste(samples[i], "_IMP_MG_x_MGMT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "IMP", "/", "default", "/", "MG_reads-x-_MGMT-assm.flagstat.txt", sep="")
		       ))
}

## MT data usage of IMP default
for(i in seq_along(samples)){
  assign(paste(samples[i], "_IMP_MT_x_MGMT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "IMP", "/", "default", "/", "MT_reads-x-_MGMT-assm.flagstat.txt", sep="")
		       ))
}

## MG data usage of IMP megahit
for(i in seq_along(samples)){
  assign(paste(samples[i], "_IMP-megahit_MG_x_MGMT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "IMP", "/", "megahit", "/", "MG_reads-x-_MGMT-assm.flagstat.txt", sep="")
		       ))
}

## MG data usage of IMP megahit
for(i in seq_along(samples)){
  assign(paste(samples[i], "_IMP-megahit_MT_x_MGMT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "IMP", "/", "megahit", "/", "MT_reads-x-_MGMT-assm.flagstat.txt", sep="")
		       ))
}

## MG data usage of IMP-MG
for(i in seq_along(samples)){
  assign(paste(samples[i], "_IMP_MG_x_MG", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "IMP", "/", "MG_reads-x-_MG-assm.flagstat.txt", sep="")
		       ))
}

## MT data usage of IMP-MG
for(i in seq_along(samples)){
  assign(paste(samples[i], "_IMP_MT_x_MG", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "IMP", "/", "MT_reads-x-_MG-assm.flagstat.txt", sep="")
		       ))
}

## MG data usage of IMP-MT
for(i in seq_along(samples)){
  assign(paste(samples[i], "_IMP_MG_x_MT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "IMP", "/", "MG_reads-x-_MT-assm.flagstat.txt", sep="")
		       ))
}

## MT data usage of IMP-MT
for(i in seq_along(samples)){
  assign(paste(samples[i], "_IMP_MT_x_MT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "IMP", "/", "MT_reads-x-_MT-assm.flagstat.txt", sep="")
		       ))
}

#####################################################################################################################################
### MOCAT
#####################################################################################################################################

## MG data usage of MOCAT-MGMT
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MOCAT_MG_x_MGMT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MOCAT", "/", "MG_reads-x-_MGMT-assm.flagstat.txt", sep="")
		       ))
}

## MT data usage of MOCAT-MGMT
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MOCAT_MT_x_MGMT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MOCAT", "/", "MT_reads-x-_MGMT-assm.flagstat.txt", sep="")
		       ))
}

## MG data usage of MOCAT-MG
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MOCAT_MG_x_MG", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MOCAT", "/", "MG_reads-x-_MG-assm.flagstat.txt", sep="")
		       ))
}

## MT data usage of MOCAT-MG
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MOCAT_MT_x_MG", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MOCAT", "/", "MT_reads-x-_MG-assm.flagstat.txt", sep="")
		       ))
}

## MG data usage of MOCAT-MT
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MOCAT_MG_x_MT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MOCAT", "/", "MG_reads-x-_MT-assm.flagstat.txt", sep="")
		       ))
}

## MT data usage of MOCAT-MT
for(i in seq_along(samples)){
  assign(paste(samples[i], "_MOCAT_MT_x_MT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "MOCAT", "/", "MT_reads-x-_MT-assm.flagstat.txt", sep="")
		       ))
}

#####################################################################################################################################
### metAmos
#####################################################################################################################################

## MG data usage of metAmos-MGMT
for(i in seq_along(samples)){
  assign(paste(samples[i], "_metAmos_MG_x_MGMT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "metAmos", "/", "MG_reads-x-_MGMT-assm.flagstat.txt", sep="")
		       ))
}

## MT data usage of metAmos-MGMT
for(i in seq_along(samples)){
  assign(paste(samples[i], "_metAmos_MT_x_MGMT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "metAmos", "/", "MT_reads-x-_MGMT-assm.flagstat.txt", sep="")
		       ))
}

## MG data usage of metAmos-MG
for(i in seq_along(samples)){
  assign(paste(samples[i], "_metAmos_MG_x_MG", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "metAmos", "/", "MG_reads-x-_MG-assm.flagstat.txt", sep="")
		       ))
}

## MT data usage of metAmos-MG
for(i in seq_along(samples)){
  assign(paste(samples[i], "_metAmos_MT_x_MG", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "metAmos", "/", "MT_reads-x-_MG-assm.flagstat.txt", sep="")
		       ))
}

## MG data usage of metAmos-MT
for(i in seq_along(samples)){
  assign(paste(samples[i], "_metAmos_MG_x_MT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "metAmos", "/", "MG_reads-x-_MT-assm.flagstat.txt", sep="")
		       ))
}

## MT data usage of metAmos-MT
for(i in seq_along(samples)){
  assign(paste(samples[i], "_metAmos_MT_x_MT", sep=""), 
	 read.flagstat(
		       paste(indir.flagstat, "/", samples[i], "/", "metAmos", "/", "MT_reads-x-_MT-assm.flagstat.txt", sep="")
		       ))
}


assms <- c("IMP", "IMP-megahit", "MOCAT_MGMT", "MetAmos_MGMT", "IMP_MG", "MOCAT_MG", "MetAmos_MG", "IMP_MT", "MOCAT_MT", "MetAmos_MT")

#####################################################################################################################################
### SM data summary
#####################################################################################################################################

SM.reads <- 
rbind.data.frame(
		cbind.data.frame(assms,
		## MG total mapped
		c(
		  SM_IMP_MG_x_MGMT$fraction[3],
		  get("SM_IMP-megahit_MG_x_MGMT")$fraction[3],
		  SM_MOCAT_MG_x_MGMT$fraction[3],
		  SM_metAmos_MG_x_MGMT$fraction[3],
		  # MG assm
		  SM_IMP_MG_x_MG$fraction[3],
		  SM_MOCAT_MG_x_MG$fraction[3],
		  SM_metAmos_MG_x_MG$fraction[3],
		  # MT assm
		  SM_IMP_MG_x_MT$fraction[3],
		  SM_MOCAT_MG_x_MT$fraction[3],
		  SM_metAmos_MG_x_MT$fraction[3]
		),
		
		## MG properly paired
		c(
		  SM_IMP_MG_x_MGMT$fraction[7],
		  get("SM_IMP-megahit_MG_x_MGMT")$fraction[7],
		  SM_MOCAT_MG_x_MGMT$fraction[7],
		  SM_metAmos_MG_x_MGMT$fraction[7],
		  # MG assm
		  SM_IMP_MG_x_MG$fraction[7],
		  SM_MOCAT_MG_x_MG$fraction[7],
		  SM_metAmos_MG_x_MG$fraction[7],
		  # MT assm
		  SM_IMP_MG_x_MT$fraction[7],
		  SM_MOCAT_MG_x_MT$fraction[7],
		  SM_metAmos_MG_x_MT$fraction[7]
		),
		
		## MT total mapped
		c(
		  SM_IMP_MT_x_MGMT$fraction[3],
		  get("SM_IMP-megahit_MT_x_MGMT")$fraction[3],
		  SM_MOCAT_MT_x_MGMT$fraction[3],
		  SM_metAmos_MT_x_MGMT$fraction[3],
		  # MG assm
		  SM_IMP_MT_x_MG$fraction[3],
		  SM_MOCAT_MT_x_MG$fraction[3],
		  SM_metAmos_MT_x_MG$fraction[3],
		  # MT assm
		  SM_IMP_MT_x_MT$fraction[3],
		  SM_MOCAT_MT_x_MT$fraction[3],
		  SM_metAmos_MT_x_MT$fraction[3]
		),
		
		## MT properly paired
		c(
		  SM_IMP_MT_x_MGMT$fraction[7],
		  get("SM_IMP-megahit_MT_x_MGMT")$fraction[7],
		  SM_MOCAT_MT_x_MGMT$fraction[7],
		  SM_metAmos_MT_x_MGMT$fraction[7],
		  # MG assm
		  SM_IMP_MT_x_MG$fraction[7],
		  SM_MOCAT_MT_x_MG$fraction[7],
		  SM_metAmos_MT_x_MG$fraction[7],
		  # MT assm
		  SM_IMP_MT_x_MT$fraction[7],
		  SM_MOCAT_MT_x_MT$fraction[7],
		  SM_metAmos_MT_x_MT$fraction[7]
		)
)
)

colnames(SM.reads) <- c("Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### HF1 data summary
#####################################################################################################################################

HF1.reads <- 
rbind.data.frame(
		cbind.data.frame(assms,
		## MG total mapped
		c(
		  HF1_IMP_MG_x_MGMT$fraction[3],
		  get("HF1_IMP-megahit_MG_x_MGMT")$fraction[3],
		  HF1_MOCAT_MG_x_MGMT$fraction[3],
		  HF1_metAmos_MG_x_MGMT$fraction[3],
		  # MG assm
		  HF1_IMP_MG_x_MG$fraction[3],
		  HF1_MOCAT_MG_x_MG$fraction[3],
		  HF1_metAmos_MG_x_MG$fraction[3],
		  # MT assm
		  HF1_IMP_MG_x_MT$fraction[3],
		  HF1_MOCAT_MG_x_MT$fraction[3],
		  HF1_metAmos_MG_x_MT$fraction[3]
		),
		
		## MG properly paired
		c(
		  HF1_IMP_MG_x_MGMT$fraction[7],
		  get("HF1_IMP-megahit_MG_x_MGMT")$fraction[7],
		  HF1_MOCAT_MG_x_MGMT$fraction[7],
		  HF1_metAmos_MG_x_MGMT$fraction[7],
		  # MG assm
		  HF1_IMP_MG_x_MG$fraction[7],
		  HF1_MOCAT_MG_x_MG$fraction[7],
		  HF1_metAmos_MG_x_MG$fraction[7],
		  # MT assm
		  HF1_IMP_MG_x_MT$fraction[7],
		  HF1_MOCAT_MG_x_MT$fraction[7],
		  HF1_metAmos_MG_x_MT$fraction[7]
		),
		
		## MT total mapped
		c(
		  HF1_IMP_MT_x_MGMT$fraction[3],
		  get("HF1_IMP-megahit_MT_x_MGMT")$fraction[3],
		  HF1_MOCAT_MT_x_MGMT$fraction[3],
		  HF1_metAmos_MT_x_MGMT$fraction[3],
		  # MG assm
		  HF1_IMP_MT_x_MG$fraction[3],
		  HF1_MOCAT_MT_x_MG$fraction[3],
		  HF1_metAmos_MT_x_MG$fraction[3],
		  # MT assm
		  HF1_IMP_MT_x_MT$fraction[3],
		  HF1_MOCAT_MT_x_MT$fraction[3],
		  HF1_metAmos_MT_x_MT$fraction[3]
		),
		
		## MT properly paired
		c(
		  HF1_IMP_MT_x_MGMT$fraction[7],
		  get("HF1_IMP-megahit_MT_x_MGMT")$fraction[7],
		  HF1_MOCAT_MT_x_MGMT$fraction[7],
		  HF1_metAmos_MT_x_MGMT$fraction[7],
		  # MG assm
		  HF1_IMP_MT_x_MG$fraction[7],
		  HF1_MOCAT_MT_x_MG$fraction[7],
		  HF1_metAmos_MT_x_MG$fraction[7],
		  # MT assm
		  HF1_IMP_MT_x_MT$fraction[7],
		  HF1_MOCAT_MT_x_MT$fraction[7],
		  HF1_metAmos_MT_x_MT$fraction[7]
		)
)
)

colnames(HF1.reads) <- c("Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### HF2 data summary
#####################################################################################################################################

HF2.reads <- 
rbind.data.frame(
		cbind.data.frame(assms,
		## MG total mapped
		c(
		  HF2_IMP_MG_x_MGMT$fraction[3],
		  get("HF2_IMP-megahit_MG_x_MGMT")$fraction[3],
		  HF2_MOCAT_MG_x_MGMT$fraction[3],
		  HF2_metAmos_MG_x_MGMT$fraction[3],
		  # MG assm
		  HF2_IMP_MG_x_MG$fraction[3],
		  HF2_MOCAT_MG_x_MG$fraction[3],
		  HF2_metAmos_MG_x_MG$fraction[3],
		  # MT assm
		  HF2_IMP_MG_x_MT$fraction[3],
		  HF2_MOCAT_MG_x_MT$fraction[3],
		  HF2_metAmos_MG_x_MT$fraction[3]
		),
		
		## MG properly paired
		c(
		  HF2_IMP_MG_x_MGMT$fraction[7],
		  get("HF2_IMP-megahit_MG_x_MGMT")$fraction[7],
		  HF2_MOCAT_MG_x_MGMT$fraction[7],
		  HF2_metAmos_MG_x_MGMT$fraction[7],
		  # MG assm
		  HF2_IMP_MG_x_MG$fraction[7],
		  HF2_MOCAT_MG_x_MG$fraction[7],
		  HF2_metAmos_MG_x_MG$fraction[7],
		  # MT assm
		  HF2_IMP_MG_x_MT$fraction[7],
		  HF2_MOCAT_MG_x_MT$fraction[7],
		  HF2_metAmos_MG_x_MT$fraction[7]
		),
		
		## MT total mapped
		c(
		  HF2_IMP_MT_x_MGMT$fraction[3],
		  get("HF2_IMP-megahit_MT_x_MGMT")$fraction[3],
		  HF2_MOCAT_MT_x_MGMT$fraction[3],
		  HF2_metAmos_MT_x_MGMT$fraction[3],
		  # MG assm
		  HF2_IMP_MT_x_MG$fraction[3],
		  HF2_MOCAT_MT_x_MG$fraction[3],
		  HF2_metAmos_MT_x_MG$fraction[3],
		  # MT assm
		  HF2_IMP_MT_x_MT$fraction[3],
		  HF2_MOCAT_MT_x_MT$fraction[3],
		  HF2_metAmos_MT_x_MT$fraction[3]
		),
		
		## MT properly paired
		c(
		  HF2_IMP_MT_x_MGMT$fraction[7],
		  get("HF2_IMP-megahit_MT_x_MGMT")$fraction[7],
		  HF2_MOCAT_MT_x_MGMT$fraction[7],
		  HF2_metAmos_MT_x_MGMT$fraction[7],
		  # MG assm
		  HF2_IMP_MT_x_MG$fraction[7],
		  HF2_MOCAT_MT_x_MG$fraction[7],
		  HF2_metAmos_MT_x_MG$fraction[7],
		  # MT assm
		  HF2_IMP_MT_x_MT$fraction[7],
		  HF2_MOCAT_MT_x_MT$fraction[7],
		  HF2_metAmos_MT_x_MT$fraction[7]
		)
)
)

colnames(HF2.reads) <- c("Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### HF3 data summary
#####################################################################################################################################

HF3.reads <- 
rbind.data.frame(
		cbind.data.frame(assms,
		## MG total mapped
		c(
		  HF3_IMP_MG_x_MGMT$fraction[3],
		  get("HF3_IMP-megahit_MG_x_MGMT")$fraction[3],
		  HF3_MOCAT_MG_x_MGMT$fraction[3],
		  HF3_metAmos_MG_x_MGMT$fraction[3],
		  # MG assm
		  HF3_IMP_MG_x_MG$fraction[3],
		  HF3_MOCAT_MG_x_MG$fraction[3],
		  HF3_metAmos_MG_x_MG$fraction[3],
		  # MT assm
		  HF3_IMP_MG_x_MT$fraction[3],
		  HF3_MOCAT_MG_x_MT$fraction[3],
		  HF3_metAmos_MG_x_MT$fraction[3]
		),
		
		## MG properly paired
		c(
		  HF3_IMP_MG_x_MGMT$fraction[7],
		  get("HF3_IMP-megahit_MG_x_MGMT")$fraction[7],
		  HF3_MOCAT_MG_x_MGMT$fraction[7],
		  HF3_metAmos_MG_x_MGMT$fraction[7],
		  # MG assm
		  HF3_IMP_MG_x_MG$fraction[7],
		  HF3_MOCAT_MG_x_MG$fraction[7],
		  HF3_metAmos_MG_x_MG$fraction[7],
		  # MT assm
		  HF3_IMP_MG_x_MT$fraction[7],
		  HF3_MOCAT_MG_x_MT$fraction[7],
		  HF3_metAmos_MG_x_MT$fraction[7]
		),
		
		## MT total mapped
		c(
		  HF3_IMP_MT_x_MGMT$fraction[3],
		  get("HF3_IMP-megahit_MT_x_MGMT")$fraction[3],
		  HF3_MOCAT_MT_x_MGMT$fraction[3],
		  HF3_metAmos_MT_x_MGMT$fraction[3],
		  # MG assm
		  HF3_IMP_MT_x_MG$fraction[3],
		  HF3_MOCAT_MT_x_MG$fraction[3],
		  HF3_metAmos_MT_x_MG$fraction[3],
		  # MT assm
		  HF3_IMP_MT_x_MT$fraction[3],
		  HF3_MOCAT_MT_x_MT$fraction[3],
		  HF3_metAmos_MT_x_MT$fraction[3]
		),
		
		## MT properly paired
		c(
		  HF3_IMP_MT_x_MGMT$fraction[7],
		  get("HF3_IMP-megahit_MT_x_MGMT")$fraction[7],
		  HF3_MOCAT_MT_x_MGMT$fraction[7],
		  HF3_metAmos_MT_x_MGMT$fraction[7],
		  # MG assm
		  HF3_IMP_MT_x_MG$fraction[7],
		  HF3_MOCAT_MT_x_MG$fraction[7],
		  HF3_metAmos_MT_x_MG$fraction[7],
		  # MT assm
		  HF3_IMP_MT_x_MT$fraction[7],
		  HF3_MOCAT_MT_x_MT$fraction[7],
		  HF3_metAmos_MT_x_MT$fraction[7]
		)
)
)

colnames(HF3.reads) <- c("Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### HF4 data summary
#####################################################################################################################################

HF4.reads <- 
rbind.data.frame(
		cbind.data.frame(assms,
		## MG total mapped
		c(
		  HF4_IMP_MG_x_MGMT$fraction[3],
		  get("HF4_IMP-megahit_MG_x_MGMT")$fraction[3],
		  HF4_MOCAT_MG_x_MGMT$fraction[3],
		  HF4_metAmos_MG_x_MGMT$fraction[3],
		  # MG assm
		  HF4_IMP_MG_x_MG$fraction[3],
		  HF4_MOCAT_MG_x_MG$fraction[3],
		  HF4_metAmos_MG_x_MG$fraction[3],
		  # MT assm
		  HF4_IMP_MG_x_MT$fraction[3],
		  HF4_MOCAT_MG_x_MT$fraction[3],
		  HF4_metAmos_MG_x_MT$fraction[3]
		),
		
		## MG properly paired
		c(
		  HF4_IMP_MG_x_MGMT$fraction[7],
		  get("HF4_IMP-megahit_MG_x_MGMT")$fraction[7],
		  HF4_MOCAT_MG_x_MGMT$fraction[7],
		  HF4_metAmos_MG_x_MGMT$fraction[7],
		  # MG assm
		  HF4_IMP_MG_x_MG$fraction[7],
		  HF4_MOCAT_MG_x_MG$fraction[7],
		  HF4_metAmos_MG_x_MG$fraction[7],
		  # MT assm
		  HF4_IMP_MG_x_MT$fraction[7],
		  HF4_MOCAT_MG_x_MT$fraction[7],
		  HF4_metAmos_MG_x_MT$fraction[7]
		),
		
		## MT total mapped
		c(
		  HF4_IMP_MT_x_MGMT$fraction[3],
		  get("HF4_IMP-megahit_MT_x_MGMT")$fraction[3],
		  HF4_MOCAT_MT_x_MGMT$fraction[3],
		  HF4_metAmos_MT_x_MGMT$fraction[3],
		  # MG assm
		  HF4_IMP_MT_x_MG$fraction[3],
		  HF4_MOCAT_MT_x_MG$fraction[3],
		  HF4_metAmos_MT_x_MG$fraction[3],
		  # MT assm
		  HF4_IMP_MT_x_MT$fraction[3],
		  HF4_MOCAT_MT_x_MT$fraction[3],
		  HF4_metAmos_MT_x_MT$fraction[3]
		),
		
		## MT properly paired
		c(
		  HF4_IMP_MT_x_MGMT$fraction[7],
		  get("HF4_IMP-megahit_MT_x_MGMT")$fraction[7],
		  HF4_MOCAT_MT_x_MGMT$fraction[7],
		  HF4_metAmos_MT_x_MGMT$fraction[7],
		  # MG assm
		  HF4_IMP_MT_x_MG$fraction[7],
		  HF4_MOCAT_MT_x_MG$fraction[7],
		  HF4_metAmos_MT_x_MG$fraction[7],
		  # MT assm
		  HF4_IMP_MT_x_MT$fraction[7],
		  HF4_MOCAT_MT_x_MT$fraction[7],
		  HF4_metAmos_MT_x_MT$fraction[7]
		)
)
)

colnames(HF4.reads) <- c("Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### HF5 data summary
#####################################################################################################################################

HF5.reads <- 
rbind.data.frame(
		cbind.data.frame(assms,
		## MG total mapped
		c(
		  HF5_IMP_MG_x_MGMT$fraction[3],
		  get("HF5_IMP-megahit_MG_x_MGMT")$fraction[3],
		  HF5_MOCAT_MG_x_MGMT$fraction[3],
		  HF5_metAmos_MG_x_MGMT$fraction[3],
		  # MG assm
		  HF5_IMP_MG_x_MG$fraction[3],
		  HF5_MOCAT_MG_x_MG$fraction[3],
		  HF5_metAmos_MG_x_MG$fraction[3],
		  # MT assm
		  HF5_IMP_MG_x_MT$fraction[3],
		  HF5_MOCAT_MG_x_MT$fraction[3],
		  HF5_metAmos_MG_x_MT$fraction[3]
		),
		
		## MG properly paired
		c(
		  HF5_IMP_MG_x_MGMT$fraction[7],
		  get("HF5_IMP-megahit_MG_x_MGMT")$fraction[7],
		  HF5_MOCAT_MG_x_MGMT$fraction[7],
		  HF5_metAmos_MG_x_MGMT$fraction[7],
		  # MG assm
		  HF5_IMP_MG_x_MG$fraction[7],
		  HF5_MOCAT_MG_x_MG$fraction[7],
		  HF5_metAmos_MG_x_MG$fraction[7],
		  # MT assm
		  HF5_IMP_MG_x_MT$fraction[7],
		  HF5_MOCAT_MG_x_MT$fraction[7],
		  HF5_metAmos_MG_x_MT$fraction[7]
		),
		
		## MT total mapped
		c(
		  HF5_IMP_MT_x_MGMT$fraction[3],
		  get("HF5_IMP-megahit_MT_x_MGMT")$fraction[3],
		  HF5_MOCAT_MT_x_MGMT$fraction[3],
		  HF5_metAmos_MT_x_MGMT$fraction[3],
		  # MG assm
		  HF5_IMP_MT_x_MG$fraction[3],
		  HF5_MOCAT_MT_x_MG$fraction[3],
		  HF5_metAmos_MT_x_MG$fraction[3],
		  # MT assm
		  HF5_IMP_MT_x_MT$fraction[3],
		  HF5_MOCAT_MT_x_MT$fraction[3],
		  HF5_metAmos_MT_x_MT$fraction[3]
		),
		
		## MT properly paired
		c(
		  HF5_IMP_MT_x_MGMT$fraction[7],
		  get("HF5_IMP-megahit_MT_x_MGMT")$fraction[7],
		  HF5_MOCAT_MT_x_MGMT$fraction[7],
		  HF5_metAmos_MT_x_MGMT$fraction[7],
		  # MG assm
		  HF5_IMP_MT_x_MG$fraction[7],
		  HF5_MOCAT_MT_x_MG$fraction[7],
		  HF5_metAmos_MT_x_MG$fraction[7],
		  # MT assm
		  HF5_IMP_MT_x_MT$fraction[7],
		  HF5_MOCAT_MT_x_MT$fraction[7],
		  HF5_metAmos_MT_x_MT$fraction[7]
		)
)
)

colnames(HF5.reads) <- c("Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### WW1 data summary
#####################################################################################################################################

WW1.reads <- 
rbind.data.frame(
		cbind.data.frame(assms,
		## MG total mapped
		c(
		  WW1_IMP_MG_x_MGMT$fraction[3],
		  get("WW1_IMP-megahit_MG_x_MGMT")$fraction[3],
		  WW1_MOCAT_MG_x_MGMT$fraction[3],
		  WW1_metAmos_MG_x_MGMT$fraction[3],
		  # MG assm
		  WW1_IMP_MG_x_MG$fraction[3],
		  WW1_MOCAT_MG_x_MG$fraction[3],
		  WW1_metAmos_MG_x_MG$fraction[3],
		  # MT assm
		  WW1_IMP_MG_x_MT$fraction[3],
		  WW1_MOCAT_MG_x_MT$fraction[3],
		  WW1_metAmos_MG_x_MT$fraction[3]
		),
		
		## MG properly paired
		c(
		  WW1_IMP_MG_x_MGMT$fraction[7],
		  get("WW1_IMP-megahit_MG_x_MGMT")$fraction[7],
		  WW1_MOCAT_MG_x_MGMT$fraction[7],
		  WW1_metAmos_MG_x_MGMT$fraction[7],
		  # MG assm
		  WW1_IMP_MG_x_MG$fraction[7],
		  WW1_MOCAT_MG_x_MG$fraction[7],
		  WW1_metAmos_MG_x_MG$fraction[7],
		  # MT assm
		  WW1_IMP_MG_x_MT$fraction[7],
		  WW1_MOCAT_MG_x_MT$fraction[7],
		  WW1_metAmos_MG_x_MT$fraction[7]
		),
		
		## MT total mapped
		c(
		  WW1_IMP_MT_x_MGMT$fraction[3],
		  get("WW1_IMP-megahit_MT_x_MGMT")$fraction[3],
		  WW1_MOCAT_MT_x_MGMT$fraction[3],
		  WW1_metAmos_MT_x_MGMT$fraction[3],
		  # MG assm
		  WW1_IMP_MT_x_MG$fraction[3],
		  WW1_MOCAT_MT_x_MG$fraction[3],
		  WW1_metAmos_MT_x_MG$fraction[3],
		  # MT assm
		  WW1_IMP_MT_x_MT$fraction[3],
		  WW1_MOCAT_MT_x_MT$fraction[3],
		  WW1_metAmos_MT_x_MT$fraction[3]
		),
		
		## MT properly paired
		c(
		  WW1_IMP_MT_x_MGMT$fraction[7],
		  get("WW1_IMP-megahit_MT_x_MGMT")$fraction[7],
		  WW1_MOCAT_MT_x_MGMT$fraction[7],
		  WW1_metAmos_MT_x_MGMT$fraction[7],
		  # MG assm
		  WW1_IMP_MT_x_MG$fraction[7],
		  WW1_MOCAT_MT_x_MG$fraction[7],
		  WW1_metAmos_MT_x_MG$fraction[7],
		  # MT assm
		  WW1_IMP_MT_x_MT$fraction[7],
		  WW1_MOCAT_MT_x_MT$fraction[7],
		  WW1_metAmos_MT_x_MT$fraction[7]
		)
)
)

colnames(WW1.reads) <- c("Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### WW2 data summary
#####################################################################################################################################

WW2.reads <- 
rbind.data.frame(
		cbind.data.frame(assms,
		## MG total mapped
		c(
		  WW2_IMP_MG_x_MGMT$fraction[3],
		  get("WW2_IMP-megahit_MG_x_MGMT")$fraction[3],
		  WW2_MOCAT_MG_x_MGMT$fraction[3],
		  WW2_metAmos_MG_x_MGMT$fraction[3],
		  # MG assm
		  WW2_IMP_MG_x_MG$fraction[3],
		  WW2_MOCAT_MG_x_MG$fraction[3],
		  WW2_metAmos_MG_x_MG$fraction[3],
		  # MT assm
		  WW2_IMP_MG_x_MT$fraction[3],
		  WW2_MOCAT_MG_x_MT$fraction[3],
		  WW2_metAmos_MG_x_MT$fraction[3]
		),
		
		## MG properly paired
		c(
		  WW2_IMP_MG_x_MGMT$fraction[7],
		  get("WW2_IMP-megahit_MG_x_MGMT")$fraction[7],
		  WW2_MOCAT_MG_x_MGMT$fraction[7],
		  WW2_metAmos_MG_x_MGMT$fraction[7],
		  # MG assm
		  WW2_IMP_MG_x_MG$fraction[7],
		  WW2_MOCAT_MG_x_MG$fraction[7],
		  WW2_metAmos_MG_x_MG$fraction[7],
		  # MT assm
		  WW2_IMP_MG_x_MT$fraction[7],
		  WW2_MOCAT_MG_x_MT$fraction[7],
		  WW2_metAmos_MG_x_MT$fraction[7]
		),
		
		## MT total mapped
		c(
		  WW2_IMP_MT_x_MGMT$fraction[3],
		  get("WW2_IMP-megahit_MT_x_MGMT")$fraction[3],
		  WW2_MOCAT_MT_x_MGMT$fraction[3],
		  WW2_metAmos_MT_x_MGMT$fraction[3],
		  # MG assm
		  WW2_IMP_MT_x_MG$fraction[3],
		  WW2_MOCAT_MT_x_MG$fraction[3],
		  WW2_metAmos_MT_x_MG$fraction[3],
		  # MT assm
		  WW2_IMP_MT_x_MT$fraction[3],
		  WW2_MOCAT_MT_x_MT$fraction[3],
		  WW2_metAmos_MT_x_MT$fraction[3]
		),
		
		## MT properly paired
		c(
		  WW2_IMP_MT_x_MGMT$fraction[7],
		  get("WW2_IMP-megahit_MT_x_MGMT")$fraction[7],
		  WW2_MOCAT_MT_x_MGMT$fraction[7],
		  WW2_metAmos_MT_x_MGMT$fraction[7],
		  # MG assm
		  WW2_IMP_MT_x_MG$fraction[7],
		  WW2_MOCAT_MT_x_MG$fraction[7],
		  WW2_metAmos_MT_x_MG$fraction[7],
		  # MT assm
		  WW2_IMP_MT_x_MT$fraction[7],
		  WW2_MOCAT_MT_x_MT$fraction[7],
		  WW2_metAmos_MT_x_MT$fraction[7]
		)
)
)

colnames(WW2.reads) <- c("Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### WW3 data summary
#####################################################################################################################################

WW3.reads <- 
rbind.data.frame(
		cbind.data.frame(assms,
		## MG total mapped
		c(
		  WW3_IMP_MG_x_MGMT$fraction[3],
		  get("WW3_IMP-megahit_MG_x_MGMT")$fraction[3],
		  WW3_MOCAT_MG_x_MGMT$fraction[3],
		  WW3_metAmos_MG_x_MGMT$fraction[3],
		  # MG assm
		  WW3_IMP_MG_x_MG$fraction[3],
		  WW3_MOCAT_MG_x_MG$fraction[3],
		  WW3_metAmos_MG_x_MG$fraction[3],
		  # MT assm
		  WW3_IMP_MG_x_MT$fraction[3],
		  WW3_MOCAT_MG_x_MT$fraction[3],
		  WW3_metAmos_MG_x_MT$fraction[3]
		),
		
		## MG properly paired
		c(
		  WW3_IMP_MG_x_MGMT$fraction[7],
		  get("WW3_IMP-megahit_MG_x_MGMT")$fraction[7],
		  WW3_MOCAT_MG_x_MGMT$fraction[7],
		  WW3_metAmos_MG_x_MGMT$fraction[7],
		  # MG assm
		  WW3_IMP_MG_x_MG$fraction[7],
		  WW3_MOCAT_MG_x_MG$fraction[7],
		  WW3_metAmos_MG_x_MG$fraction[7],
		  # MT assm
		  WW3_IMP_MG_x_MT$fraction[7],
		  WW3_MOCAT_MG_x_MT$fraction[7],
		  WW3_metAmos_MG_x_MT$fraction[7]
		),
		
		## MT total mapped
		c(
		  WW3_IMP_MT_x_MGMT$fraction[3],
		  get("WW3_IMP-megahit_MT_x_MGMT")$fraction[3],
		  WW3_MOCAT_MT_x_MGMT$fraction[3],
		  WW3_metAmos_MT_x_MGMT$fraction[3],
		  # MG assm
		  WW3_IMP_MT_x_MG$fraction[3],
		  WW3_MOCAT_MT_x_MG$fraction[3],
		  WW3_metAmos_MT_x_MG$fraction[3],
		  # MT assm
		  WW3_IMP_MT_x_MT$fraction[3],
		  WW3_MOCAT_MT_x_MT$fraction[3],
		  WW3_metAmos_MT_x_MT$fraction[3]
		),
		
		## MT properly paired
		c(
		  WW3_IMP_MT_x_MGMT$fraction[7],
		  get("WW3_IMP-megahit_MT_x_MGMT")$fraction[7],
		  WW3_MOCAT_MT_x_MGMT$fraction[7],
		  WW3_metAmos_MT_x_MGMT$fraction[7],
		  # MG assm
		  WW3_IMP_MT_x_MG$fraction[7],
		  WW3_MOCAT_MT_x_MG$fraction[7],
		  WW3_metAmos_MT_x_MG$fraction[7],
		  # MT assm
		  WW3_IMP_MT_x_MT$fraction[7],
		  WW3_MOCAT_MT_x_MT$fraction[7],
		  WW3_metAmos_MT_x_MT$fraction[7]
		)
)
)

colnames(WW3.reads) <- c("Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### WW4 data summary
#####################################################################################################################################

WW4.reads <- 
rbind.data.frame(
		cbind.data.frame(assms,
		## MG total mapped
		c(
		  WW4_IMP_MG_x_MGMT$fraction[3],
		  get("WW4_IMP-megahit_MG_x_MGMT")$fraction[3],
		  WW4_MOCAT_MG_x_MGMT$fraction[3],
		  WW4_metAmos_MG_x_MGMT$fraction[3],
		  # MG assm
		  WW4_IMP_MG_x_MG$fraction[3],
		  WW4_MOCAT_MG_x_MG$fraction[3],
		  WW4_metAmos_MG_x_MG$fraction[3],
		  # MT assm
		  WW4_IMP_MG_x_MT$fraction[3],
		  WW4_MOCAT_MG_x_MT$fraction[3],
		  WW4_metAmos_MG_x_MT$fraction[3]
		),
		
		## MG properly paired
		c(
		  WW4_IMP_MG_x_MGMT$fraction[7],
		  get("WW4_IMP-megahit_MG_x_MGMT")$fraction[7],
		  WW4_MOCAT_MG_x_MGMT$fraction[7],
		  WW4_metAmos_MG_x_MGMT$fraction[7],
		  # MG assm
		  WW4_IMP_MG_x_MG$fraction[7],
		  WW4_MOCAT_MG_x_MG$fraction[7],
		  WW4_metAmos_MG_x_MG$fraction[7],
		  # MT assm
		  WW4_IMP_MG_x_MT$fraction[7],
		  WW4_MOCAT_MG_x_MT$fraction[7],
		  WW4_metAmos_MG_x_MT$fraction[7]
		),
		
		## MT total mapped
		c(
		  WW4_IMP_MT_x_MGMT$fraction[3],
		  get("WW4_IMP-megahit_MT_x_MGMT")$fraction[3],
		  WW4_MOCAT_MT_x_MGMT$fraction[3],
		  WW4_metAmos_MT_x_MGMT$fraction[3],
		  # MG assm
		  WW4_IMP_MT_x_MG$fraction[3],
		  WW4_MOCAT_MT_x_MG$fraction[3],
		  WW4_metAmos_MT_x_MG$fraction[3],
		  # MT assm
		  WW4_IMP_MT_x_MT$fraction[3],
		  WW4_MOCAT_MT_x_MT$fraction[3],
		  WW4_metAmos_MT_x_MT$fraction[3]
		),
		
		## MT properly paired
		c(
		  WW4_IMP_MT_x_MGMT$fraction[7],
		  get("WW4_IMP-megahit_MT_x_MGMT")$fraction[7],
		  WW4_MOCAT_MT_x_MGMT$fraction[7],
		  WW4_metAmos_MT_x_MGMT$fraction[7],
		  # MG assm
		  WW4_IMP_MT_x_MG$fraction[7],
		  WW4_MOCAT_MT_x_MG$fraction[7],
		  WW4_metAmos_MT_x_MG$fraction[7],
		  # MT assm
		  WW4_IMP_MT_x_MT$fraction[7],
		  WW4_MOCAT_MT_x_MT$fraction[7],
		  WW4_metAmos_MT_x_MT$fraction[7]
		)
)
)

colnames(WW4.reads) <- c("Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

#####################################################################################################################################
### BG data summary
#####################################################################################################################################

BG.reads <- 
rbind.data.frame(
		cbind.data.frame(assms,
		## MG total mapped
		c(
		  BG_IMP_MG_x_MGMT$fraction[3],
		  get("BG_IMP-megahit_MG_x_MGMT")$fraction[3],
		  BG_MOCAT_MG_x_MGMT$fraction[3],
		  BG_metAmos_MG_x_MGMT$fraction[3],
		  # MG assm
		  BG_IMP_MG_x_MG$fraction[3],
		  BG_MOCAT_MG_x_MG$fraction[3],
		  BG_metAmos_MG_x_MG$fraction[3],
		  # MT assm
		  BG_IMP_MG_x_MT$fraction[3],
		  BG_MOCAT_MG_x_MT$fraction[3],
		  BG_metAmos_MG_x_MT$fraction[3]
		),
		
		## MG properly paired
		c(
		  BG_IMP_MG_x_MGMT$fraction[7],
		  get("BG_IMP-megahit_MG_x_MGMT")$fraction[7],
		  BG_MOCAT_MG_x_MGMT$fraction[7],
		  BG_metAmos_MG_x_MGMT$fraction[7],
		  # MG assm
		  BG_IMP_MG_x_MG$fraction[7],
		  BG_MOCAT_MG_x_MG$fraction[7],
		  BG_metAmos_MG_x_MG$fraction[7],
		  # MT assm
		  BG_IMP_MG_x_MT$fraction[7],
		  BG_MOCAT_MG_x_MT$fraction[7],
		  BG_metAmos_MG_x_MT$fraction[7]
		),
		
		## MT total mapped
		c(
		  BG_IMP_MT_x_MGMT$fraction[3],
		  get("BG_IMP-megahit_MT_x_MGMT")$fraction[3],
		  BG_MOCAT_MT_x_MGMT$fraction[3],
		  BG_metAmos_MT_x_MGMT$fraction[3],
		  # MG assm
		  BG_IMP_MT_x_MG$fraction[3],
		  BG_MOCAT_MT_x_MG$fraction[3],
		  BG_metAmos_MT_x_MG$fraction[3],
		  # MT assm
		  BG_IMP_MT_x_MT$fraction[3],
		  BG_MOCAT_MT_x_MT$fraction[3],
		  BG_metAmos_MT_x_MT$fraction[3]
		),
		
		## MT properly paired
		c(
		  BG_IMP_MT_x_MGMT$fraction[7],
		  get("BG_IMP-megahit_MT_x_MGMT")$fraction[7],
		  BG_MOCAT_MT_x_MGMT$fraction[7],
		  BG_metAmos_MT_x_MGMT$fraction[7],
		  # MG assm
		  BG_IMP_MT_x_MG$fraction[7],
		  BG_MOCAT_MT_x_MG$fraction[7],
		  BG_metAmos_MT_x_MG$fraction[7],
		  # MT assm
		  BG_IMP_MT_x_MT$fraction[7],
		  BG_MOCAT_MT_x_MT$fraction[7],
		  BG_metAmos_MT_x_MT$fraction[7]
		)
)
)

colnames(BG.reads) <- c("Assembly", "MG_mapped","MG_properly_paired","MT_mapped","MT_properly_paired")

## Save image
save.image("/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/comparison/data_usage/data_usage.Rdat")
