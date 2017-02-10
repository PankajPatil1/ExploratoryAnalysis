library(plyr)
library(ggplot2)
#Read the data
main <- readRDS("summarySCC_PM25.rds")
sup <- readRDS("Source_Classification_Code.rds")
#Subset the required SCC Values
supx <- sup[,1:2]
mg <- merge(main,supx,by = 'SCC')
#Subset the Baltimore's data from main
balt <- mg$fips == 24510
df <- mg[balt,c(4,6,7)]
df1 <- ddply(df,.(Data.Category,year),summarize,Mean=mean(Emissions))
df1 <- df1[-1,]

g <- ggplot(df1,aes(year,Mean))
g + geom_point(aes(col=Data.Category),size=4,alpha=1/2) + geom_line(aes(group=Data.Category,linetype=Data.Category))
dev.copy(png,"Plot3.png")
dev.off()
print("All the data categories showed a decline in PM2.5 levels. Non road and Point category showed spike duing 1999-2008")
