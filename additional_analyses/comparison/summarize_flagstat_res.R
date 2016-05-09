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



