#!/bin/bash -l
#SBATCH -n 8
#SBATCH --time=1-03:00:00
#SBATCH -J Trim		#Job Name
#SBATCH -o Trim.%A.out
#SBATCH -e Trim.%A.err


module load trimmomatic

mkdir -p trim

cd trim
mkdir -p log
cd ..

#input SRR no
R1="${1}_1.fastq"
R2="${1}_2.fastq"

trimmomatic PE -threads 8 -trimlog trim/log/trimlog_$1.log ${R1} ${R2} trim/${1}_paired_1.fastq \
trim/${1}_unpaired_1.fastq trim/${1}_paired_2.fastq trim/${1}_unpaired_2.fastq LEADING:5 TRAILING:5 \
SLIDINGWINDOW:4:20 MINLEN:36
