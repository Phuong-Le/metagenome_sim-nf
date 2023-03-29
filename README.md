## metagenome_sim-nf 
a Nextflow pipeline to simulate metagenomic samples 

## Why simulate metagenomes in the first place?
[Metagenomes](https://en.wikipedia.org/wiki/Metagenomics) are all the genetic materials in a sample. For example, if you have a nasal swab, then its metagenome may contain your DNA but also DNA from the bacteria, viruses and fungi in your nasal swab sample. Metagenomics is often considered superior to traditional microbiological techniques for detecting pathogens as many microbes are not culturable. However, metagenomes are complex, and it is sometimes desirable to have control over what's included in the sample - particularly when it comes to testing metagenomic analytical tools. 

As an example of how `metagenome_sim-nf` can be used, I originally wrote the piepline to help evaluate the accuracy of `kraken2` and `bowtie2` in detecting *Streptococcus pneumoniae*. Firstly, I simulated metagenomic samples that contained just *Streptococcus pneumoniae* - applying `kraken2` and `bowtie2` on these samples helped evaluate the sensitivity of these tools. Secondly, I simulated metagenomic samples that contained other species of *Streptococcus* which are often easily mistaken for *Streptococcus pneumoniae* - applying `kraken2` and `bowtie2` on these samples helped evaluate the specificity of these tools. Of course, `metagenome_sim-nf` can be used to simulate metagenomes of all kinds of species and not just *Strep* (as long as you have a reference genome). It is not restricted to testing `kraken2` and `bowtie2` either. 


## How the pipeline works in details
The main workflow can be found in [main.nf](https://github.com/Phuong-Le/metagenome_sim-nf/blob/main/main.nf)

1. Designing the community present in the metagenomic sample. That is, what species/strains (reference fasta file) are present and how much do they contribute to the metagenome. The former is sampled from the Poisson distribution, the latter is sampled from the Dirichlet distribution (statistical sampling method by [Gerry Tonkin-Hill](https://github.com/gtonkinhill)). The source code is in [modules/designCommunity.nf](https://github.com/Phuong-Le/metagenome_sim-nf/blob/main/modules/designCommunity.nf), which in turns calls the [bin/designCommunity.py](https://github.com/Phuong-Le/metagenome_sim-nf/blob/main/bin/designCommunity.py) python script.

2. Simulating the metagenomes based on the community structure generated above. This is done using [`art_illumina`](https://www.niehs.nih.gov/research/resources/software/biostatistics/art/index.cfm). Currently the pipeline only supports Illumina sequencing. Source code for this step is in [modules/simReads.nf](https://github.com/Phuong-Le/metagenome_sim-nf/blob/main/modules/simReads.nf)

3. Normalising the fastq files output from step 2. `art_illumina` introduces dashes '-' when there's a deletion, [modules/normReads.nf](https://github.com/Phuong-Le/metagenome_sim-nf/blob/main/modules/normReads.nf) for that by replacing the '-' with an N. More thoughts needed regarding whether is is an appropriate fix.


## Dependencies
- [Nextflow](https://www.nextflow.io/)
- [Docker](https://www.docker.com/) if using own machine or [Singularity](https://sylabs.io/singularity/) if using a shared HPC

if run without a container (e.g. when `-c lsf.config` is not activated)
- python3 packages: `numpy`, `pandas`
- [art](https://www.niehs.nih.gov/research/resources/software/biostatistics/art/index.cfm)


## Installation
- Clone this repo
``` 
git clone git@github.com:Phuong-Le/metagenome_sim-nf.git
```


## Usage
```
nf_script=/path/to/main.nf
config_file=/path/to/customed_config/file #eg lsf.config
sample_size=number of metagenomes to be generated
mean_genomes=the average number of genomes (species/strains) to be included (the actual number is chosen by Poisson sampling)
depth=simulated sequencing depth, default to 500
outdir=/path/to/dir/containing/fastq/files
ref_ls_file=/path/to/file/containing/genomes/allowed/in/simulated/metagenome


nextflow run ${nf_script} -c ${config_file} \
--sample_size ${sample_size} --mean_genomes ${mean_genomes} --depth ${depth} --outdir ${outdir} --ref_ls_file ${ref_ls_file}
```

example on an lsf system like at Sanger (note that you could still use raw `nextflow run` like above)
```
module load ISG/singularity/3.10.0
module load nextflow/22.10.3-5834

bsub -cwd /path/to/working_dir -o %J.out -e %J.err -R "select[mem>1000] rusage[mem=1000]" -M1000 \
        "nextflow run ${nf_script} -c ${config_file} --sample_size ${sample_size} --mean_genomes ${mean_genomes} --depth ${depth} --outdir ${outdir} --ref_ls_file ${ref_ls_file}"
```

demo file for `${ref_ls_file}` is found in [demo_files](https://github.com/Phuong-Le/metagenome_sim-nf/blob/main/demo_files/ref_ls.txt)


## Authors 
[Phuong Le](https://github.com/Phuong-Le) (email: al35@sanger.ac.uk) and [Vicky Carr](https://github.com/blue-moon22)

## Acknowledgements
Thanks to [Gerry Tonkin-Hill](https://github.com/gtonkinhill) for sharing his method to design and simulate metagenomes

## Scope for the future
Could review the designCommunity for more flexibility, and potentially a simulation that's closer to reality 

normReads handling of the '-' character should be reviewed as well

add help message

incorporate nf-test