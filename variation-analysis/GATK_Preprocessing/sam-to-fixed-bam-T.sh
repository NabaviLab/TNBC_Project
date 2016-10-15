#!/bin/bash
#$ -N GATK
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -o $JOB_ID.out"
#$ -e $JOB_ID.err"

WORK_DIR=$HOME/Patients/BWA_output
cd $WORK_DIR

module load java/1.8.0 Picard

PATIENT_ID=$1
PATIENT_DIR=p_DS_bkm_$PATIENT_ID-T
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
