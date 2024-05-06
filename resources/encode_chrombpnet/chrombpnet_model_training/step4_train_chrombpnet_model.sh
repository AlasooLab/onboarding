#!/bin/bash
#SBATCH --partition=gpu
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:tesla:1
#SBATCH --time=5000
#SBATCH --job-name=step4_train_chrombpnet_model
#SBATCH --output=slurm_%x.%j.out # STDOUT

# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG

cleanup() {
    exit_code=$?
    if [ ${exit_code} == 0 ]
    then
	echo "Completed execution"
    else
	echo "\"${last_command}\" failed with exit code ${exit_code}."
    fi
}

# echo an error message before exiting
trap 'cleanup' EXIT INT TERM

module load any/python/3.8.3-conda
module load cuda/11.7.0 && module load cudnn/8.2.0.53-11.3

#rename the folder based on your dataset
export exp=ENCSR485TLP

#conda activate chrombpnet

chrombpnet pipeline \
        -ibam ~/chrombpnet_tutorial/${exp}/data/downloads/merged.bam \
        -d "ATAC" \
        -g ~/chrombpnet_tutorial/common_data/hg38.fa \
        -c ~/chrombpnet_tutorial/common_data/hg38.chrom.sizes \
        -p ~/chrombpnet_tutorial/${exp}/data/peaks_no_blacklist.bed \
        -n ~/chrombpnet_tutorial/${exp}/data/output_negatives.bed \
        -fl ~/chrombpnet_tutorial/common_data/splits/fold_0.json \
        -b ~/chrombpnet_tutorial/bias_model/ENCSR868FGK_bias_fold_0.h5 \
        -o ~/chrombpnet_tutorial/${exp}/chrombpnet_model/
