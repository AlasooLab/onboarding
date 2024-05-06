#!/bin/bash
#SBATCH --partition=main
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --time=4000
#SBATCH --output=slurm_%x.%j.out # STDOUT

mkdir -p ~/chrombpnet_tutorial/common_data/
wget https://www.encodeproject.org/files/GRCh38_no_alt_analysis_set_GCA_000001405.15/@@download/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta.gz -O ~/chrombpnet_tutorial/common_data/hg38.fa.gz
yes n | gunzip ~/chrombpnet_tutorial/common_data/hg38.fa.gz

wget https://www.encodeproject.org/files/GRCh38_EBV.chrom.sizes/@@download/GRCh38_EBV.chrom.sizes.tsv -O ~/chrombpnet_tutorial/common_data/hg38.chrom.sizes

wget https://www.encodeproject.org/files/ENCFF356LFX/@@download/ENCFF356LFX.bed.gz -O ~/chrombpnet_tutorial/common_data/blacklist.bed.gz

mkdir ~/chrombpnet_tutorial/bias_model
wget https://storage.googleapis.com/chrombpnet_data/input_files/bias_models/ATAC/ENCSR868FGK_bias_fold_0.h5 -O ~/chrombpnet_tutorial/bias_model/ENCSR868FGK_bias_fold_0.h5

mkdir ~/chrombpnet_tutorial/common_data/splits
wget https://storage.googleapis.com/chrombpnet_data/input_files/folds/fold_0.json -O ~/chrombpnet_tutorial/common_data/splits/fold_0.json