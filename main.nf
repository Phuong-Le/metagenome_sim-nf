#!/usr/bin/env nextflow

import java.nio.file.Paths

// import processes for main workflow
include { designCommunity } from './modules/designCommunity.nf'
include { simReads } from './modules/simReads.nf'
include { normReads } from './modules/normReads.nf'

// import preprocessing function
include { validate } from './modules/validate.nf'

// validate parameters
validate(params)

// create directory for the sampples 
sample_prefix = Paths.get(params.outdir)
    .resolve('sample_').toString()

(1..params.sample_size)
    .toList()
    .each { idx -> 
        dirname = sample_prefix + idx
        File dir = new File(dirname)
        dir.mkdir() }


workflow {
    sampleid_ch = Channel.of( 1..params.sample_size )
        .map { 'sample_' + it }
    
    designCommunity(params.ref_ls_file, params.mean_genomes, params.depth, sampleid_ch)
    param_file = designCommunity
        .out
        .community
        .collectFile(name: "${params.outdir}/sample_params.tsv")

    ref_depths_ch = param_file
        .splitCsv( sep : '\t' )
        .map { row -> tuple( row[0], file(row[1]), row[2].toFloat() ) }

    sims_ch = simReads(ref_depths_ch)

    normReads(sims_ch)
    normReads.out.fq1
        .collectFile() { item -> [ "${params.outdir}/${item.name.split('-')[0]}/metagenome_R1.fq" , item.text + '\n' ] } 
    
    normReads.out.fq2
        .collectFile() { item -> [ "${params.outdir}/${item.name.split('-')[0]}/metagenome_R2.fq" , item.text + '\n' ] }  
}


