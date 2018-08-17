## 3. Of the four types of sources indicated 
## by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions
## from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

## read the data
NEI <- readRDS("summarySCC_PM25.rds")

## filter and group the data by year to calculate total
data <- as.data.frame(
        NEI[NEI$fips == "24510", ] %>% 
                group_by(type, year) %>%
                summarise(total = sum(Emissions))
)

## plot
png(file = "Plot3.png", width = 480, height = 480)
ggplot(data, 
       aes(x=year, y=total, colour = type) ) + 
        geom_line(size=1) +
        ggtitle("Total Emissions in Balitomore City per Year per Type") +
        xlab("Year") + ylab("Total Emissions (tons)") + 
        scale_x_continuous(breaks = seq(1999,2008,3))
dev.off()



