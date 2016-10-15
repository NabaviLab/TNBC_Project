#!/bin/bash
#$ -N quality_fastqc
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -o $JOB_ID.out"
#$ -e $JOB_ID.err"

WORK_DIR=$HOME/TNBC_Project/Quality
cd $WORK_DIR

data_dir='/archive/NabaviLab/TNBC_Project/fastq_raw_data/Project_5065_F/Patients/*'
for patient in $data_dir; do
	for sample in $patient'/*'; do
		fastqc $sample
	done
	echo 'done with patient '$patient
	echo ''
done
