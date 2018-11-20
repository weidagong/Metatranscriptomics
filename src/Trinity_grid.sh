#!/bin/bash -l
#SBATCH -n 24
#SBATCH --time=4-23:00:00
#SBATCH -J Trinity_grid		#Job Name
#SBATCH -o Trinity_grid.%A.out
#SBATCH -e Trinity_grid.%A.err
#SBATCH --mem=700000


module load bowtie2
module add trinity
#module load perl

mkdir -p trinity_grid

R1=`ls *_paired_1.fastq`
R2=`ls *_paired_2.fastq`

all_left=""
all_right=""

for r in $R1;
do
    all_left="${all_left},$r"
done

all_left=`echo $all_left|cut -d, -f2-`

for r in $R2;
do
    all_right="${all_right},$r"
done
all_right=`echo $all_right|cut -d, -f2-`

echo ${all_left}
echo ${all_right}
	
Trinity --seqType fq --SS_lib_type RF --max_memory 700G --CPU 24 --left $all_left --right $all_right --output trinity_grid \
--grid_exec "/nas/longleaf/home/wdgong/local/HpcGridRunner-1.0.2/hpc_cmds_GridRunner.pl --grid_conf \
/nas/longleaf/home/wdgong/local/HpcGridRunner-1.0.2/Slurm_trinity.conf -c"
