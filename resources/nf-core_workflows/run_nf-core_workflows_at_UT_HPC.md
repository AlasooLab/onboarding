### Step 1: Clone the desired nf-core worflow from GitHub
```bash
git clone https://github.com/nf-core/atacseq.git
```

### Step 2: Copy the tartu_hpc.config file into the conf subfolder

This file config file tells Nextflow how to excute workflows using Singularity and SLURM. The file looks like this:

```
/*
 * -------------------------------------------------
 *  nf-core/qtlmap Nextflow tartu_hpc config file
 * -------------------------------------------------
 * A 'blank slate' config file, appropriate for general
 * use on most high performace compute environments.
 * Assumes that all software is installed and available
 * on the PATH. Runs in `local` mode - all jobs will be
 * run on the logged in environment.
 */

singularity {
  enabled = true
  autoMounts = true
  cacheDir = "$baseDir/singularity_img/"
}

executor {
    queueSize = 400
    submitRateLimit = 1
}

process {
  executor = 'slurm'
  queue = 'main'
}
```

### Step 3: Add new profile

Modify the nextflow.config file in the root dir of the worklow to import the tartu_hpc.config as a new profile

```
    test      { includeConfig 'conf/test.config'      }
    test_full { includeConfig 'conf/test_full.config' }
    tartu_hpc { includeConfig 'conf/tartu_hpc.config' }
```

### Step 4: Create a suitable sbatch file

```bash
#!/bin/bash

#SBATCH --time=2:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=4G
#SBATCH --job-name="nf-atacseq"
#SBATCH --partition=testing

# Load needed system tools (Java 8 is required, one of singularity or anaconda - python 2.7 is needed,
# depending on the method for dependancy management). The exact names of tool modules might depend on HPC.
module load any/jdk/1.8.0_265
module load any/singularity/3.7.3
module load squashfs/4.4
module load nextflow

nextflow main.nf -profile test,tartu_hpc\
    --outdir test_out
```

### Step 5: Run the workflow
```bash
sbatch run_nextflow.sh
```

