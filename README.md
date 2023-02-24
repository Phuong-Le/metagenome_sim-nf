## metagenome_sim-nf - a Nextflow pipeline to simulate metagenomic samples 


## Why simulate metagenomes in the first place?
[Metagenomes](https://en.wikipedia.org/wiki/Metagenomics) are all the genetic materials in a sample. For example, if you have a nasal swab, then its metagenome may contain your DNA but also DNA from the bacteria, viruses and fungi in your nasal swab sample. Metagenomics is often considered superior to traditional microbiological techniques for detecting pathogens as many microbes are not culturable. However, metagenomes are complex, and it is sometimes desirable to have control over what's included in the sample - particularly when it comes to testing metagenomic analytical tools. 

I originally wrote this pipeline to help evaluate the accuracy of `kraken2` and `bowtie2` in detecting *Streptococcus pneumoniae*. Firstly, I simulated metagenomic samples that contained just *Streptococcus pneumoniae* - applying `kraken2` and `bowtie2` on these samples helped evaluate the sensitivity of these tools. Secondly, I simulated metagenomic samples that contained other species of *Streptococcus* which are often easily mistaken for *Streptococcus pneumoniae* - applying `kraken2` and `bowtie2` on these samples helped evaluate the specificity of these tools.


## How the pipeline works



## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## Scope for the future
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
