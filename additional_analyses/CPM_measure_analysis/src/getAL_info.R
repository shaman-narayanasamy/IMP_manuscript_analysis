#!/bin/R
require(stringr)

args <- commandArgs(trailingOnly = TRUE)

#numcer.tab <- args[1]
nucmer.tab <- "/scratch/users/snarayanasamy/IMP_MS_data/metaquast_analysis/CPM_analysis/IMP.processed.coords.filtered"

nucmer.dat <- read.table(nucmer.tab, sep="\t", header=T)
colnames(nucmer.dat) <- c("rstart", "rend", "cstart", "cend", "rlen", "clen", "pident", "tags")

