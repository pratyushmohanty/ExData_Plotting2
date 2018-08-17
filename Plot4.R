## 4. Across the United States, how have emissions 
## from coal combustion-related sources changed from 1999-2008?

library(ggplot2)

## read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## get the short names from SCC data
names <- levels(SCC$Short.Name)

## Assuming both comb and coal need to be present in Short.Name
## for identifying coal combustion-related sources
coal_combustion_names <- names[grepl("comb", names, ignore.case = T) & 
                                       grepl("coal", names, ignore.case = T)]

## get the SCC codes for the names identfied above
codes_coal_combustion <- SCC[SCC$Short.Name %in% coal_combustion_names, ]$SCC

## filter the data
data <- NEI[NEI$SCC %in% codes_coal_combustion, ]

## subset the data for each year
data_1999 <-data [data$year == 1999, ] 
data_2002 <-data [data$year == 2002, ] 
data_2005 <-data [data$year == 2005, ]
data_2008 <-data [data$year == 2008, ]

## compare the summaries
summary(data_1999$Emissions)
summary(data_2002$Emissions)
summary(data_2005$Emissions)
summary(data_2008$Emissions)

## Overall, there has been a decrease in mean values
## The max value has almost halved by 2008

## plot
png(file = "Plot4.png", width = 480, height = 480)
ggplot(data, aes(x= factor(year), y = log10(Emissions) )) + 
        geom_boxplot() +
        ylab("Log10 Emissions") +
        xlab("Year") +
        ggtitle("Emissions from Coal Combustion Sources in USA")

dev.off()

## however, the median shows an increase from 1999
## compared to 2002, 2005.
## But drops in 2008



