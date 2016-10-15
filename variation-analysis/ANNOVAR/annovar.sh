#!/bin/bash
#$ -N annovar
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -o $JOB_ID.out"
#$ -e $JOB_ID.err"


patients=(085 086 087 093 094 095 097 098 099 100 101 102 105 107 108 109 110 111 112 113 114 116 117 119 120 122 123 124 125 126 128 129-1 129-2 130 131 132 133 134 135 136) 

for patient_id in ${patients[@]} 
do
	cd 'patient_'$patient_id
	echo 'working on '$(pwd)
	/archive/NabaviLab/abdelrahman/annovar/convert2annovar.pl -format vcf4old patient_$patient_id.snp.Somatic.hc.filter.vcf > patient_$patient_id.snp.Somatic.hc.filter.avinput
	echo 'prepared input for '$patient_id
	/archive/NabaviLab/abdelrahman/annovar/annotate_variation.pl -out patient_$patient_id -build hg19 patient_$patient_id.snp.Somatic.hc.filter.avinput /archive/NabaviLab/abdelrahman/annovar/humandb
	echo 'finished '$patient_id
	cd ..
done
