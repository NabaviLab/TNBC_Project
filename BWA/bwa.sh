#!/bin/bash -l
# this is a simple qsub submission script for running a serial (single-threaded) job

# use the Bash shell to execute the job
#$ -S /bin/bash

# Give the job a name
#$ -N abdelrahman_bwa

# send the job output to a file.  $JOB_ID will be substitued with the actual job number
#$ -o $HOME/TNBC_Project/BWA/abdelrahman_bwa-$JOB_ID.out

# send the job error messages to a file
#$ -e $HOME/TNBC_Project/BWA/abdelrahman_bwa-$JOB_ID.err

# define a variable for your working directory - replace this with the actual directory name
# this directory should already exist
WORK_DIR=$HOME/Patients

# change to the $WORK_DIR
cd $WORK_DIR

# Execute the job from the current working directory
#$ -cwd

# now run the actual job - replace this with the program you want to run along with any command line arguments

# bwa index hg19/genome.fa

PATIENT_ID=140
bwa mem -t 8 hg19/genome.fa p_DS_bkm_$PATIENT_ID/N-R1.fastq.gz p_DS_bkm_$PATIENT_ID/N-R2.fastq.gz > BWA_output/p_DS_bkm_$PATIENT_ID-N.sam

PATIENT_ID=134
bwa mem -t 8 hg19/genome.fa p_DS_bkm_$PATIENT_ID/N-R1.fastq.gz p_DS_bkm_$PATIENT_ID/N-R2.fastq.gz > BWA_output/p_DS_bkm_$PATIENT_ID-N.sam
bwa mem -t 8 hg19/genome.fa p_DS_bkm_$PATIENT_ID/T-R1.fastq.gz p_DS_bkm_$PATIENT_ID/T-R2.fastq.gz > BWA_output/p_DS_bkm_$PATIENT_ID-T.sam

PATIENT_ID=135
bwa mem -t 8 hg19/genome.fa p_DS_bkm_$PATIENT_ID/N-R1.fastq.gz p_DS_bkm_$PATIENT_ID/N-R2.fastq.gz > BWA_output/p_DS_bkm_$PATIENT_ID-N.sam
bwa mem -t 8 hg19/genome.fa p_DS_bkm_$PATIENT_ID/T-R1.fastq.gz p_DS_bkm_$PATIENT_ID/T-R2.fastq.gz > BWA_output/p_DS_bkm_$PATIENT_ID-T.sam

PATIENT_ID=136
bwa mem -t 8 hg19/genome.fa p_DS_bkm_$PATIENT_ID/N-R1.fastq.gz p_DS_bkm_$PATIENT_ID/N-R2.fastq.gz > BWA_output/p_DS_bkm_$PATIENT_ID-N.sam
bwa mem -t 8 hg19/genome.fa p_DS_bkm_$PATIENT_ID/T-R1.fastq.gz p_DS_bkm_$PATIENT_ID/T-R2.fastq.gz > BWA_output/p_DS_bkm_$PATIENT_ID-T.sam
