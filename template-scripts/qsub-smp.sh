#!/bin/bash -l
# this is a qsub submission script for running a multi-threaded job

# use the Bash shell to execute the job
#$ -S /bin/bash

# Give the job a name
#$ -N mysmpjob

# send the job output to a file.  $JOB_ID will be substitued with the actual job number
#$ -o $HOME/mysmpjob-$JOB_ID.out

# send the job error messages to a file
#$ -e $HOME/mysmpjob-$JOB_ID.err

# request a parallel environment (pe) that uses 4 job slots 
# all on a single compute node (smp - symmetric multi-processing)
#$ -pe smp 4

# define a variable for your working directory - replace this with the actual directory name
# this directory should already exist
WORK_DIR=$HOME/partfind

# change to the $WORK_DIR
cd $WORK_DIR

# Execute the job from the current working directory
#$ -cwd

# now run the actual job - replace this with the multi-threaded program that you want to run along with any command line arguments
# the following will run the PartitionFinder.py python script using 4 cores (1 core = 1 job slot)

python /common/opt/bioinformatics/PartitionFinder/PartitionFinder.py --processes=4 .

