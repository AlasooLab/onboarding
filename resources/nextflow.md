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
* No need to manually keep track of the jobs have already completed and the ones you still need to be run.

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
cd qtlmap
```

## Step 3 - Install Nextlfow

Installing Nextflow is [super easy](https://www.nextflow.io/docs/latest/getstarted.html), you just need to make sure beforehand that the correct Java version is available by loading the corrsponding module. Note that rocket.hpc.ut.ee has very strict RAM limits so you might need to log into stage1 (see Step 4) before you are able to install Nextflow.
  
```bash
 module load java-1.8.0_40
 wget -qO- https://get.nextflow.io | bash
```

And test if it worked:

```bash
./nextflow -version
```

If you wish, you can copy the nextflow executable to a folder where you keep all of your other software and add it to your PATH, but keeping it in the workflow directory is also fine.

## Step 4 - log into the stage1 node of the HPC and start screen
This step should only be necessary when running the workflow for the first time after cloning it, because on the first excution Nextflow downloads the Docker container image and builds a Singularity container based on it. All subsequent executions will use the the cached version of the container.

```bash
ssh stage1
```

Once you have logged in, you can start screen. This will allow you to log out of the node without killing the nextflow process that is running.

```bash
screen
```
You can exit the screen session with `Ctrl + A + D` and you can resume it with `screen -r`. All the processes that you start in screen will keep running after you exit with `Ctrl + A + D`.

## Step 5 - Execute the qtlmap workflow with test input data

Change to the workflow directory

```bash
cd qtlmap
```

Load the required modules (Java and Singularity).

```bash
 module load java-1.8.0_40
 module load singularity/3.5.3
```

Finally, the following command should start the workflow with the test data and you should see progress on screen. See the qtlmap workflow [documentation](https://github.com/eQTL-Catalogue/qtlmap/blob/master/docs/usage.md) for more options.

```bash
nextflow run main.nf -profile tartu_hpc\
   --studyFile testdata/multi_test.tsv\
    --vcf_has_R2_field FALSE\
    --run_nominal\
    --run_permutation\
    --run_susie\
    --varid_rsid_map_file testdata/varid_rsid_map.tsv.gz\
    --n_batches 25
```

If the workflow execution stops some reason, then you can restart it with the -resume options. This ensures that all of the steps have already been completed will not be rerun.

```bash
nextflow run main.nf -profile tartu_hpc\
   --studyFile testdata/multi_test.tsv\
    --vcf_has_R2_field FALSE\
    --run_nominal\
    --run_permutation\
    --run_susie\
    --varid_rsid_map_file testdata/varid_rsid_map.tsv.gz\
    --n_batches 25\
    -resume
```

## Step 6 - Monitoring progress

You can exit the screen session by pressing `Ctrl + A + D`. To see all of your SLURM jobs that are currently running, use the squeue command:

```bash
squeue -u <username>
```

# Other things to keep in mind

## Size of the work directory
Since each Nextflow task runs within its own subdirectory where all of the input and output files are stored, the Nextflow work directory can get very big very quickly! Make sure that you periodically delete the `work` firectory after you have finished running your workflow. When running the [eQTL-Catalogue/rnaseq](https://github.com/eQTL-Catalogue/rnaseq) workflow on a large dataset, my work directory once exceeded 50Tb!

## Failing jobs
Sometimes jobs fail on the HPC for no obvious reason, especially if its a long workflow with hundreds or thousands of steps. Before additional troubleshooting, it is usually worth trying to rerun the workflow with the `-resume` flag to see if the problem persists. 







