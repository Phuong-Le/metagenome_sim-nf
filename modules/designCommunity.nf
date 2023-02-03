process designCommunity {
    // designing community for 1 sample from multiple fasta files
    input: 
    path ref_ls_file
    val mean_genomes
    val depth
    path outdir


    output:
    // tsv file containing fasta file index and their corresponding read depths 
    path outfile

    script:
    outfile = "${outdir}/community_param.tsv"
    """
    designCommunity.py --ref_ls_file ${ref_ls_file} -m ${mean_genomes} -d ${depth} -o ${outdir}
    """
   
}