#!/bin/bash
#SBATCH --partition=main
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --time=4000
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
#rename the folder based on your dataset
export exp=ENCSR485TLP

#conda activate chrombpnet

function timestamp {
    # Function to get the current time with the new line character
    # removed

    # current time
    date +"%Y-%m-%d_%H-%M-%S" | tr -d '\n'
}

chrombpnet prep nonpeaks -g ~/chrombpnet_tutorial/common_data/hg38.fa \
                         -p ~/chrombpnet_tutorial/${exp}/data/peaks_no_blacklist.bed \
                         -c ~/chrombpnet_tutorial/common_data/hg38.chrom.sizes \
                         -fl ~/chrombpnet_tutorial/data/splits/fold_0.json \
                          -br ~/chrombpnet_tutorial/common_data/blacklist.bed.gz \
                          -o ~/chrombpnet_tutorial/${exp}/data/output
