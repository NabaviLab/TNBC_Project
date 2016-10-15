#!/bin/bash
#$ -N cnv
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -o $JOB_ID.out"
#$ -e $JOB_ID.err"

cd $1
awk -F"\t" '$4 > 0 && $7 > 0' $1.pileup | java -jar /export/apps/VarScan.v2.4.2.jar copynumber $1 --mpileup 1
java -jar /export/apps/VarScan.v2.4.2.jar copyCaller output.copynumber --output-file $1.copynumber.called
