#!/bin/bash
#$ -N pileup
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -o $JOB_ID.out"
#$ -e $JOB_ID.err"

cd $1
samtools mpileup -f $HOME/Patients/hg19/genome.fa $1-N.bam $1-T.bam > $1.pileup
echo $1' finished pileup'
