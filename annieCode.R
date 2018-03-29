library(plyr)
library(dplyr)
library(reshape2)
library(readr)
library(data.table)
library(ggplot2)
library(ggpubr)

#List all files in specific directory

setwd("/Users/elliottpalmer/Downloads/annie")
files <- list.files("/Users/elliottpalmer/Downloads/annie")

#Read in all files in set directory
data <- lapply(files, FUN=read.table, header=TRUE)

#Set names in list to base file names
names(data) <- basename(files)

#Combine list into dataframe with index being identifier of which data belongs to which file
df <- rbindlist(data, idcol = "index")
df.sd <- apply(df[,3:6], 1, sd)
df.mean <- apply(df[,3:6], 1, mean)
df.rsd <- (df.sd/df.mean)*100
df.count <- apply(df[,3:6], 1, function(x) length(which(!is.na(x))))
df <- cbind(df, df.rsd, df.count)


#Melt data into ggplot friendly dataframe and subset out data of interest
df.melt <- melt(data = df, id.vars = c("name","index") )
df.rsd <- filter(df.melt, variable == "df.rsd", value != 0)
df.outOf <- filter(df.melt, variable == "df.count", value !=0)
df.outOf$value <- as.factor(df.outOf$value)


#Create boxplots of rsd
bp <- ggplot(df.rsd, aes(x=index, y=value, group = index, fill = index)) + 
  geom_boxplot(size = 1) +
  theme(legend.position = "none", 
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  ylab("rsd")
bp
#Create bar plots of present value
outOf <- ggplot(df.outOf, aes(value, fill = index)) + 
  geom_bar(width = .8,stat = "count", color = "black", size = 1) + 
  facet_grid(. ~ index) + 
  xlab("x out of y") + 
  theme(legend.position = "none")

ggarrange(bp, outOf, ncol = 1, nrow = 2)


