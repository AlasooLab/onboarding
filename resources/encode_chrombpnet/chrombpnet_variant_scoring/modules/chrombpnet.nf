nextflow.enable.dsl=2

process GetChrombpnetPreds {
    publishDir "${params.out_dir}", mode: 'copy'
    conda "${params.HOME}/.conda/envs/chrombpnet/"
    label 'gpu'

    input:
    path infile

    output:
    path 'variant_scores.tsv'

    shell:
    '''
    export workdir=$(pwd)
    echo $workdir
    
    module purge
    module load cuda/11.7.0
    module load cudnn/8.2.0.53-11.3

    !{params.HOME}/.conda/envs/chrombpnet/bin/python -c  "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

    !{params.HOME}/.conda/envs/chrombpnet/bin/python !{params.HOME}/chrombpnet_variant_scoring/python_scripts/convert_to_chrombpnet_format.py !{infile} 'chrombpnet_preds.csv'

    !{params.HOME}/.conda/envs/chrombpnet/bin/python !{params.HOME}/chrombpnet_variant_scoring/variant-scorer/src/variant_scoring.py \
    -l ${workdir}/chrombpnet_preds.csv \
    -g !{params.HOME}/chrombpnet_tutorial/common_data/hg38.fa \
    -m !{params.HOME}/chrombpnet_tutorial/!{params.dataset}/chrombpnet_model/models/chrombpnet_nobias.h5 \
    -o ${workdir}/ \
    -s !{params.HOME}/chrombpnet_tutorial/common_data/hg38.chrom.sizes
    '''

}