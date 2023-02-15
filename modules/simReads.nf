process simReads {
    input:
    tuple path(ref_file), val(depth)
    // path outdir

    output:
    tuple val(genome), path("${sim_fq_prefix}1.fq"), path("${sim_fq_prefix}2.fq")

    script:
    genome = ref_file.getSimpleName()
    // reads_file = "${outdir}/reads/${genome}_R"
    sim_fq_prefix = "${genome}_R"

    """

    art_illumina -ss HS25 -f ${depth} -p -l 150 -m 200 -s 10 --noALN -i ${ref_file} -o ${sim_fq_prefix}

    """
}
