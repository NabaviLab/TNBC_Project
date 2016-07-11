#!/bin/bash -l
# this is a simple qsub submission script for running a serial (single-threaded) job

# use the Bash shell to execute the job
#$ -S /bin/bash

# Give the job a name
#$ -N abdelrahman_varscan

# send the job output to a file.  $JOB_ID will be substitued with the actual job number
#$ -o $HOME/TNBC_Project/VarScan/logs/abdelrahman_varscan-$JOB_ID.out

# send the job error messages to a file
#$ -e $HOME/TNBC_Project/VarScan/logs/abdelrahman_varscan-$JOB_ID.err

# define a variable for your working directory - replace this with the actual directory name
# this directory should already exist
WORK_DIR=$HOME/Patients

# change to the $WORK_DIR
cd $WORK_DIR

# Execute the job from the current working directory
#$ -cwd

# now run the actual job - replace this with the program you want to run along with any command line arguments

PATIENT_ID=$1
mkdir VarScan_output/patient_$PATIENT_ID

samtools sort -T VarScan_output/patient_$PATIENT_ID/T1.temp -o VarScan_output/patient_$PATIENT_ID/patient_$PATIENT_ID-T.bam -O bam -m 8G BWA_output/p_DS_bkm_$PATIENT_ID-T.sam

samtools mpileup -f hg19/genome.fa VarScan_output/patient_$PATIENT_ID/patient_$PATIENT_ID-T.bam > VarScan_output/patient_$PATIENT_ID/patient_$PATIENT_ID-T.pileup

samtools sort -T VarScan_output/patient_$PATIENT_ID/N.temp -o VarScan_output/patient_$PATIENT_ID/patient_$PATIENT_ID-N.bam -O bam -m 8G BWA_output/p_DS_bkm_$PATIENT_ID-N.sam 
samtools mpileup -f hg19/genome.fa VarScan_output/patient_$PATIENT_ID/patient_$PATIENT_ID-N.bam > VarScan_output/patient_$PATIENT_ID/patient_$PATIENT_ID-N.pileup

cd VarScan_output/patient_$PATIENT_ID
java -jar /export/apps/VarScan.v2.4.2.jar somatic patient_$PATIENT_ID-N.pileup patient_$PATIENT_ID-T.pileup patient_$PATIENT_ID --min-coverage 10 --min-var-freq 0.08 --somatic-p-value 0.05

java -jar /export/apps/VarScan.v2.4.2.jar processSomatic patient_$PATIENT_ID.snp
java -jar /export/apps/VarScan.v2.4.2.jar processSomatic patient_$PATIENT_ID.indel
java -jar /export/apps/VarScan.v2.4.2.jar somaticFilter patient_$PATIENT_ID.snp.Somatic.hc --indel-file patient_$PATIENT_ID.indel --output-file patient_$PATIENT_ID.snp.Somatic.hc.filter

java -jar /export/apps/VarScan.v2.4.2.jar somatic patient_$PATIENT_ID-N.pileup patient_$PATIENT_ID-T.pileup patient_$PATIENT_ID --output-vcf 1 --min-coverage 10 --min-var-freq 0.08 --somatic-p-value 0.05
