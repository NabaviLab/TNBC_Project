#!/bin/bash
#$ -N concatenate
#$ -M abdelrahman@engr.uconn.edu
#$ -m n
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -o $JOB_ID.out"
#$ -e $JOB_ID.err"
#!/bin/bash


WORK_DIR=$HOME/TNBC_Project/Concatenation
cd $WORK_DIR

data_dir='/archive/NabaviLab/TNBC_Project/fastq_raw_data/Project_5065_F/*'
for instrument in $data_dir; do
	cd $instrument'/Project_5065_F/'
	for sample in */; do
		cd $sample
		# concatenate using cat
		cat *R1*.fastq.gz > r1.fastq.gz
		cat *R2*.fastq.gz > r2.fastq.gz
		echo 'concatenated sample '$sample >> $WORK_DIR/progress.log
		cd ..
	done
	echo 'done concatenating all samples from instrument '$instrument >> $WORK_DIR/progress.log
	echo ''
done
