## 6. Compare emissions from motor vehicle sources 
## in Baltimore City (fips=="24510") with emissions from
## motor vehicle sources in Los Angeles County, California 
## (fips=="06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)

## read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Using the method discussed below to identify motor vehicles
## which suggests using the EI.Sector values
## https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2/discussions/threads/U1YX6f-REeWZ8AoH1Zkwbw

## get the sector names from SCC data
names <- levels(SCC$EI.Sector)
motor_vehicle_names <- names[grepl("vehicle", names, ignore.case = T)]

# get the SCC codes for the names identfied above
motor_vehicle_codes <- SCC[SCC$EI.Sector %in% motor_vehicle_names, ]$SCC

## filter the data on above codes and the two cities
data <- NEI[NEI$SCC %in% motor_vehicle_codes & NEI$fips %in% c("24510","06037"), ]
data_BC <- data[data$fips == "24510", ]
data_LA <- data[data$fips == "06037", ]

## compare the summaries
summary(data_BC$Emissions)
summary(data_LA$Emissions)

## BC seems to have considerably less emissions than LA
## Both mean and median are considerably lower

## plot
png(file = "Plot6.png", width = 480, height = 480)
ggplot(data, aes(x= factor(year), y = log10(Emissions), colour = fips)) + 
        geom_boxplot() +
        ylab("Emissions") +
        xlab("Year") +
        ggtitle("Emissions from Motor Vehicle Sources in Baltimore City v Los Angeles")

dev.off()




