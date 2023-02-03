#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { designCommunity } from './modules/designCommunity.nf'
include { simReads } from './modules/simReads.nf'
include { getMetagenome } from './modules/getMetagenome.nf'

workflow {
    out = designCommunity(params.ref_ls_file, params.mean_genomes, params.depth, params.outdir)
    ref_depths_ch = out
        .splitText(header:false)
        .map { row -> tuple(file(row[0]), row[1]) }
        .groupTuple()

    reads_dir = file("${params.outdir}/reads")
    reads_dir.mkdir()

    simReads(ref_depths_ch, params.outdir)
    simReads.out.fq1.collectFile(name: "${params.outdir}/all_R1.fq") 
    simReads.out.fq2.collectFile(name: "${params.outdir}/all_R2.fq") 
}
