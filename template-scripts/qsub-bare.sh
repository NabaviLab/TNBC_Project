#!/bin/bash -l
# this is a simple qsub submission script for running a serial (single-threaded) job

# use the Bash shell to execute the job
#$ -S /bin/bash

# Give the job a name
#$ -N myjob

# send the job output to a file.  $JOB_ID will be substitued with the actual job number
#$ -o $HOME/myjob-$JOB_ID.out

# send the job error messages to a file
#$ -e $HOME/myjob-$JOB_ID.err

# define a variable for your working directory - replace this with the actual directory name
# this directory should already exist
WORK_DIR=$HOME/mydirectory

# change to the $WORK_DIR
cd $WORK_DIR

# Execute the job from the current working directory
#$ -cwd

# now run the actual job - replace this with the program you want to run along with any command line arguments
# the following will just wait for 30 seconds and then exit

sleep 30

