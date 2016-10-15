library(cghMCR)
library(DNAcopy)

rm(list=ls())
name <-"A0B3"
args <- commandArgs(trailingOnly=TRUE)
patientNum <- args[1]
setwd("/archive/NabaviLab/TNBC_Project/fastq_raw_data/Project_5065_F/Patients/VarScan_output")
name <- paste("patient_", patientNum, sep="")
name
setwd(name)
varcopy <- paste(name,".copynumber", ".called", sep="")
cnv <- read.table(varcopy,header=T)
cnv$chrom <- gsub("chr","", cnv$chrom)
head(cnv)
#deleting chrY and chrM
#idx <- which(cnv$chrom=="Y" |cnv$chrom=="M")
#cnv <- cnv[-idx,]
#setwd("/archive/NabaviLab/Nick/AbdelrahmanVarscanResults")
# viewing the data
hist(cnv$tumor_depth, breaks=2000, xlim=c(0,1000))
'hist?'

#deleting bins that have more than #3000 read count per pb, these are because of PCR duplication in sequencing machine
idx <- which(cnv$tumor_depth>3000 | cnv$normal_depth> 3000) 
'idx'
cnv <- cnv[-idx,]
'cnv <- -idx'

#deleting unsignificant bins
idx <- which( (cnv$tumor_depth + cnv$normal_depth) < 100 ) 
'idx'
cnv <- cnv[-idx,]
'cnv <- -idx'

hist(cnv$adjusted_log_ratio, breaks=200)
mean(cnv$adjusted_log_ratio)


# If the mean is not close to zero
#normalizing the diff read count. the number of reads in Tumors and normals are not equal.
# I am assuming the mean of diff read count should be zero. subtracting the mean
cnv$adjusted_log_ratio <- cnv$adjusted_log_ratio - mean(cnv$adjusted_log_ratio)

mean(cnv$adjusted_log_ratio)

hist(cnv$adjusted_log_ratio, breaks=200)

# generating segments of cnv using BCS, after smoothing the readcounts
CNA.sim.object <-CNA( genomdat = cnv[,7], chrom = cnv[,1], maploc = cnv[,2] + (cnv[,3]-cnv[,2])/2, data.type = 'logratio', sampleid=name)
CNA.sim.smoothed <- smooth.CNA(CNA.sim.object)


#undo.SD parameter can be set such that make the results smother
segs.sim<- segment(CNA.sim.smoothed, verbose=1,p.method='perm',undo.split='sdundo',undo.SD=4)
#..this step takes awhile. 

# saving the segment lists
segs <- paste(name, ".segs", sep="")
save(segs.sim, file=segs)
##################################################################################
#ploting by regions 
zoomIntoRegion(segs.sim, chrom=1, sampleid=1, maploc.start=2e07, maploc.end=4e7)
zoomIntoRegion(segs.sim, chrom="1", sampleid=1)


#plot all chromosomes
png((paste(name,".png",sep="")),height=840, width=1080)
par(mfrow=c(4,6),oma=c(2,2,2,2))
for(i in c(1:22, "X","Y")){
  #plotSample(segs.L1L2,chromlist=i, ylim=c(-3,3),xlab = 'Index', ylab ='log2(tumor/liver)', main =paste("chr",i,sep=""),cex.lab=1.5)
  zoomIntoRegion(segs.sim, chrom=i, sampleid=1,pt.col="black", ylim=c(-3,3), ylab ='log2(tumor/sample)',main =paste("chr",i,sep=""),cex.lab=1.8,cex.axis=1.5, cex.main=1.5)
  abline(h=0, col="gray",lwd=3)
}
title("tumor vs normal",outer=TRUE,cex.main=2)
dev.off()

#############################################################################
#looking at output list

Seglist <- segs.sim[["output"]]
head(Seglist)


#generating CNSeg object
segData <- CNSeg(Seglist)

#setwd("/archive/NabaviLab/Nick/AbdelrahmanVarscanResults/")
#setwd(name)
write.table(Seglist, file=paste(name,"_seg.txt",sep=""),sep="\t", quote=FALSE,row.names=F )

geneInfo <- read.table("geneInfo.hg19.txt",header=T)

convertedData <- getRS(segData, by = "gene", imput = FALSE, XY = TRUE, geneMap = geneInfo,what = "mean")
rsData<-rs(convertedData)

#eliminating replicated genenames
geneListUq<-rsData[!duplicated(rsData[,"genename"]),]

head(geneListUq)
filename <- paste(name, '.geneList.Var.txt', sep="")
write.table(geneListUq, file=filename,sep="\t", quote=FALSE,row.names=F )
