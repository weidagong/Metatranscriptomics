#!/bin/bash -l
#SBATCH -n 4
#SBATCH --time=3:00:00
#SBATCH -J Bowtie-index		#Job Name
#SBATCH -o Bowtie-index.%A.out
#SBATCH -e Bowtie-index.%A.err
#SBATCH --mem=10000

module load trinity

/nas/longleaf/apps/trinity/2.4.0/trinityrnaseq-Trinity-v2.4.0/util/TrinityStats.pl Trinity.fasta > Trinity_assembly.metrics
