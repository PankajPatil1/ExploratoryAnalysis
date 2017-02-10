
#Load required packages
library(dplyr)
library(plyr)
library(ggplot2)
main <- readRDS("summarySCC_PM25.rds")
sup <- readRDS("Source_Classification_Code.rds")

#Find the codes for coal related combustion activities and merge it with main based on SCC
df <- sup[grepl("Coal",sup$Short.Name,ignore.case = TRUE),]
mg <- merge(main,df,by='SCC')

# Find aggregate values per year
mg.mean <- ddply(mg,.(year),summarize,Mean = mean(Emissions))

#Plot
g <- ggplot(mg.mean,aes(year,Mean))
g + geom_bar(stat="identity",aes(fill=as.factor(year))) + labs(x="Year",y="Mean Emissions (in Tons)",fill="Year") + ggtitle("Mean Emissions due to Coal related combustion")

#Save as png
dev.copy(png,file="Plot4.png")
dev.off()

#Print
print("The PM2.5 Levels have drastically decreased due to coal combustion. Most prominent reduction occours durinig 2005-2008")

