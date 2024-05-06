#!/bin/bash
#SBATCH --time=2:00:00
#SBATCH --ntasks-per-node=1
#SBATCH --job-name="moa"
#SBATCH --partition=main
#SBATCH --mem=8G
#SBATCH --cpus-per-task=4

# Load needed system tools (Java 8 is required, one of singularity or anaconda - python 2.7 is needed,
# depending on the method for dependancy management). The exact names of tool modules might depend on HPC.
module load any/jdk/1.8.0_265
module load any/singularity/3.7.3
module load squashfs/4.4
module load nextflow

export root=~

#dataset parameter defines the name of the chrombpnet model folder, for example ENCSR485TLP (from chrombpnet model training tutorial)
nextflow main.nf  --in_file "${root}/your_qtls_file.tsv"  --HOME $root --dataset "your_model_dataset_name" \
                --out_dir results/


