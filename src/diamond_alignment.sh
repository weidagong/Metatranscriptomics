#!/bin/bash -l
#SBATCH -n 16
#SBATCH --time=3-23:00:00
#SBATCH -J Diamond		#Job Name
#SBATCH -o Diamond-map.%A.out
#SBATCH -e Diamond-map.%A.err
#SBATCH --mem=100g

module load diamond


###$1 = assembly.fa
###$2 = diamond db
###$3 = output tabular file

#-b is blocksize, typically six times this number of memory usage, e.g. 5x6 = 30gb here

#sensitive is recommended for longer sequences/contigs

time diamond blastx -p 16 -d $2 -q $1 -o $3 -sensitive -e 0.000001 -b 5

