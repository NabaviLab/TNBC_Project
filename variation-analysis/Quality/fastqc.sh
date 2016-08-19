#!/bin/bash


# this is a simple qsub submission script for running a serial (single-threaded) job
# the script concatenates the data of TNBC_Project
# each sample is concatenated into two files, one for R1 and the other for R2

# use the Bash shell to execute the job
#$ -S /bin/bash

# Give the job a name
#$ -N abdelrahman_fastqc

# send the job output to a file.  $JOB_ID will be substitued with the actual job number
#$ -o $HOME/TNBC_Project/Quality/abdelrahman_fastqc-$JOB_ID.out

# send the job error messages to a file
#$ -e $HOME/TNBC_Project/Quality/abdelrahman_fastqc-$JOB_ID.err

# define a variable for your working directory - replace this with the actual directory name
# this directory should already exist
WORK_DIR=$HOME/TNBC_Project/Quality

# change to the $WORK_DIR
cd $WORK_DIR

# Execute the job from the current working directory
#$ -cwd

# now run the actual job of concatenation
data_dir='/archive/NabaviLab/TNBC_Project/fastq_raw_data/Project_5065_F/Patients/*'
for patient in $data_dir; do
	for sample in $patient'/*'; do
		fastqc $sample
	done
	echo 'done with patient '$patient
	echo ''
done
