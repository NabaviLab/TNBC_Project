# download a gene definition file and associated FASTA
annotate_variation.pl -buildver hg19 -downdb -webfrom annovar refGene humandb

# Prepare input files, format inversion
convert2annovar.pl -format vcf4 snp.somatic.hc.vcf -outfile somatic.snp.hc.sample

# gene-based annotation
annotate_variation.pl -buildver hg19 -outfile somatic.snp.hc -hgvs somatic.snp.hc.sample humandb/
