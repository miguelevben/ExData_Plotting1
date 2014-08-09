###############################################################################################
## Source..: plot3.R  
## Action    : Script for collect and plot type lines "l" "Global active power(kilowatts)" (exercise: plot 3 )
##            - download and unzip file
##            - Read data between dates.
##            - finally draw a plot like exercise 3 and save as plot3.png.
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
png_file  <- paste(workdir,"plot3.png",sep="/")
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

# Draw plot type "l"
png(filename=png_file, width = 480, height = 480)
with(DF_data, plot(DF_data$Time, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", ylim=range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3))))
with(DF_data, lines(DF_data$Time, Sub_metering_2, col="red", ylim=range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3))))
with(DF_data, lines(DF_data$Time, Sub_metering_3, col="blue", ylim=range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3))))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1,  col=c("black","red","blue"))

## create png file
 
dev.off()
## Set R to normally  usage for this system (spanish) 
Sys.setlocale(locale = "")