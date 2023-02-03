process simReads {
    input:
    tuple path(ref_file), val(depth)
    val outdir

    output:
    path "${outfile}1.fq", emit: fq1 
    path "${outfile}2.fq", emit: fq2

    script:
    genome = ref_file.getSimpleName()
    outfile = "${outdir}/reads/${genome}_R"

    """

    art_illumina -ss HS25 -f ${depth} -p -l 150 -m 200 -s 10 --noALN -i ${ref_file} -o ${outfile}

    """
}
