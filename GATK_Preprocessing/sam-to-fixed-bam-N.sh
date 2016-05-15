#!/bin/bash -l
# this is a simple qsub submission script for running a serial (single-threaded) job

# use the Bash shell to execute the job
#$ -S /bin/bash

# Give the job a name
#$ -N abdelrahman_sam-to-bam

# send the job output to a file.  $JOB_ID will be substitued with the actual job number
#$ -o $HOME/TNBC_Project/GATK_Preprocessing/abdelrahman_sam-to-bam-$JOB_ID.out

# send the job error messages to a file
#$ -e $HOME/TNBC_Project/GATK_Preprocessing/abdelrahman_sam-to-bam-$JOB_ID.err

# define a variable for your working directory - replace this with the actual directory name
# this directory should already exist
WORK_DIR=$HOME/Patients/BWA_output

# change to the $WORK_DIR
cd $WORK_DIR

# Execute the job from the current working directory
#$ -cwd

# now run the actual job - replace this with the program you want to run along with any command line arguments
module load java/1.8.0 Picard

PATIENT_ID=$1
PATIENT_DIR=p_DS_bkm_$PATIENT_ID-N
mkdir $PATIENT_DIR

java -Xmx14g -jar $PICARD SortSam \
I=$PATIENT_DIR.sam \
O=$PATIENT_DIR/$PATIENT_DIR.sorted.bam \
SO=coordinate \
VALIDATION_STRINGENCY=LENIENT \
TMP_DIR=tmp_WT \
CREATE_INDEX=true

java -Xmx14g -jar $PICARD MarkDuplicates \
I=$PATIENT_DIR/$PATIENT_DIR.sorted.bam \
O=$PATIENT_DIR/$PATIENT_DIR.sorted.MarkDup.bam \
VALIDATION_STRINGENCY=SILENT \
METRICS_FILE=MarkDup_metrics \
TMP_DIR=tmp \
CREATE_INDEX=true

java -Xmx14g -jar $PICARD AddOrReplaceReadGroups \
I=$PATIENT_DIR/$PATIENT_DIR.sorted.MarkDup.bam \
O=$PATIENT_DIR/$PATIENT_DIR.sorted.MarkDup.fixed.bam \
RGLB=bar \
RGID=id \
RGPL=Illumina \
RGPU=platform \
RGSM=sample1 \
SO=coordinate \
VALIDATION_STRINGENCY=SILENT \
TMP_DIR=tmp \
CREATE_INDEX=true

java -Xmx14g -jar $PICARD FixMateInformation \
SO=coordinate \
I=$PATIENT_DIR/$PATIENT_DIR.sorted.MarkDup.fixed.bam \
O=$PATIENT_DIR/$PATIENT_DIR.sorted.MarkDup.realn.fixed.bam \
VALIDATION_STRINGENCY=LENIENT \
TMP_DIR=tmp/flx \
CREATE_INDEX=true
