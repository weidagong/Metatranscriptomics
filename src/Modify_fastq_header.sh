#!/bin/bash -l
#SBATCH -n 8
#SBATCH --time=0-03:00:00
#SBATCH -J FastQC		#Job Name
#SBATCH -o FastQC.%A.out
#SBATCH -e FastQC.%A.err


#change fastq headline to make forward and reverse name consistent
#remove _F and _R for forward and reverse reads, respectively

#$1 forward reads, $2 reverse reads


sed -i 's/_F//g' $1
sed -i 's/_R//g' $2
