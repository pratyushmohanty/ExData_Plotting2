## 5. How have emissions from motor vehicle sources 
## changed from 1999-2008 in Baltimore City?

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

## filter the data on above codes and Baltimore city (fips == "24510")
data <- NEI[NEI$SCC %in% motor_vehicle_codes & NEI$fips == "24510", ]

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
## The max value at 2008 is almost 1/5th of 1999
## The median decreases until 2005 but increases in 2008

## plot
png(file = "Plot5.png", width = 480, height = 480)
ggplot(data, aes(x= factor(year), y = log10(Emissions) )) + 
        geom_boxplot() +
        ylab("Log10 Emissions") +
        xlab("Year") +
        ggtitle("Emissions from Motor Vehicle Sources in Baltimore City")

dev.off()
