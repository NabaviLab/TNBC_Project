#!/bin/bash
#$ -N rsem
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 4
#$ -o rsem_$JOB_ID.out"
#$ -e rsem_$JOB_ID.err"

# Uncomment the following lines to prepare the references
# If you see an error that says "According to the GTF file given, a transcript has exons on multiple chromosomes!"
# use Ensembl GTF file as UCSC RefSeq annotations allow for some RefSeq mRNA to map to multiple locations on the genome

#rsem-prepare-reference --gtf hg19-annotations-refseq.gtf \
#genome.fa \
#ref/human_gencode


# The below lines are to calculate expression values
rsem-calculate-expression -p 4 --paired-end \
--bam \
--estimate-rspd \
--output-genome-bam \
$1'star_outputAligned.toTranscriptome.out.bam' \
hg19/rsem_ref/human_gencode $1'rsem_'
