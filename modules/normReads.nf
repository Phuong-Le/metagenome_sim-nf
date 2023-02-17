// art_illumina introduces a dash '-' instead of an N when there's a deletion, this module accounts for that 

process normReads {
    input:
    tuple val(genome), path(sim_fq1), path(sim_fq2)

    output:
    path "${genome}_R1.fq", emit: fq1
    path "${genome}_R2.fq", emit: fq2

    script:
    """
    sed -i '2~4s/-/N/g' ${sim_fq1} 
    sed -i '2~4s/-/N/g' ${sim_fq2} 
    """
}