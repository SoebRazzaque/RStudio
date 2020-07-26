## Read data file
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")
## Select data within specified dates
subdata <- subset(data, Date %in% c("1/2/2007","2/2/2007"))
## Plot the histogram
hist(as.numeric(as.character(subdata$Global_active_power)),
     col="red", main="Global Active Power",
     xlab="Global Active Power(kilowatts)")
## Now plot with the png device
dev.copy(png, file = "plot1.png", height=480, width=480)
dev.off()