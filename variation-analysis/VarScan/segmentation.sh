#!/bin/bash
#$ -N segmentation
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -o $JOB_ID.out"
#$ -e $JOB_ID.err"


module load R/3.2.2

patients=(085 086 087 093 094 095 097 098 099 100 101 102 105 107 108 109 110 111 112 113 114 116 117 119 120 122 123 124 125 126 128 129-1 129-2 130 131 132 133 134 135 136) 

for patient in ${patients[@]} 
do
	Rscript segmentation.R $patient
done
