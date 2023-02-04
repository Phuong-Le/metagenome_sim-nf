process simReads {
    input:
    tuple path(ref_file), val(depth)
    // path ref_file
    // val depth
    path outdir

    output:
    path "${reads_file}1.fq", emit: fq1 
    path "${reads_file}2.fq", emit: fq2

    script:
    genome = ref_file.getSimpleName()
    reads_file = "${outdir}/reads/${genome}_R"
    depth = depth[0]

    """

    art_illumina -ss HS25 -f ${depth} -p -l 150 -m 200 -s 10 --noALN -i ${ref_file} -o ${reads_file}

    """
}
