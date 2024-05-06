nextflow.enable.dsl=2

include { GetChrombpnetPreds } from './modules/chrombpnet'

workflow {
    infile = "${params.in_file}"

    out2 = GetChrombpnetPreds(infile)
}


