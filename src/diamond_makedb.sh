#!/bin/bash -l
#SBATCH -n 4
#SBATCH --time=3-23:00:00
#SBATCH -J Diamond		#Job Name
#SBATCH -o Diamond-makedb.%A.out
#SBATCH -e Diamond-makedb.%A.err
#SBATCH --mem=20g

module load diamond


###$1 = reference fa
###$2 = name of diamond db


time diamond makedb --in $1 -d $2
