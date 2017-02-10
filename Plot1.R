require(ggplot2)
#Read the data
main <- readRDS("summarySCC_PM25.rds")
sup <- readRDS("Source_Classification_Code.rds")
#Subset the required rows and find yearwise sum
df <- main[,c(4,6)]
df <- as.data.frame(tapply(df$Emissions,df$year,sum,simplify=FALSE))
df[,2] <- row.names(df)
row.names(df) <- NULL
colnames(df) <- c("Total.Emissions","year")
df$Total.Emissions <- as.numeric(df$Total.Emissions)
#PLot the data
g <- ggplot(df,aes(year,Total.Emissions))
g + geom_bar(stat="identity",aes(fill=as.factor(year))) + labs(x="Year",y="Total Emissions (in Tons)",fill="Year")
#Save the data
dev.copy(png,file="Plot1.png")
print("The Total emissions appear to have steadily dropped from 1999 to 2008")
dev.off()
