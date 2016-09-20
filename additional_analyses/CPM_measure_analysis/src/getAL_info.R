#!/bin/R
require(stringr)
require(bedr)

args <- commandArgs(trailingOnly = TRUE)

#numcer.tab <- args[1]

## Read in nucmer table
nucmer.tab <- "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/metaquast_output/CPM_analysis/IMP.processed.coords.filtered"
nucmer.dat <- read.delim(nucmer.tab, sep="\t", header=F)
colnames(nucmer.dat) <- c("rstart", "rend", "cstart", "cend", "rlen", "clen", "pident", "ref", "contig", "ambiguity")

al <- nucmer.dat 
al1000 <-  subset(nucmer.dat, clen >= 1000)
bed <- nucmer.dat[, c("contig", "cstart", "cend")]
bed.1 <-  subset(bed, cstart < cend)

# Calculate M: sum length of all aligned regions
M <- sum(al$clen)

# Calculate N: sum length of all unaligned regions
macr <-  
    max(al$clen) 

## Write out AL file
write.table(al, 
	    "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/metaquast_output/CPM_analysis/IMP.processed.coords.filtered_AL", 
	    row.names=F, 
	    col.names=F, 
	    sep="\t", 
	    quote=F)

## Write out AL file
write.table(subset(nucmer.dat, clen >= 1000), 
	    "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/metaquast_output/CPM_analysis/IMP.processed.coords.filtered_AL1000", 
	    row.names=F, 
	    col.names=F, 
	    sep="\t", 
	    quote=F)

## Write out bedfile
write.table(bed, 
	    "/home/shaman/Work/Data/integrated-omics-pipeline/MS_analysis/metaquast_output/CPM_analysis/IMP.processed.coords.filtered.bed", 
	    row.names=F, 
	    col.names=F, 
	    sep="\t", 
	    quote=F)

bed.2 <- unique(paste(bed$contig, ":",  bed$cstart, "-", bed$cend, sep=""))
bed2index(bed)

bed.3 <- bed.2[is.valid.region(bed.2, check.chr=F)]

convert2bed(bed.2, check.zero.based=F, check.valid=F)

bedr.merge.region(bed.3, check.chr=F, check.valid=T, check.sort=T, check.zero.based=T)
