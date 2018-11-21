#!/bin/bash -l
#SBATCH -n 16
#SBATCH --time=12:00:00
#SBATCH -J Samtools		#Job Name
#SBATCH -o Samtools.%A.out
#SBATCH -e Samtools.%A.err
#SBATCH --mem=50g

#$sam is alignment file from bowtie2, $1 is SRA no.
module load samtools

sam=`ls $1*.sam`

samtools view -Sb -f 0x2 $sam -o $1.bam && samtools sort -o $1.sort.bam $1.bam && samtools idxstats $1.sort.bam > $1_idxstats.tab
touch $1.stats.txt
samtools flagstat $1.sort.bam >> $1.stats.txt
samtools view $1.sort.bam | cut -f 3 > $1.cts.tmp && sort $1.cts.tmp | uniq -c > $1.counts.tab
