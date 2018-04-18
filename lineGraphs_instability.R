library(reshape2)
library(ggplot2)

instability <- read.csv("U:\\instability.csv")
colnames(instability)[1] <- "BIOFLUID"

melt.df <- melt(instability)
melt.df.hilic <- subset(melt.df, CHEMISTRY == "HILIC") 
melt.df.lipids <- subset(melt.df, CHEMISTRY == "LIPIDS") 

ggplot(melt.df.hilic, aes(x=variable, y=value, group = TEMPERATURE, colour = TEMPERATURE)) + 
  geom_line(size = 1.5) + 
  facet_grid(POLARITY ~ BIOFLUID) + 
  ylim(c(0,100)) + 
  ylab("RSD") +
  xlab("Time Point")+
  labs(title="POLAR")

ggplot(melt.df.lipids, aes(x=variable, y=value, group = TEMPERATURE, colour = TEMPERATURE)) + 
  geom_line(size = 1.5) + 
  facet_grid(POLARITY ~ BIOFLUID) +
  ylim(c(0,100)) + 
  ylab("RSD") +
  xlab("Time Point") + 
  labs(title="LIPIDS")

melt.df.four <- subset(melt.df, TEMPERATURE == "FOUR")

ggplot(melt.df.four, aes(x=variable, y=value, group = CHEMISTRY, colour = CHEMISTRY)) + 
  geom_line(size = 1.5) + 
  facet_grid(POLARITY ~ BIOFLUID) +
  ylab("RSD") +
  xlab("Time Point") + 
  labs(title="FOUR DEGREES")

