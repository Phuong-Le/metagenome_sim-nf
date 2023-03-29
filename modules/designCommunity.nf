process designCommunity {
    // designing community for 1 sample from multiple fasta files
    input: 
    path ref_ls_file
    val mean_genomes
    val depth
    each sample_id

    output:
    // tsv file containing fasta file index and their corresponding read depths 
    path "community_params_idx.tsv", emit: community

    script:
    """
    designCommunity.py --ref_ls_file ${ref_ls_file} -m ${mean_genomes} -d ${depth} -o community_params.tsv
    sed 's/^/${sample_id}\t/' community_params.tsv > community_params_idx.tsv
    """
}
