pollution <- read.csv("E:/Work/Data Science/R/4 Exploratory Data Analysis/avgpm dataset/avgpm25.csv", colClasses = c("numeric", "character", "factor", "numeric", "numeric"))

head(pollution)

## Five-number summary

summary(pollution$pm25)

## Boxplots

boxplot(pollution$pm25, col = "blue")

## Histograms

hist(pollution$pm25, col = "green")

hist(pollution$pm25, col = "green")
rug(pollution$pm25)

hist(pollution$pm25, col = "green", breaks = 100)
rug(pollution$pm25)

## Overlaying features

boxplot(pollution$pm25, col = "blue")
abline(h = 12)

hist(pollution$pm25, col = "green")
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd =4)

## Barplots

barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")