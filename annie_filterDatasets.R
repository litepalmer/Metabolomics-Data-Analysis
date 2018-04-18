df <- read.csv("C:\\Users\\eap520\\Downloads\\FinalLipids_Pos_1_0.csv")

variableMetadata <- df[1:7]

blank <- as.data.frame(c(df[1:7],df[18:20]))
dil1 <- as.data.frame(c(df[1:7],df[21:24]))
dil2 <- as.data.frame(c(df[1:7],df[25:28]))
dil3 <- as.data.frame(c(df[1:7],df[29:32]))
dil4 <- as.data.frame(c(df[1:7],df[33:36]))
dil5 <- as.data.frame(c(df[1:7],df[37:40]))
dil6 <- as.data.frame(c(df[1:7],df[41:44]))
dil7 <- as.data.frame(c(df[1:7],df[45:48]))
QC <- as.data.frame(c(df[1:7],df[49:50]))


blank$rsd <- apply(blank[8:10], 1, function(x) sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE))
dil1$rsd <- apply(dil1[8:11], 1, function(x) sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE))
dil2$rsd <- apply(dil2[8:11], 1, function(x) sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE))
dil3$rsd <- apply(dil3[8:11], 1, function(x) sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE))
dil4$rsd <- apply(dil4[8:11], 1, function(x) sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE))
dil5$rsd <- apply(dil5[8:11], 1, function(x) sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE))
dil6$rsd <- apply(dil6[8:11], 1, function(x) sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE))
dil7$rsd <- apply(dil7[8:11], 1, function(x) sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE))
QC$rsd <- apply(QC[8:9], 1, function(x) sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE))

blankSubset <- subset(blank, blank$rsd <= 0.3)
dil1Subset <- subset(dil1, dil1$rsd <= 0.3)
dil2Subset <- subset(dil2, dil2$rsd <= 0.3)
dil3Subset <- subset(dil3, dil3$rsd <= 0.3)
dil4Subset <- subset(dil4, dil4$rsd <= 0.3)
dil5Subset <- subset(dil5, dil5$rsd <= 0.3)
dil6Subset <- subset(dil6, dil6$rsd <= 0.3)
dil7Subset <- subset(dil7, dil7$rsd <= 0.3)
QCSubset <- subset(QC, QC$rsd <= 0.3)

blankFiltered <- as.data.frame(c(blankSubset[1],blankSubset[8:10]))
dil1Filtered <- as.data.frame(c(dil1Subset[1],dil1Subset[8:11]))
dil2Filtered <- as.data.frame(c(dil2Subset[1],dil2Subset[8:11]))
dil3Filtered <- as.data.frame(c(dil3Subset[1],dil3Subset[8:11]))
dil4Filtered <- as.data.frame(c(dil4Subset[1],dil4Subset[8:11]))
dil5Filtered <- as.data.frame(c(dil5Subset[1],dil5Subset[8:11]))
dil6Filtered <- as.data.frame(c(dil6Subset[1],dil6Subset[8:11]))
dil7Filtered <- as.data.frame(c(dil7Subset[1],dil7Subset[8:11]))
QCFiltered <- as.data.frame(c(QCSubset[1],QCSubset[8:9]))

filteredDataset <- merge(variableMetadata, blankFiltered, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil1Filtered, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil2Filtered, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil3Filtered, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil4Filtered, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil5Filtered, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil6Filtered, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, dil7Filtered, by = "X", all = TRUE)
filteredDataset <- merge(filteredDataset, QCFiltered, by = "X", all = TRUE)

filteredDataset$count <- apply(filteredDataset[8:40], 1, function(x) length(which(!is.na(x))))
filteredDataset <- subset(filteredDataset, filteredDataset$count > 0)

filteredDataset$sampleCount <- apply(filteredDataset[11:40], 1, function(x) length(which(!is.na(x))))
filteredDataset$blankCount <- apply(filteredDataset[8:10], 1, function(x) length(which(!is.na(x))))


filteredDataset <- subset(filteredDataset, filteredDataset$blankCount == 0)
filteredDatasetNoBlank <- filteredDataset[-8:-10]

write.csv(filteredDatasetNoBlank, "C:\\Users\\eap520\\Downloads\\filteredDataset.csv", row.names = F)


