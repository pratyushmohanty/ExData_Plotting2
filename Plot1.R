## 1. Have total emissions from PM2.5 decreased 
## in the United States from 1999 to 2008? 
## 
## Using the base plotting system, make a plot 
## showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)

## read the data
NEI <- readRDS("summarySCC_PM25.rds")

## check for NAs
sum(is.na(NEI$Emissions))
sum(is.na(NEI$year))

## group the data by year to calculate total
data <- as.data.frame(
        NEI %>% 
        group_by(year) %>%
        summarise(total = sum(Emissions))
)

## Plot 
par(mar = c(5,5,2,1))
with(data, {
        plot(year,total,
             type = "n"
             )
        barplot(total, year, 
                names.arg = seq(1999,2008, 3),
                main = "Total PM2.5 Emissions Per Year",
                xlab = "year",
                ylab = "Total Emissions (tons)"
                )
        dev.copy(png, file = "Plot1.png", width = 480, height = 480)
        dev.off()
})


