#!/bin/bash
#$ -N quality_fastqc
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -o fastqc_$JOB_ID.out"
#$ -e fastqc_$JOB_ID.err"

cd $1
fastqc R1.fastq.gz
fastqc R2.fastq.gz
