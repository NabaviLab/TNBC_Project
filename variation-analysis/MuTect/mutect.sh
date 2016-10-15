#!/bin/bash
#$ -N somatic_mutect
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -o $JOB_ID.out"
#$ -e $JOB_ID.err"

WORK_DIR=$HOME/Patients
cd $WORK_DIR

module load java6

PATIENT_ID=$1
mkdir MuTect_output/patient_$PATIENT_ID

java -Xmx14g -jar /common/opt/bioinformatics/mutect/muTect-1.1.4.jar \
--analysis_type MuTect \
--reference_sequence $HOME/hg19/genome.fa \
--cosmic mutectdbs/b37_cosmic_v54_120711.vcf \
--dbsnp mutectdbs/dbsnp_132_b37.leftAligned.vcf \
--input_file:normal GATK_output/p_DS_bkm_$PATIENT_ID-N/p_DS_bkm_$PATIENT_ID-N.sorted.MarkDup.realn.fixed.bam \
--input_file:tumor GATK_output/p_DS_bkm_$PATIENT_ID-T/p_DS_bkm_$PATIENT_ID-T.sorted.MarkDup.realn.fixed.bam \
--out MuTect_output/patient_$PATIENT_ID/call_stats.txt \
--coverage_file MuTect_output/patient_$PATIENT_ID/coverage.wig.txt \
--vcf MuTect_output/patient_$PATIENT_ID/result.vcf
