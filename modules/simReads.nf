process simReads {
    input:
    val ref_file
    val depth
    val outdir

    output:
    // val outfile

    script:
    genome = ref_file
    outfile = "${outdir}/reads/${genome}.fastq"
    """
    printf "$depth\t$ref_file\t$outdir" > $outfile

    """
}