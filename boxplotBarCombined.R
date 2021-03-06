library(plyr)
library(dplyr)
library(reshape2)
library(readr)
library(data.table)
library(ggplot2)
library(ggpubr)

#List all files in specific directory
rsdAndPresent <- function(directoryOfFiles){
  
setwd(directoryOfFiles)
files <- list.files(directoryOfFiles)

#Read in all files in set directory
data <- lapply(files, FUN=read.table, header=TRUE)

#Set names in list to base file names
names(data) <- basename(files)

#Combine list into dataframe with index being identifier of which data belongs to which file
df <- rbindlist(data, idcol = "index")

#Melt data into ggplot friendly dataframe and subset out data of interest
  
##### CHECK IF USING RSD or RSD_ALL AS VARIABLE!!!! 
df.melt <- melt(data = df, id.vars = c("mz","index") )
df.rsd <- filter(df.melt, variable == "rsd", value != 0)
df.outOf <- filter(df.melt, variable == "present", value != 1.5)
df.outOf$value <- as.factor(df.outOf$value)

#Create boxplots of rsd
#Change coord cartesian values to get correct y axis limits
bp <- ggplot(df.rsd, aes(x=index, y=value, group = index, fill = index)) + 
  geom_boxplot(size = 1) +
  coord_cartesian(ylim=c(0,100))+
  theme(legend.position = "none", 
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  ylab("rsd")
#Create bar plots of present value
outOf <- ggplot(df.outOf, aes(value, fill = index)) + 
  geom_bar(width = .8,stat = "count", color = "black", size = 1) + 
  facet_grid(. ~ index) + 
  xlab("x out of y") + 
  theme(legend.position = "none")

ggarrange(bp, outOf, ncol = 1, nrow = 2)

}

rsdAndPresent("/Users/elliottpalmer/Downloads/judith")
