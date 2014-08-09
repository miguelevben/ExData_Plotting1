###############################################################################################
## Source..: plot4.R  
## Action    : Script for collect and draw four graphics
##            - download and unzip file
##            - Read data between dates.
##            - finally draw graphics like exercise 4 and save as plot4.png.
## 
##
################################################################################################
##  
# declare variables
directory = "exploratory data analysis proj 1"
file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
workdir <- sprintf('./%s',directory)                             # Work dir for this project 
DF_data <- data.frame()

targ_file <- paste(workdir,"household_power_consumption.zip",sep="/") # destfile for download
txt_file  <- paste(workdir,"household_power_consumption.txt",sep="/") # txt file for read
txt_tmp   <- paste(workdir,"power_consump.txt",sep="/")
png_file  <- paste(workdir,"plot4.png",sep="/")
# download and unzip zip file from file.

if (!file.exists(workdir)){
  dir.create(workdir)
  download.file(file,destfile=targ_file,method="auto")
  unzip(targ_file, exdir=workdir)
}  


# Read household_power_consumption.txt between dates
library("sqldf")
DF_data <- read.csv.sql(txt_file,sep=";",header=TRUE, sql = 'select * from file where Date = "1/2/2007" or Date ="2/2/2007"')

## Set to "North-American" usage, TRANSLATE days from other languages to inglish

Sys.setlocale(locale = "C")
# dates and times 
DF_data$Date <- as.Date(DF_data$Date , "%d/%m/%Y")
DF_data$Time <- paste(DF_data$Date, DF_data$Time, sep=" ")
DF_data$Time <- strptime(DF_data$Time, "%Y-%m-%d %H:%M:%S")

# Draw  
png(filename=png_file, width = 480, height = 480)
par(mfrow=c(2,2))

with(DF_data, { 
  plot(DF_data$Time, Global_active_power, type="l", ylab="Global Active Power", xlab="")
  plot(DF_data$Time, Voltage, type="l", ylab="Voltage", xlab="datetime")
  plot(DF_data$Time, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", ylim=range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)))
  lines(DF_data$Time, Sub_metering_2, col="red", ylim=range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)))
  lines(DF_data$Time, Sub_metering_3, col="blue", ylim=range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)))
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1,  col=c("black","red","blue"), bty="n")
  plot(DF_data$Time, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
})

## create png file
 
dev.off()
## Set R to normally  usage for this system (spanish) 
Sys.setlocale(locale = "")