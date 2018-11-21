#!/bin/bash -l
#SBATCH -n 16
#SBATCH --time=3-23:00:00
#SBATCH -J Salmon-quant		#Job Name
#SBATCH -o Salmon-quant.%A.out
#SBATCH -e Salmon-quant.%A.err
#SBATCH --mem=100g

module load salmon

###mapping each isolates individually
###input SRR no. as $1
###$2 is salmon index, Tara/NRE/genome

R1=`ls /proj/marchlab/projects/EXPORTS/metatranscriptomics/Tara-test/trim/${1}_paired_1.fastq`
R2=`ls /proj/marchlab/projects/EXPORTS/metatranscriptomics/Tara-test/trim/${1}_paired_2.fastq`


###high perc (99%)of reads were paired and passed QC, so only use paired reads 
	
salmon quant -i Tara -l A -1 ${R1} -2 ${R2} -o $1_quant 
