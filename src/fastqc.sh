#!/bin/bash -l
#SBATCH -n 8
#SBATCH --time=0-03:00:00
#SBATCH -J FastQC		#Job Name
#SBATCH -o FastQC.%A.out
#SBATCH -e FastQC.%A.err


module load fastqc

mkdir -p FastQC

fastqc -t 8 --outdir FastQC $1      

