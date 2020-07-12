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
png("Plot2.png")

#plot
with(data2, plot(DateTime,Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="l"))

#close dev
dev.off()
