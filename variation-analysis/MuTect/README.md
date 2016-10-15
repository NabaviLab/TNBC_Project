# MuTect
We used MuTect v1.1.4 to accurately identify somatic point mutations.

COSMIC file used: ```hg19_cosmic_v54_120711.vcf```

dbSNP file used:  ```dbsnp_132_b37.leftAligned.vcf```

### Hints
- You might need to change contig names in these database files to match your reads.
- You might need to re-order the contigs in these database to match the order of the index in your reference genome.

## Hardware
The computation was run on the BBC cluster (bbcsrv3.biotech.uconn.edu).

[see cluster configuration](http://bioinformatics.uconn.edu/hardware)
