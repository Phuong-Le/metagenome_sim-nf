#!/usr/bin/env python3

import numpy as np
import pandas as pd
import argparse, sys

def get_community(mean_genomes,ngenomes_all):
    ngenomes = max(1, np.random.poisson(mean_genomes, size=1)[0])
    genomes = np.random.choice(np.array(ngenomes_all), size=ngenomes, replace=False)

    proportions = np.random.dirichlet([1] * ngenomes, size=1)[0]
    proportions = proportions/np.sum(proportions)

    out = pd.DataFrame({'genomes': genomes, 'proportions': proportions})
    outfile = 'sample_param.tsv'
    out.to_csv(outfile, sep="\t", index=False)


def get_arguments():
    parser = argparse.ArgumentParser(description='Sample fasta references and their proportions in the metagenomic sample')
    parser.add_argument('--mean_genomes', '-m', required=True,
                        help='mean number of genomes', type = int)
    parser.add_argument('--ngenomes_all', '-n', required=True,
                        help='number of possibilities for genomes', type = int)
    # parser.add_argument('--outdir', '-o', required=True,
                        # help='output directory', type = str)
    return parser

def main(args):
    get_community(args.mean_genomes, args.ngenomes_all)


if __name__ == "__main__":
    args = get_arguments().parse_args()
    sys.exit(main(args))