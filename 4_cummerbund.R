#####################################################################
# This R script 
#   1) uses the R cummeRbund package to generate a heatmap
#	of differentially expressed genes
#   2) assumes a q-value threshold of 0.0005 to determine "significant
#	expression level difference"
#####################################################################

# Note: The cuffdiff output folder: f1f2_p1p2 is necessary for this step,
# if this step is being done locally, that folder must be downloaded

source("https://bioconductor.org/biocLite.R")
biocLite("cummeRbund")
install.packages("Hmisc")
library("cummeRbund")

#Paths to cuffdiff output folder
f1f2_p1p2 <- ".\\align\\f1f2_p1p2"

#f1f2_p1p2,  2 fungal replicates vs. 2 plant replicates
cuff_data1 <- readCufflinks(dir = f1f2_p1p2)
sigGeneIds<-getSig(cuff_data1, alpha=0.0005, level="genes")
sigGenes<-getGenes(cuff_data1, sigGeneIds)
hm_f1f2_p1p2<-csHeatmap(sigGenes, fullnames="FALSE", replicates='T')
hm_f1f2_p1p2