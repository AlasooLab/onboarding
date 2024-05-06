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

module load bedtools2
#rename the folder based on your dataset
export exp=ENCSR485TLP

# NB! this is test data, skip this downloading step if you have your own data available
# load already called peaks for this experiment
wget https://www.encodeproject.org/files/ENCFF567ZCX/@@download/ENCFF567ZCX.bed.gz -O ~/chrombpnet_tutorial/${exp}/data/downloads/overlap.bed.gz

bedtools slop -i ~/chrombpnet_tutorial/common_data/blacklist.bed.gz -g ~/chrombpnet_tutorial/common_data/hg38.chrom.sizes -b 1057 > ~/chrombpnet_tutorial/${exp}/data/downloads/temp.bed
bedtools intersect -v -a ~/chrombpnet_tutorial/${exp}/data/downloads/overlap.bed.gz -b ~/chrombpnet_tutorial/${exp}/data/downloads/temp.bed  > ~/chrombpnet_tutorial/${exp}/data/peaks_no_blacklist.bed