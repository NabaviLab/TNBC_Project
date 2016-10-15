#!/bin/bash
#$ -N clean
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -o $JOB_ID.out"
#$ -e $JOB_ID.err"

WORK_DIR=$HOME/TNBC_Project/Concatenation

cd $WORK_DIR

data_dir='/archive/NabaviLab/TNBC_Project/fastq_raw_data/Project_5065_F/*'
for instrument in $data_dir; do
	cd $instrument'/Project_5065_F/'
	for sample in */; do
		cd $sample
		# remove all R1 and R2 files
		rm *R1*.fastq.gz
		rm *R2*.fastq.gz
		# rename the full R1 and R2
		name=${PWD##*/}
		mv r1.fastq.gz $name'-R1.fastq.gz'
		mv r2.fastq.gz $name'-R2.fastq.gz'
		cd ..
	done
done
