library(plyr)
library(dplyr)
library(reshape2)
library(readr)
library(data.table)
library(ggplot2)

#List all files in specific directory
files <- list.files("/Users/elliottpalmer/Downloads/judith")

#Read in all files in set directory
data <- lapply(files, FUN=read.table, header=TRUE)

#Set names in list to base file names
names(data) <- basename(files)

#Combine list into dataframe with index being identifier of which data belongs to which file
df <- rbindlist(data, idcol = "index")

#Melt data into ggplot friendly dataframe and subset out data of interest
df.melt <- melt(data = df, id.vars = c("mz","index") )
df.rsd <- filter(df.melt, variable == "rsd", value != 0)
df.outOf <- filter(df.melt, variable == "present")

#Create boxplots of rsd
bp <- ggplot(df.rsd, aes(x=index, y=value, group = index)) + geom_boxplot()
bp 

#Create bar plots of present value
outOf <- ggplot(df.outOf, aes(value)) + geom_bar(width = .8,stat = "count") + facet_grid(. ~ index)
outOf
