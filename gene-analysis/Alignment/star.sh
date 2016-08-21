#!/bin/bash

#$ -N STAR
#$ -M abdelrahman@engr.uconn.edu
#$ -m bea
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 8
#$ -o star_$JOB_ID.out"
#$ -e star_$JOB_ID.err"


# Uncomment the following lines to index the genome
# STAR --runThreadN 8 \
# --runMode genomeGenerate \
# --genomeDir hg19 \
# --genomeFastaFiles hg19/genome.fa \
# --sjdbGTFfile hg19/hg19-annotations-refseq.gtf \
# --sjdbOverhang 75

STAR --genomeDir hg19 \
--readFilesIn $1'R1.fastq.gz' $1'R2.fastq.gz' \
--readFilesCommand zcat \
--runThreadN 8 \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix $1'star_output'
