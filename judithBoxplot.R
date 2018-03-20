library(dplyr)
library(reshape2)
library(plyr)
library(readr)
library(purrr)
library(data.table)
library(ggplot2)


data <- lapply(files, FUN=read.table, header=TRUE)
df <- rbindlist(data, idcol = "index")

 
df <- read.delim("/Users/elliottpalmer/Downloads/Galaxy_Blank_Filter_Peak_Intensity_Matrix_Dust1_Apolar_Pos_10.txt",sep = "\t")
df.melt <- melt(data = df, id.vars = "mz")
df.rsd <- filter(df.melt, variable == "rsd", value != 0)
df.outOf <- filter(df.melt, variable == "present")

bp <- ggplot(df.rsd, aes(x=1, y=value)) + geom_boxplot()
bp 

outOf <- ggplot(df.outOf, aes(value)) + geom_bar()
outOf
