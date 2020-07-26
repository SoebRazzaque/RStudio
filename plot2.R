## Read data file
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")

## Select data within specified dates
subdata <- subset(data, Date %in% c("1/2/2007","2/2/2007"))
subdata$Date <- as.Date(subdata$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(subdata$Date), subdata$Time)
subdata$datetime <- as.POSIXct(datetime)

## Plot the data
with(subdata, {
  plot(subdata$Global_active_power~datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
#  plot(as.numeric(as.character(subdata$Global_active_power)), type="l",
#       ylab="Global Active Power (kilowatts)", xlab="")
})

## Now plot with the png device
dev.copy(png, file = "plot2.png", height=480, width=480)
dev.off()