#!/usr/bin/env nextflow   

nextflow.enable.dsl=2

include { designCommunity } from './modules/designCommunity.nf'

workflow {
    designCommunity(params.ref_ls_file, params.mean_genomes, params.depth, params.outdir)
}