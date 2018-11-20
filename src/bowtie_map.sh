#!/bin/bash -l
#SBATCH -n 16
#SBATCH --time=3-23:00:00
#SBATCH -J Bowtie-map		#Job Name
#SBATCH -o Bowtie-map.%A.out
#SBATCH -e Bowtie-map.%A.err
#SBATCH --mem=100g

module load bowtie2

mkdir -p bowtie

###mapping each isolates individually
###input SRR no. as $1
###$2 is bowtie assembly prefix, Tara/NRE/genome

R1=`ls /proj/marchlab/projects/EXPORTS/metatranscriptomics/Tara-test/trim/${1}_paired_1.fastq`
R2=`ls /proj/marchlab/projects/EXPORTS/metatranscriptomics/Tara-test/trim/${1}_paired_2.fastq`


###high perc (99%)of reads were paired and passed QC, so only use paired reads 
	
bowtie2 -p 16 --local --no-unal --phred33 -x $2 -1 $R1 -2 $R2 -S bowtie/$1.sam --met-file bowtie/$1-metric.txt
