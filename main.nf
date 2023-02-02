#!/usr/bin/env nextflow   

nextflow.enable.dsl=2

include { designCommunity } from './modules/designCommunity.nf'
include { simReads } from './modules/simReads.nf'

workflow {
    out = designCommunity(params.ref_ls_file, params.mean_genomes, params.depth, params.outdir) 
    genomes = Channel.fromPath('/Users/al35/Documents/nextflow/metagenome_sim/testing/community_param.tsv')
        .splitText( each:{ it.split()[0] } )
    depths = Channel.fromPath('/Users/al35/Documents/nextflow/metagenome_sim/testing/community_param.tsv')
        .splitText( each:{ it.split()[1] } )

    reads_dir = file("${params.outdir}/reads")
    reads_dir.mkdir()
    
    simReads(genomes, depths, params.outdir)
}