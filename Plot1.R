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

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- subset(data, Date==as.Date("2007-02-01")|Date==as.Date("2007-02-02"))

#Construct histogram and save as png file

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

dir = getwd()
png(filename = paste(dir,"plot1.png", sep="/"), width = 480, height = 480)
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red", main = "Global Active Power")

dev.off()