process designCommunity {
    publishDir "${params.outdir}", mode: 'copy'

    // designing community for 1 sample from multiple fasta files
    input: 
    path ref_ls_file
    val mean_genomes
    val depth


    output:
    // tsv file containing fasta file index and their corresponding read depths 
    path "community_param.tsv", emit: manifest_ch

    script:
    """
    designCommunity.py --ref_ls_file ${ref_ls_file} -m ${mean_genomes} -d ${depth} -o "community_param.tsv"
    """
}
