process simReads {
    input:
    tuple val(sample_id), path(ref_file), val(depth)

    output:
    tuple path("${sim_fq_prefix}1.fq"), path("${sim_fq_prefix}2.fq")

    script:
    genome = ref_file.getSimpleName()
    sim_fq_prefix = "${sample_id}-${genome}_R"

    """

    art_illumina -ss HS25 -f ${depth} -p -l 150 -m 200 -s 10 --noALN -i ${ref_file} -o ${sim_fq_prefix}

    """
}
