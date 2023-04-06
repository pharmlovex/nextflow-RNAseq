/*
 * pipeline input parameters
 */
params.sra = "$projectDir/data/SSR_list.txt"
params.outdir = "results"
Sample_no = 'Sample Present'
params.ncore = 4

log.info """\
    R N A S E Q - N F   P I P E L I N E
    ===================================
    Samplecount : ${Sample_no}
    outdir       : ${params.outdir}
    sra_list    : ${params.sra}
    Num_thread  : ${params.ncore}
    """
    .stripIndent()

process FetchFastq {
    tag "Fetch Fastq files from SRA ids"
    container 'docker pull quay.io/biocontainers/parallel-fastq-dump:0.6.1--py35_0'
    publishDir params.outdir, mode: 'copy'

    cpus 8

    input:
    path sra_list

    output:
    path 'Fastq'

    """
    fetch.sh ${sra_list}

    """

}

workflow {
    FetchFastq_ch = FetchFastq(params.sra)
}