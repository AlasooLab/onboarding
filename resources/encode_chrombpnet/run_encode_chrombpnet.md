## ENCODE atacseq and chromBPNet pipeline tutorial


- [Step 1 - Download raw data](#step-1---download-raw-data)
- [Step 2 - ENCODE ATAC-seq pipeline](#step-2---encode-atac-seq-pipeline)
- [Step 3 - ChromBPNet model training](#step-3---chrombpnet-model-training)
- [Step 4 - ChromBPNet variant scoring](#step-4---chrombpnet-variant-scoring)
- [Step 5 - Analyse the results](#step-5---analyse-the-results)

----

### Step 1 - Download raw data

Download raw .fastq files.

### Step 2 - ENCODE ATAC-seq pipeline

The following steps are based on the full ENCODE tutorial: [https://github.com/ENCODE-DCC/atac-seq-pipeline](https://github.com/ENCODE-DCC/atac-seq-pipeline) 

Create conda environment
```
conda create -n encode python=3.12.0
conda activate encode
```
Install caper
```
pip install caper
```
Clone atac-seq-pipeline
```
git clone https://github.com/ENCODE-DCC/atac-seq-pipeline
```

Create new [input JSON](https://github.com/ENCODE-DCC/atac-seq-pipeline/blob/master/docs/input_short.md) file with your information.
An example for paired end reads of two samples:
```
{
    "atac.title" : "Example (paired end)",
    "atac.description" : "This is a template input JSON for paired ended sample.",

    "atac.pipeline_type" : "atac",
    "atac.align_only" : false,
    "atac.true_rep_only" : false,

    "atac.genome_tsv" : "https://storage.googleapis.com/encode-pipeline-genome-data/genome_tsv/v4/hg38.tsv",
    "atac.paired_end" : true,

    "atac.fastqs_rep1_R1" : [ "rep1_R1.fastq.gz"],
    "atac.fastqs_rep1_R2" : [ "rep1_R2.fastq.gz"],
    "atac.fastqs_rep2_R1" : [ "rep2_R1.fastq.gz"],
    "atac.fastqs_rep2_R2" : [ "rep2_R2.fastq.gz"],

    "atac.auto_detect_adapter" : true
}
```
> [!TIP]
> NB! If you want to use multiple files for one sample, simply list them separated by commas. For example:
> ```
> "atac.fastqs_rep1_R1" : ["rep1_file1_R1.fastq.gz","rep1_file2_R1.fastq.gz","rep1_file3_R1.fastq.gz"] 
> ```

Prepare a SLURM script to run the ENCODE pipeline:
```
#!/bin/bash
#SBATCH -J encode_atacseq
#SBATCH --partition=main
#SBATCH -N 1
#SBATCH -t 1-00:00:00
#SBATCH --ntasks-per-node=1
#SBATCH --mem=40G

module load any/jdk/1.8.0_265
module load any/singularity/3.5.3
module load nextflow
module load squashfs/4.4

caper run atac.wdl -i example_input_json/samples.json --singularity
```

Run the pipeline by submitting the job:
```
sbatch run_nextflow.sh
```
Organizing outputs

Find the `metadata.json` file in the output directory `/atac/*/`.

```
pip install croo
croo [METADATA_JSON_FILE]
```

### Step 3 - ChromBPNet model training

The following steps are based on the full tutorial: https://github.com/kundajelab/chrombpnet/wiki

#### 1 Installation

For local installation, follow these steps:

Create conda environment

```
conda create -n chrombpnet python=3.8
conda activate chrombpnet
```

Install non-Python requirements via conda

```
conda install -y -c conda-forge -c bioconda samtools bedtools ucsc-bedgraphtobigwig pybigwig meme
```

Install from pypi

```
pip install chrombpnet
```

#### 2 Preprocessing steps

Run the following prepocessing steps from [`encode_chrombpnet/chrombpnet_model_training`](https://github.com/AlasooLab/onboarding/tree/main/resources/encode_chrombpnet/chrombpnet_model_training) <br/>
NB! These steps contain downloading the test data. If you have your own data available, skip the downloading part and replace the test data with relevant files.

##### Shared data

> [!TIP]
> NB! You need to download this step 0 data only once. It will be used across all your trainings.
```
sbatch step0_download_common_data.sh
```
##### Bams
```
sbatch step1_download_data.sh
```
##### Peaks
```
sbatch step2_get_peaks.sh
```
##### Background regions
```
sbatch step3_get_background_regions.sh
```

#### 3 Model training

Run the following training step from [`encode_chrombpnet/chrombpnet_model_training`](https://github.com/AlasooLab/onboarding/tree/main/resources/encode_chrombpnet/chrombpnet_model_training)

```
sbatch step4_train_chrombpnet_model.sh
```

### Step 4 - ChromBPNet variant scoring

Activate conda chrombpnet environment

```
conda activate chrombpnet
```

#### 1 Chrombpnet variant scorer

Info about variant scorer: https://github.com/kundajelab/variant-scorer

```
git clone https://github.com/kundajelab/variant-scorer
```
> [!NOTE]
> NB! Change the [`variant_scoring.py`](https://github.com/kundajelab/variant-scorer/blob/main/src/variant_scoring.py) file so that it saves output `variant_scores.tsv` file without a "." prefix. Otherwise, files with "." prefix would be considered hidden in Linux. 

#### 2 Run the variant scoring nextflow workflow

You can find the necessary variant scoring nextflow workflow files in [```encode_chrombpnet/chrombpnet_variant_scoring```](https://github.com/AlasooLab/onboarding/tree/main/resources/encode_chrombpnet/chrombpnet_variant_scoring)

The workflow uses the variant-scorer and qtls as input and generates model predictions for the variants as output.

Prepare the input qtls file in this format: 
```
variant
chr1_111619013_A_G
chr1_151809858_C_G
chr1_7506086_G_C
chr17_4926809_G_A
```

> [!NOTE]
> Adjust the paths in [`modules/chrombpnet.nf`](https://github.com/AlasooLab/onboarding/tree/main/resources/encode_chrombpnet/chrombpnet_variant_scoring/modules/chrombpnet.nf) and [`run_nextflow.sh`](https://github.com/AlasooLab/onboarding/tree/main/resources/encode_chrombpnet/chrombpnet_variant_scoring/modules/run_nextflow.sh) according to you.

Run the variant scoring nextflow workflow.

```
sbatch run_nextflow.sh
```

### Step 5 - Analyse the results

You can find the model predictions in ```results/variant_scores.tsv``` file.