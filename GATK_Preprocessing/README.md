# Preprocessing for GATK pipeline
We used the Picard v2.3.0 to convert SAM files to fixed BAM files. We set the maximum java heap size to 14G to run the sorting faster. Why 14GB? As suggested by the FAQ in [this link](http://broadinstitute.github.io/picard/faq.html), second question, experiments recommend to set the maximum heap size (by setting the flag -Xmx) no higher than 2GB less than the memory limit. As the per our hardware configuration (see below), the least capable node that the script might be executed on has a RAM size of 16GB. We can improve the performance more by logging in to the most capable node in the cluster and run the script on it (after setting the maximum heap to a very hight value).

## Hardware
The computation was run on the BBC cluster (bbcsrv3.biotech.uconn.edu).
[see cluster configuration](http://bioinformatics.uconn.edu/hardware)
