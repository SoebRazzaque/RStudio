## Read data file
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")

## Select data within specified dates
subdata <- subset(data, Date %in% c("1/2/2007","2/2/2007"))
subdata$Date <- as.Date(subdata$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(subdata$Date), subdata$Time)
subdata$datetime <- as.POSIXct(datetime)

## Plot the data
with(subdata, {
  plot(Sub_metering_1~datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~datetime,col='red')
  lines(Sub_metering_3~datetime,col='blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Now plot with the png device
dev.copy(png, file = "plot3.png", height=480, width=480)
dev.off()