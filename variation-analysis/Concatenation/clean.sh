#!/bin/bash


# this is a simple qsub submission script for running a serial (single-threaded) job
# the script cleans the samples after concatenation (deletes individual samples)

# use the Bash shell to execute the job
#$ -S /bin/bash

# Give the job a name
#$ -N abdelrahman_clean

# send the job output to a file.  $JOB_ID will be substitued with the actual job number
#$ -o $HOME/TNBC_Project/Concatenation/abdelrahman_clean-$JOB_ID.out

# send the job error messages to a file
#$ -e $HOME/TNBC_Project/Concatenation/abdelrahman_clean-$JOB_ID.err

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
