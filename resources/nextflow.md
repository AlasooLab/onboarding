# Executing Nextflow workflows at the University of Tartu HPC

We maintain a number of Nextflow workflows the analysis of gene expression and genotype data:
* [eQTL-Catalogue/rnaseq](https://github.com/eQTL-Catalogue/rnaseq)
* [eQTL-Catalogue/qcnorm](https://github.com/eQTL-Catalogue/qcnorm)
* [eQTL-Catalogue/qtlmap](https://github.com/eQTL-Catalogue/qtlmap)
* [eQTL-Catalogue/genimpute](https://github.com/eQTL-Catalogue/genimpute)
* [eQTL-Catalogue/susie-workflow](https://github.com/eQTL-Catalogue/susie-workflow)

However, trying to execute these workflows for the first time can be a bit overwhelming. The aim of this document is to provide step-by-step instructions for for running Nextlow workflows at [University of Tartu HPC](https://hpc.ut.ee/en/home/) as well as to cover the most common problems that might occur. Your mileage may vary when trying to follow these instructions somewhere else.

Key advantages of using Nextflow workflows over standard SLURM for executing workflows:
* All of the software dependencies are contained within one or more Docker containers, no need to install any software!
* No need to manually track, which jobs have already completed and which ones you still need to run.

## Step 1 - log into the HPC

On Mac and Linux, open the command line type in this:
```bash
ssh <username>@rocket.hpc.ut.ee
```
The username is your standard University of Tartu user name.

On Windows, my prefered approach is to install [Linux Subsystem for Windows](https://docs.microsoft.com/en-us/windows/wsl/install-win10) and then use the same linux ssh command as above. However, [Putty](https://www.putty.org/) should also do the trick. 

## Step 2 - clone the workflow from GitHub

Let's use the [eQTL-Catalogue/qtlmap](https://github.com/eQTL-Catalogue/qtlmap) workflow in this example.

```bash
git clone https://github.com/eQTL-Catalogue/qtlmap.git
```

## Step 3A - log into the stage1 node of the HPC and start screen
This step should only be necessary when running the workflow for the first time after cloning it, because on the first excution Nextflow downloads the Docker container image and builds a Singularity container based on it. All subsequent executions will use the the cached version of the container.

```bash
ssh stage1
```

Once you have logged in, you can start screen. This will allow you to log out of the node without killing the nextflow process that is running.

```bash
screen
```
You can exit the screen session with `Ctrl + A + D` and you can resume it with `screen -r`. All the processes that you start in screen will keep running after you exit with `Ctrl + A + D`.




