#!/bin/bash
#$ -N fusioncatcher
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 4
#$ -o fusioncatcher_$JOB_ID.out"
#$ -e fusioncatcher_$JOB_ID.err"

python /home/abdelrahman/fusioncatcher/bin/fusioncatcher.py \
-d /common/opt/bioinformatics/fusioncatcher/data/ensembl_v84 \
-i $1'FASTQ/' \
-o $1 
