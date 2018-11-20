#!/bin/bash -l
#SBATCH -n 4
#SBATCH --time=3:00:00
#SBATCH -J Bowtie-index		#Job Name
#SBATCH -o Bowtie-index.%A.out
#SBATCH -e Bowtie-index.%A.err
#SBATCH --mem=10000

module load bowtie2
#module load perl

#$1 is assembly fasta file
#$2 is assembly prefix

bowtie2-build --threads 4 $1 $2
