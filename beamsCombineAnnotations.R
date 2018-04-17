library(plyr)

beamsSummary <- read.delim("Z:/users/ajh784/Feb18minaturisationwork/1.0mmid/plasma/Pos/DataAnalysis/dil1/summary.txt")
xcmsOutput <- read.csv("Z:/users/ajh784/Feb18minaturisationwork/1.0mmid/plasma/Pos/ConvertedData/Dil1/finalpos1_0_Dil1FILTERED_beamsID.csv")
colnames(xcmsOutput)[1]<-"name"

combinedNames <- ddply(beamsSummary, .(name), summarize,
                       compound_name=paste(unique(compound_name),collapse=", "))
combinedAdducts <- ddply(beamsSummary, .(name), summarize,
                         adduct=paste(unique(adduct),collapse=", "))
combinedMolecularFormula <- ddply(beamsSummary, .(name), summarize,
                                  molecular_formula=paste(unique(molecular_formula),collapse=", "))
combinedPPM <- ddply(beamsSummary, .(name), summarize,
                     ppm_error=paste(unique(ppm_error),collapse=", "))

combined <- merge(combinedNames, combinedAdducts, by="name")
combined <- merge(combined, combinedMolecularFormula, by="name")
combined <- merge(combined, combinedPPM, by="name")

#xcmsOutput$name <- paste("M", xcmsOutput$X, sep='') 

mergedData <- merge(xcmsOutput, combined, by="name")