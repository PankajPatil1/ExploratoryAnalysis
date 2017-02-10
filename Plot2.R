#Read the data
main <- readRDS("summarySCC_PM25.rds")
sup <- readRDS("Source_Classification_Code.rds")
#Subset only Baltimore's data
balt <- main$fips == 24510
df <- main[balt,c(2,4,6)]
#Find year wise sum for Baltimore
df <- as.data.frame(tapply(df$Emissions,df$year,sum,simplify=FALSE))
df[,2] <- row.names(df)
row.names(df) <- NULL
colnames(df) <- c("Total.Emissions","year")
df$Total.Emissions <- as.numeric(df$Total.Emissions)
#Plot the data
g <- ggplot(df,aes(year,Total.Emissions))
g + geom_bar(stat="identity",aes(fill=as.factor(year))) + labs(x="Year",y="Total Emissions in Baltimore (in Tons)",fill="Year")
#Save as PNG
dev.copy(png,file="Plot2.png")
dev.off()
print("The total emissions in Baltimore are lower in 2008 as compared to 1999. There was a spike in Total emissions in Baltimore for the year 2002 ")
