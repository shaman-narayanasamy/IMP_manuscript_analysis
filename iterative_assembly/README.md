This is repository records the analysis for the stepwise assembly

The analysis is separated into two steps.
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