#Load required packages
library(dplyr)
library(plyr)
library(reshape2)
library(ggplot2)
library(reshape2)

#Read the data
main <- readRDS("summarySCC_PM25.rds")
sup <- readRDS("Source_Classification_Code.rds")

#Find the codes for motor related combustion activities and merge it with main based on SCC
main.baltimore <- subset(main, main$fips == 24510)
main.la <- subset(main, main$fips == "06037")
df <- sup[grepl("onroad",sup$Data.Category,ignore.case = TRUE),]
mg.baltimore <- merge(main.baltimore,df,by='SCC')
mg.la <- merge(main.la,df,by='SCC')
# Find aggregate values per year
mg.mean.baltimore <- ddply(mg.baltimore,.(year),summarize,Baltimore = mean(Emissions))
mg.mean.la <- ddply(mg.la,.(year),summarize,LA=mean(Emissions))

# Combine the means in a single df and melt it to plot the data
plot <- mg.mean.baltimore
plot[,3] <- mg.mean.la$LA
colnames(plot)[3] <- "LA"
plot$year <- as.factor(as.character(plot$year))
plot <- melt(plot,by="year")
#Plot
g <- ggplot(plot,aes(year,value))
g + geom_point(aes(col=as.factor(variable)),size=3) + geom_line(aes(group=as.factor(variable),linetype=as.factor(variable))) + labs(x="Year",y="Total Emissions in Baltimore (in Tons)",col="District",linetype="District") + ggtitle("Mean Emissions for Baltimore and LA")
#Save
dev.copy(png,file="Plot6.png")
dev.off()
