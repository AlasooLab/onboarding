#### Pull the FlashPCA container

```bash
singularity build flashpca.img docker://quay.io/eqtlcatalogue/flashpca:v2.0
```

#### Convert genotypes from bgen to plink format

```bash
singularity exec flashpca.img plink2  --bgen PCA_input_correct_IDs_final.bgen ref-first --sample PCA_input_correct_IDs_final.sample --make-bed --out PCA_input_correct_IDs_final
```

### Run FlashPCA

```bash
#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=8G
#SBATCH --job-name="flashPCA"
#SBATCH --partition=main

module load any/singularity/3.7.3
module load squashfs/4.4
singularity exec flashpca.img flashpca --bfile PCA_input_correct_IDs_final --outpc PCA_input_correct_IDs_final_pca -d20 -n8
```