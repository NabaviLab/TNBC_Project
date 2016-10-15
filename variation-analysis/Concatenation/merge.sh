#!/bin/bash
#$ -N merge
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -o $JOB_ID.out"
#$ -e $JOB_ID.err"

patient_id=$1
mkdir Patients/p_DS_bkm_$patient_id

cat KIM_0290_BC6833ANXX/Project_5065_F/Sample_DS-bkm-$patient_id-N/Sample_DS-bkm-$patient_id-N-R2.fastq.gz > Patients/p_DS_bkm_$patient_id/N-R2.fastq.gz

cat KIM_0290_BC6833ANXX/Project_5065_F/Sample_DS-bkm-$patient_id-N/Sample_DS-bkm-$patient_id-N-R1.fastq.gz > Patients/p_DS_bkm_$patient_id/N-R1.fastq.gz


cat KIM_0290_BC6833ANXX/Project_5065_F/Sample_DS-bkm-$patient_id-T/Sample_DS-bkm-$patient_id-T-R2.fastq.gz > Patients/p_DS_bkm_$patient_id/T-R2.fastq.gz

cat KIM_0290_BC6833ANXX/Project_5065_F/Sample_DS-bkm-$patient_id-T/Sample_DS-bkm-$patient_id-T-R1.fastq.gz > Patients/p_DS_bkm_$patient_id/T-R1.fastq.gz
