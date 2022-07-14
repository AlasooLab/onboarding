#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Separate channel for the VCF file
Channel.fromPath(params.studyFile)
    .ifEmpty { error "Cannot find studyFile file in: ${params.studyFile}" }
    .splitCsv(header: true, sep: '\t', strip: true)
    .map{row -> [ row.qtl_subset, file(row.vcf) ]}
    .set { vcf_file_ch }

include { vcf_to_dosage } from './modules/vcf_to_dosage'

workflow {
    vcf_to_dosage(vcf_file_ch)
}
