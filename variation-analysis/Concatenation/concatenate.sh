#!/bin/bash


# this is a simple qsub submission script for running a serial (single-threaded) job
# the script concatenates the data of TNBC_Project
# each sample is concatenated into two files, one for R1 and the other for R2

# use the Bash shell to execute the job
#$ -S /bin/bash

# Give the job a name
#$ -N abdelrahman_concatenate

# send the job output to a file.  $JOB_ID will be substitued with the actual job number
#$ -o $HOME/TNBC_Project/Concatenation/abdelrahman_concatenate-$JOB_ID.out

# send the job error messages to a file
#$ -e $HOME/TNBC_Project/Concatenation/abdelrahman_concatenate-$JOB_ID.err

# define a variable for your working directory - replace this with the actual directory name
# this directory should already exist
WORK_DIR=$HOME/TNBC_Project/Concatenation

# change to the $WORK_DIR
cd $WORK_DIR

# Execute the job from the current working directory
#$ -cwd

# now run the actual job of concatenation
data_dir='/archive/NabaviLab/TNBC_Project/fastq_raw_data/Project_5065_F/*'
for instrument in $data_dir; do
	cd $instrument'/Project_5065_F/'
	for sample in */; do
		cd $sample
		# concatenate using cat
		cat *R1*.fastq.gz > r1.fastq.gz
		cat *R2*.fastq.gz > r2.fastq.gz
		echo 'concatenated sample '$sample >> $WORK_DIR/progress.log
		cd ..
	done
	echo 'done concatenating all samples from instrument '$instrument >> $WORK_DIR/progress.log
	echo ''
done
