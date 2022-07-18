#Create data directory in working directory if it doesn't exist, download zip file from web 
#and read data sets into R

if (!file.exists("data")) {
  dir.create("data")
}

fileurl <-  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip [d396qusza40orc.cloudfront.net]"
destfile <- "./data/dataset.zip [dataset.zip]"
download.file(fileurl, destfile, method = "curl")

data <- read.table(unz(destfile, "household_power_consumption.txt"), quote="\"", sep = ";", header = TRUE, comment.char="")

#Only use data from the dates 2007-02-01 and 2007-02-02
data$datetime <- paste(data$Date, data$Time)
data$datetime <- strptime(data$datetime, "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- subset(data, Date==as.Date("2007-02-01")|Date==as.Date("2007-02-02"))

#Construct plots and save as png file

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))

dir = getwd()

png(filename = paste(dir,"plot4.png", sep="/"), width = 480, height = 480)
par(mfrow=c(2,2))
plot(data$datetime, data$Global_active_power, type = "l", ylab = "Global Active Power", xlab="")
plot(data$datetime, data$Voltage, type = "l", ylab = "Voltage", xlab="datetime")
plot(data$datetime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="")
lines(data$datetime, data$Sub_metering_2, type = "l", col="red")
lines(data$datetime, data$Sub_metering_3, type = "l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1), bty="n")
plot(data$datetime, data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab="datetime")

dev.off()