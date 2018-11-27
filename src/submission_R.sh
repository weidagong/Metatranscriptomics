#!/bin/bash -l
#SBATCH -n 4
#SBATCH --time=2-23:00:00
#SBATCH -J Rscript		#Job Name
#SBATCH -o Rscript-map.%A.out
#SBATCH -e Rscript-map.%A.err
#SBATCH --mem=10g

module load r/3.5.0


#$1 is rscript
time Rscript --vanilla $1
