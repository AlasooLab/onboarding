#!/bin/bash

#The job should run on the testing partition
#SBATCH -p amd

#The name of the job is test_job
#SBATCH -J gwas2vcf

#The job requires 1 compute node
#SBATCH -N 1

#The job requires 1 task per node
#SBATCH --ntasks-per-node=1

#The maximum walltime of the job is a half hour
#SBATCH -t 12:00:00

#SBATCH --mem 20000

#These commands are run on one of the nodes allocated to the job (batch node)
module load singularity/3.5.3
singularity exec -B /gpfs/:/gpfs/ gwas2vcf.img python main.py\
    --out ../LDLC/LDLC.vcf.gz\
    --data ../continuous-LDLC-both_sexes-medadj_irnt.tsv\
    --ref human_g1k_v37.fasta\
    --id LDLC\
    --cohort_controls 457526\
    --json params.json