#!/usr/bin/env nextflow

include { designCommunity } from './modules/designCommunity.nf'
include { simReads } from './modules/simReads.nf'
include { normReads } from './modules/normReads.nf'

workflow {
    designCommunity(params.ref_ls_file, params.mean_genomes, params.depth)

    param_file = designCommunity.out.manifest_ch

    ref_depths_ch = param_file
        .splitCsv( sep : '\t')
        .map { row -> tuple( file(row[0]), row[1].toFloat() ) }

    sims_ch = simReads(ref_depths_ch)

    normReads(sims_ch)
    normReads.out.fq1.collectFile(name: "${params.outdir}/metagenome_R1.fq") 
    normReads.out.fq2.collectFile(name: "${params.outdir}/metagenome_R2.fq") 
}
