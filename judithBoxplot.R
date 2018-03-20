library(plyr)
library(dplyr)
library(reshape2)
library(readr)
library(data.table)
library(ggplot2)

#Read in 
files <- list.files("/Users/elliottpalmer/Downloads/judith")
data <- lapply(files, FUN=read.table, header=TRUE)
names(data) <- basename(files)
df <- rbindlist(data, idcol = "index")

df.melt <- melt(data = df, id.vars = c("mz","index") )
df.rsd <- filter(df.melt, variable == "rsd", value != 0)
df.outOf <- filter(df.melt, variable == "present")

bp <- ggplot(df.rsd, aes(x=index, y=value, group = index)) + geom_boxplot()
bp 

outOf <- ggplot(df.outOf, aes(value)) + geom_bar(width = .8,stat = "count") + facet_grid(. ~ index)
outOf
