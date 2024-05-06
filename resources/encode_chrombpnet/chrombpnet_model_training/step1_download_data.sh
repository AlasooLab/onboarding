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

module load samtools
#rename the folder based on your dataset
export exp=ENCSR485TLP
export data_dir=~/chrombpnet_tutorial/${exp}/data/downloads/

if [[ ! -e $data_dir ]]; then
    mkdir -p $data_dir
fi

# NB! this is test data, skip this downloading step if you have your own data available
# download bams
wget https://www.encodeproject.org/files/ENCFF468VHT/@@download/ENCFF468VHT.bam -O $data_dir/rep1.bam
wget https://www.encodeproject.org/files/ENCFF348MQI/@@download/ENCFF348MQI.bam -O $data_dir/rep2.bam
wget https://www.encodeproject.org/files/ENCFF667GFM/@@download/ENCFF667GFM.bam -O $data_dir/rep3.bam

samtools merge -f $data_dir/merged_unsorted.bam $data_dir/rep1.bam $data_dir/rep2.bam $data_dir/rep3.bam
samtools sort -@4 $data_dir/merged_unsorted.bam -o $data_dir/merged.bam
samtools index $data_dir/merged.bam
