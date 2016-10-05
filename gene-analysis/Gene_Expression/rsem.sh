#!/bin/bash
#$ -N rsem
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 4
#$ -o $JOB_ID.out"
#$ -e $JOB_ID.err"

# Uncomment the following lines to prepare the references
# If you see an error that says "According to the GTF file given, a transcript has exons on multiple chromosomes!"
# use Ensembl GTF file as UCSC RefSeq annotations allow for some RefSeq mRNA to map to multiple locations on the genome

#rsem-prepare-reference --gtf annotations/Homo_sapiens.GRCh37.75.uncommented.prefixed.gtf \
#genome.fa \
#human_ensembl


# The below lines are to calculate expression values
# rsem-calculate-expression -p 4 --paired-end \
# --bam \
# --estimate-rspd \
# --output-genome-bam \
# $1'STAR/star_outputAligned.toTranscriptome.out.bam' \
# hg19/rsem_ref_new/human_ensembl $1'RSEM2/rsem'

module load STAR/2.5.2a

mkdir $1'RSEM3'
rsem-calculate-expression -p 4 --paired-end \
--star --star-path /common/opt/bioinformatics/STAR-2.5.2a/bin \
--gzipped-read-file \
--estimate-rspd \
--output-genome-bam \
$1'FASTQ/R1.fastq.gz' $1'FASTQ/R2.fastq.gz' \
hg19/human_ensembl $1'RSEM3/rsem'
