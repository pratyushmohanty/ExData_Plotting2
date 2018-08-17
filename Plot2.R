## 2. Have total emissions from PM2.5 decreased 
## in the Baltimore City, Maryland (fips=="24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

library(dplyr)

## read the data
NEI <- readRDS("summarySCC_PM25.rds")

## filter and group the data by year to calculate total
data <- as.data.frame(
        NEI[NEI$fips == "24510", ] %>% 
                group_by(year) %>%
                summarise(total = sum(Emissions))
)


## plot
par(mar = c(5,5,3,1))
with(data, {
        plot(year,total,
             type = "n"
        )
        barplot(total, year, 
                names.arg = seq(1999,2008, 3),
                main = "Total PM2.5 Emissions Per Year in Baltimore City",
                xlab = "year",
                ylab = "Total Emissions (tons)"
        )
        dev.copy(png, file = "Plot2.png", width = 480, height = 480)
        dev.off()
})


