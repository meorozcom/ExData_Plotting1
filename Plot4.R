#set working directory
setwd("C:/Users/maggy/Downloads/Coursera/Data science/Exploratoy Data Analysis")

#save Url
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#download and read the file
download.file(fileUrl, destfile="DataPlot1.zip")
unzip("DataPlot1.zip")
data <- read.table("household_power_consumption.txt", header=TRUE, na.strings = "?", sep=";")

#date format using as.Date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#getting the data from 2/2/2007 and 1/2/2007
data2 <- subset(data, Date==as.Date("2007-02-02") | Date==as.Date("2007-02-01"))

#remove the data variable
rm(data)

#data and time together
data2$DateTime <- paste(data2$Date,data2$Time, sep=" ")
data2$DateTime <- strptime(data2$DateTime, format="%Y-%m-%d%H:%M:%S")

#create the png file
png("Plot4.png")

#2*2 
par(mfrow=c(2,2))
#plot1
with(data2, plot(DateTime,Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="l"))
#plot2
with(data2, plot(DateTime,Voltage,xlab="datetime",ylab="Voltage",type="l"))
#plot3
with(data2, plot(DateTime,Sub_metering_1,xlab="",ylab="Energy sub metering",type="l"))
lines(data2$DateTime,data2$Sub_metering_2,col="red")
lines(data2$DateTime,data2$Sub_metering_3,col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#plot4
with(data2, plot(DateTime,Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l"))

#close device
dev.off()