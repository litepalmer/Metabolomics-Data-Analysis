filterFunc <- function(x, startColumn, numberOfSamplesWithinGroup, rsdThreshold = 0.3){
  columns <- startColumn:(startColumn+numberOfSamplesWithinGroup-1)
  extractedStartColumn <- 8
  extract <- extractedStartColumn:(extractedStartColumn+numberOfSamplesWithinGroup-1)
  x       <- as.data.frame(c(df[1:7],df[columns]))
  x$rsd   <- apply(x[extract], 1, function(x) sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE))
  x <- subset(x, x$rsd <= rsdThreshold)
  x <- as.data.frame(c(x[1],x[extract]))
  return(x)
}
removeAllNASamples <- function(x, totalNumberOfSamples){
  columnsToCheck <- 8:(8+totalNumberOfSamples-1)
  x$count <- apply(x[columnsToCheck], 1, function(x) length(which(!is.na(x))))
  x <- subset(x, x$count > 0)
  
}
blankFilter <- function(x, totalNumberOfBlanks){
  blankColumns <- 8:(8+totalNumberOfBlanks-1)
  x$blankCount <- apply(MVfilteredDataset[blankColumns],1,function(x) length(which(!is.na(x))))
  x <- subset(x, x$blankCount == 0)
  x <- x[blankColumns]
}

## READ IN CSV FILE
df <- read.csv("/Users/elliottpalmer/Downloads/FinalLipids_Pos_1_0.csv")

## FILL IN THIS INFORMATION
totalNumberOfSamples <- 33
totalNumberOfBlanks <- 3

## (NAME OF CLASS, START COLUMN, NUMBER OF SAMPLES)
blank <- filterFunc(blank, 18, 3)
dil1 <- filterFunc(dil1, 21, 4)
dil2 <- filterFunc(dil1, 25, 4)
dil3 <- filterFunc(dil1, 29, 4)
dil4 <- filterFunc(dil1, 33, 4)
dil5 <- filterFunc(dil1, 37, 4)
dil6 <- filterFunc(dil1, 41, 4)
dil7 <- filterFunc(dil1, 45, 4)
QC <- filterFunc(QC, 49, 2)

filteredDataset <- merge(df[1:7], blank, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, QC, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil1, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil2, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil3, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil4, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil5, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil6, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil7, by = "X", all = TRUE)

MVfilteredDataset <- removeAllNASamples(filteredDataset, totalNumberOfSamples)
blankFilteredDataset <- blankFilter(MVfilteredDataset,totalNumberOfBlanks)

## WRITE CSV
write.csv(filteredDatasetNoBlank, "C:\\Users\\eap520\\Downloads\\filteredDataset.csv", row.names = F)


