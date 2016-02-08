This is repository contains the commands and scripts used for the iterative
assembly procedures. The analyses for metagenomic (MG) data and
metatranscriptomic data are separated into two folders:

1. MG iterative assembly (folder: MG_assembly)
2. MT iterative assembly (folder: MT_assembly)

Each of the folders contains a Snakefile for the corresponding MG and MT
iterative assemblies.

IMP preprocessed reads are used to run the iterative assemblies. The Snakefiles
are formulated as such:

1. Initial assembly (first assembly)
2. Iteration step:
   i) Extract unmapped
   ii) Assembly
   iii) Merge assembly (only for MG assembly)

The collapsing of contigs are done with cap3 for MG assemblies and CD-HIT-EST
for MT assemblies. MetaQUAST is used for assessing the MG assemblies while
MetaGeneMark is used for the MT assemblies.



