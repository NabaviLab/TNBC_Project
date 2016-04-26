#!/bin/bash

#############################################################
##### TEMPLATE SGE SCRIPT - BLAST EXAMPLE ###################
#############################################################

# Specify the name of the data file to be used
INPUTFILENAME="test.fasta"

# Name the directory (assumed to be a direct subdir of $HOME) from which the file
# listed in DATA_FILE is located and into which the output files will be deposited
PROJECT_SUBDIR="test"

# Specify name to be used to identify this run
#$ -N mpiblastp_job

# Email address (change to yours)
#$ -M bioinformatics@uconn.edu

# Specify mailing options: b=beginning, e=end, s=suspended, n=never, a=aborted or suspended
#$ -m besa

# Specify that bash shell should be used to process this script
#$ -S /bin/bash

# request a parallel environment
#$ -pe orte 12

# Specify working directory (created on compute node used to do the work)
WORKING_DIR="/scratch/$USER/$PROJECT_SUBDIR-$JOB_ID"

# If working directory does not exist, create it
# The -p means "create parent directories as needed"
if [ ! -d "$WORKING_DIR" ]; then
mkdir -p $WORKING_DIR
fi

# Specify destination directory (this will be subdirectory of your home directory)
DESTINATION_DIR="$HOME/$PROJECT_SUBDIR/$JOB_ID-$INPUTFILENAME"

# If destination directory does not exist, create it
# The -p in mkdir means "create parent directories as needed"
if [ ! -d "$DESTINATION_DIR" ]; then
mkdir -p $DESTINATION_DIR
fi

# navigate to the working directory
cd $WORKING_DIR

# Get script and input data from home directory and copy to the working directory
cp $HOME/$PROJECT_SUBDIR/$INPUTFILENAME ./test.fasta
cp $HOME/template_mpi.sh .

# Specify the output file
#$ -o $JOB_ID.out

# Specify the error file
#$ -e $JOB_ID.err

# Run the program
mpirun mpiblast -p blastp -d /usr/local/blast/data/refseq_protein -i $INPUTFILENAME -o my-results

# copy output files back to your home directory
cp * $DESTINATION_DIR

# clear scratch directory
rm -rf $WORKING_DIR