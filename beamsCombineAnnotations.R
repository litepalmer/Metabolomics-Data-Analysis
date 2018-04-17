library(plyr)

beamsSummary <- read.delim("/Users/elliottpalmer/Downloads/summary.txt")
combinedAnnotations <- ddply(beamsSummary, .(name), summarize,
              compound_name=paste(unique(compound_name),collapse=","))

xcmsOutput <- read.csv("/Users/elliottpalmer/Downloads/final_Lipid_Pos_2_1dil1FILTERED.csv")
xcmsOutput$name <- paste("M", xcmsOutput$X, sep='') 

mergedData <- merge(xcmsOutput, combinedAnnotations, by="name")
