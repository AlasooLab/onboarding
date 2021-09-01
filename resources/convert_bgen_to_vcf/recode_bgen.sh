#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=5G
#SBATCH --job-name="genimpute"
#SBATCH --partition=amd

# Load needed system tools (Java 8 is required, one of singularity or anaconda - python 2.7 is needed,
# depending on the method for dependancy management). The exact names of tool modules might depend on HPC.
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_1_final_v1.bgen -og chr1.bgen -bgen-bits 8 -os chr1.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_2_final_v1.bgen -og chr2.bgen -bgen-bits 8 -os chr2.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_3_final_v1.bgen -og chr3.bgen -bgen-bits 8 -os chr3.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_4_final_v1.bgen -og chr4.bgen -bgen-bits 8 -os chr4.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_5_final_v1.bgen -og chr5.bgen -bgen-bits 8 -os chr5.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_6_final_v1.bgen -og chr6.bgen -bgen-bits 8 -os chr6.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_7_final_v1.bgen -og chr7.bgen -bgen-bits 8 -os chr7.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_8_final_v1.bgen -og chr8.bgen -bgen-bits 8 -os chr8.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_9_final_v1.bgen -og chr9.bgen -bgen-bits 8 -os chr9.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_10_final_v1.bgen -og chr10.bgen -bgen-bits 8 -os chr10.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_11_final_v1.bgen -og chr11.bgen -bgen-bits 8 -os chr11.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_12_final_v1.bgen -og chr12.bgen -bgen-bits 8 -os chr12.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_13_final_v1.bgen -og chr13.bgen -bgen-bits 8 -os chr13.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_14_final_v1.bgen -og chr14.bgen -bgen-bits 8 -os chr14.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_15_final_v1.bgen -og chr15.bgen -bgen-bits 8 -os chr15.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_16_final_v1.bgen -og chr16.bgen -bgen-bits 8 -os chr16.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_17_final_v1.bgen -og chr17.bgen -bgen-bits 8 -os chr17.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_18_final_v1.bgen -og chr18.bgen -bgen-bits 8 -os chr18.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_19_final_v1.bgen -og chr19.bgen -bgen-bits 8 -os chr19.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_20_final_v1.bgen -og chr20.bgen -bgen-bits 8 -os chr20.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_21_final_v1.bgen -og chr21.bgen -bgen-bits 8 -os chr21.samples
qctool_v2.0.6 -g ../bgen/INTERVAL_SOMALOGIC_POSTQC_chrom_22_final_v1.bgen -og chr22.bgen -bgen-bits 8 -os chr22.samples
