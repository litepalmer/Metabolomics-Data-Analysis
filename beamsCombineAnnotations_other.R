library(plyr)
library(splitstackshape)

variableMetadata <- read.delim("C:\\_dataProcessing\\beams\\rickDataAnalysis\\beamsLocalDatabase\\plasma_lipids_pos_newcastle\\tests\\test_data\\variableMetadata.txt")
dataMatrix <- read.delim("C:\\_dataProcessing\\beams\\rickDataAnalysis\\beamsLocalDatabase\\plasma_lipids_pos_newcastle\\tests\\test_data\\dataMatrix.txt")
localBeamsSummary <- read.delim("C:\\_dataProcessing\\beams\\rickDataAnalysis\\beamsLocalDatabase\\plasma_lipids_pos_newcastle\\tests\\test_results\\summary.txt", sep = "\t")
hmdbBeamsSummary <- read.delim("C:\\_dataProcessing\\beams\\rickDataAnalysis\\beamsHMDBDatabase\\plasma_lipids_pos_newcastle\\tests\\test_results\\summary.txt", sep = "\t")

combinedLocalCompoundNames <- cSplit(localBeamsSummary, 'compound_name', sep = ','
       , direction = 'long')[, .("localdb_compound_name" = toString(unique(compound_name)))
                             , by = name]

combinedHMDBCompoundNames <- cSplit(hmdbBeamsSummary, 'compound_name', sep = ','
                                     , direction = 'long')[, .("hmdb_compound_name" = toString(unique(compound_name)))
                                                           , by = name]

combined <- merge(variableMetadata, combinedLocalCompoundNames, by = "name", all = TRUE)
combined <- merge(combined, combinedHMDBCompoundNames, by = "name", all = TRUE)



putmetid <- read.delim("C:\\_dataProcessing\\beams\\rickDataAnalysis\\PutMetID\\plasma_lipids_pos_newcastle\\Allpeaks_txt.text")
putcompounds <- putmetid[,c(1,16)]


combined <- merge(combined, putcompounds, by = "name")
colnames(combined)[4] <- "local database"
colnames(combined)[5] <- "HMDB"
colnames(combined)[6] <- "PutMetID"

write.csv(combined, "C:\\_dataProcessing\\beams\\rickDataAnalysis\\PutMetID\\plasma_lipids_pos_newcastle\\combinedAnnotations.csv")
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
combined <- mer