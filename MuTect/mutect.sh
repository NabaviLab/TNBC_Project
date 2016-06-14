#!/bin/bash -l
# this is a simple qsub submission script for running a serial (single-threaded) job

# use the Bash shell to execute the job
#$ -S /bin/bash

# Give the job a name
#$ -N abdelrahman_mutect

# send the job output to a file.  $JOB_ID will be substitued with the actual job number
#$ -o $HOME/TNBC_Project/MuTect/logs/abdelrahman_mutect-$JOB_ID.out

# send the job error messages to a file
#$ -e $HOME/TNBC_Project/MuTect/logs/abdelrahman_mutect-$JOB_ID.err

# define a variable for your working directory - replace this with the actual directory name
# this directory should already exist
WORK_DIR=$HOME/Patients

# change to the $WORK_DIR
cd $WORK_DIR

# Execute the job from the current working directory
#$ -cwd

# now run the actual job - replace this with the program you want to run along with any command line arguments
module load java6

PATIENT_ID=$1
mkdir MuTect_output/patient_$PATIENT_ID-2

java -Xmx14g -jar /common/opt/bioinformatics/mutect/muTect-1.1.4.jar \
--analysis_type MuTect \
--reference_sequence $HOME/hg19/genome.fa \
--cosmic mutectdbs/b37_cosmic_v54_120711.vcf \
--dbsnp mutectdbs/dbsnp_132_b37.leftAligned.vcf \
--input_file:normal GATK_output/p_DS_bkm_$PATIENT_ID-N/p_DS_bkm_$PATIENT_ID-N.sorted.MarkDup.realn.fixed.bam \
--input_file:tumor GATK_output/p_DS_bkm_$PATIENT_ID-T2/p_DS_bkm_$PATIENT_ID-T2.sorted.MarkDup.realn.fixed.bam \
--out MuTect_output/patient_$PATIENT_ID-2/call_stats.txt \
--coverage_file MuTect_output/patient_$PATIENT_ID-2/coverage.wig.txt \
--vcf MuTect_output/patient_$PATIENT_ID-2/result.vcf
