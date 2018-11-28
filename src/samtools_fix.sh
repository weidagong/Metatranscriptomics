#!/bin/bash -l
#SBATCH -n 4
#SBATCH --time=12:00:00
#SBATCH -J Samtools		#Job Name
#SBATCH -o Samtools.%A.out
#SBATCH -e Samtools.%A.err
#SBATCH --mem=10g

#$sam is alignment file from bowtie2, $1 is SRA no.

sort $1.cts.tmp | uniq -c > $1.counts.tab
