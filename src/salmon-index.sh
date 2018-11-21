#!/bin/bash -l
#SBATCH -n 4
#SBATCH --time=3:00:00
#SBATCH -J Salmon-index		#Job Name
#SBATCH -o Salmon-index.%A.out
#SBATCH -e Salmon-index.%A.err
#SBATCH --mem=40g

module load salmon

#$1 is assembly fasta file
#$2 is transcripts index (Tara/NRE/genome)

salmon index -t $1 -i $2 --type quasi -k 31
