#!/bin/bash

#############################################################
##### TEMPLATE SGE SCRIPT - BLAST EXAMPLE ###################
#############################################################

# Specify the filenames
INPUTFILES=(test1.fasta test2.fasta test3.fasta test4.fasta)

# Name the directory (assumed to be a direct subdir of $HOME) from which the file is located
PROJECT_SUBDIR="test"

# Specify name to be used to identify this run
#$ -N blastp_array_job

# Email address (change to yours)
#$ -M bioinformatics@uconn.edu

# Specify mailing options: b=beginning, e=end, s=suspended, n=never, a=aborted or suspended
#$ -m besa

# This sets the task range in the array from 1 to 4 with a step size of 1   
#$ -t 1-4:1
# This sets the maximum number of concurrent tasks to 2, so that no more than 2 jobs will be run at once
#$ -tc 2
# Specify that bash shell should be used to process this script
#$ -S /bin/bash

# Pull data file name from list defined above according to job id
INPUTFILENAME="${INPUTFILES[$SGE_TASK_ID - 1]}"

# Specify working directory (created on compute node used to do the work)
WORKING_DIR="/scratch/$USER/$PROJECT_SUBDIR-$SGE_TASK_ID"

# If working directory does not exist, create it
# The -p means "create parent directories as needed"
if [ ! -d "$WORKING_DIR" ]; then
mkdir -p $WORKING_DIR
fi

# Specify destination directory (this will be subdirectory of your home directory)
DESTINATION_DIR="$HOME/$PROJECT_SUBDIR/$SGE_TASK_ID-$INPUTFILENAME"

# If destination directory does not exist, create it
# The -p in mkdir means "create parent directories as needed"
if [ ! -d "$DESTINATION_DIR" ]; then
mkdir -p $DESTINATION_DIR
fi

# navigate to the working directory
cd $WORKING_DIR

# Get script and input data from home directory and copy to the working directory
cp $HOME/$PROJECT_SUBDIR/$INPUTFILENAME ./$INPUTFILENAME
cp $HOME/template_array.sh .

# Specify the output file
#$ -o $SGE_TASK_ID.out

# Specify the error file
#$ -e $SGE_TASK_ID.err

# Run the program
blastp -query $INPUTFILENAME -db /usr/local/blast/data/refseq_protein -num_alignments 5 -num_descriptions 5 -out my-results

# copy output files back to your home directory
cp * $DESTINATION_DIR
#mv $DESTINATION_DIR/files.fasta $DESTINATION_DIR/$INPUTFILENAME

# clear scratch directory
rm -rf $WORKING_DIR