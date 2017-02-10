#Load required packages
library(dplyr)
library(plyr)
library(ggplot2)
library(reshape2)

#Read the data
main <- readRDS("summarySCC_PM25.rds")
sup <- readRDS("Source_Classification_Code.rds")

#Find the codes for coal related combustion activities and merge it with main based on SCC
main.baltimore <- subset(main, main$fips == "24510")
df <- sup[grepl("onroad",sup$Data.Category,ignore.case = TRUE),]
mg.baltimore <- merge(main.baltimore,df,by='SCC')
# Find aggregate values per year
mg.mean.baltimore <- ddply(mg.baltimore,.(year),summarize,Baltimore = mean(Emissions))

#Plot
g <- ggplot(mg.mean.baltimore,aes(year,Baltimore))
g + geom_bar(stat="identity",aes(fill=as.factor(year))) + labs(x="Year",y="Mean Emissions (in Tons)",fill="Year") + ggtitle("Mean Emissions in Baltimore")
#Save
dev.copy(png,file="Plot5.png")
dev.off()
