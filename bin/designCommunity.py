#!/usr/bin/env python3

import numpy as np
import pandas as pd
import argparse, sys

def get_community(ref_ls_file,mean_genomes,depth,outfile):
    ref_ls=pd.read_csv(ref_ls_file, header=None)[0].tolist()
    ngenomes_all = len(ref_ls)
    ngenomes = max(1, np.random.poisson(mean_genomes, size=1)[0])
    ngenomes = min(ngenomes, ngenomes_all)
    genome_idx = np.random.choice(np.array(ngenomes_all), size=ngenomes, replace=False)
    genomes = [ref_ls[i] for i in genome_idx]

    proportions = np.random.dirichlet([1] * ngenomes, size=1)[0]
    proportions = proportions/np.sum(proportions)
    depths = proportions*depth

    out = pd.DataFrame({'genomes': genomes, 'depths': depths})
    out.to_csv(outfile, sep="\t", index=False, header=False)


def get_arguments():
    parser = argparse.ArgumentParser(description='Sample fasta references and their proportions in the metagenomic sample')
    parser.add_argument('--ref_ls_file', required=True,
                        help='file that contains the paths to reference', type = str)
    parser.add_argument('--mean_genomes', '-m', required=True,
                        help='mean number of genomes', type = int)
    parser.add_argument('--depth', '-d', required=True,
                        help='sequencing depth for the whole metagenome sample', type = int)
    parser.add_argument('--outfile', '-o', required=True,
                        help='output file', type = str)
    return parser

def main(args):
    get_community(args.ref_ls_file, args.mean_genomes, args.depth, args.outfile)


if __name__ == "__main__":
    args = get_arguments().parse_args()
    sys.exit(main(args))