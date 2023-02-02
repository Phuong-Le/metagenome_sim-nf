#!/usr/bin/env nextflow   

nextflow.enable.dsl=2

include { designCommunity } from './modules/designCommunity.nf'

workflow {
    designCommunity(params.mean_genomes)
}