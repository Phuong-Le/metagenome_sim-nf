params.outdir = '/outdir/'

process designCommunity {
    // designing community for 1 sample from multiple fasta files
    input: 
    // file with paths to reference fasta files
    // path ref_file
    // val outdir
    // number of mean genomes
    val mean_genomes

    output:
    // tsv file containing fasta file index and corresponding proportion 
    // path "${outdir}/sample_param.tsv"

    script:
    """

    python3 $projectDir/bin/designCommunity.py -n 10 -m ${mean_genomes}

    """
   
}