#!/bin/bash
#$ -N align_bwa
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 4
#$ -o $JOB_ID.out"
#$ -e $JOB_ID.err"


WORK_DIR=$HOME/Patients
cd $WORK_DIR
bwa index hg19/genome.fa

PATIENT_ID=$1
bwa mem -t 4 hg19/genome.fa p_DS_bkm_$PATIENT_ID/N-R1.fastq.gz p_DS_bkm_$PATIENT_ID/N-R2.fastq.gz > BWA_output/p_DS_bkm_$PATIENT_ID-N.sam
bwa mem -t 4 hg19/genome.fa p_DS_bkm_$PATIENT_ID/T-R1.fastq.gz p_DS_bkm_$PATIENT_ID/T-R2.fastq.gz > BWA_output/p_DS_bkm_$PATIENT_ID-T.sam
