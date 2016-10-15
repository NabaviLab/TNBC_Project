#!/bin/bash
#$ -N somatic
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -o $JOB_ID.out"
#$ -e $JOB_ID.err"


cd $1
java -jar /export/apps/VarScan.v2.4.2.jar somatic $1.pileup $1 --mpileup 1 --output-vcf 1 --min-coverage 10 --min-var-freq 0.08 --somatic-p-value 0.05
java -jar /export/apps/VarScan.v2.4.2.jar processSomatic $1.snp.vcf
java -jar /export/apps/VarScan.v2.4.2.jar processSomatic $1.indel.vcf
java -jar /export/apps/VarScan.v2.4.2.jar somaticFilter $1.snp.Somatic.hc.vcf --indel-file $1.indel.vcf --output-file $1.snp.Somatic.hc.filter.vcf
