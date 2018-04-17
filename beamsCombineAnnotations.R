library(plyr)

data <- read.delim("/Users/elliottpalmer/Downloads/summary.txt")
combinedAnnotations <- ddply(data, .(name), summarize,
              compound_name=paste(unique(compound_name),collapse=","))
