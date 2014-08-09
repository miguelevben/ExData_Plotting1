###############################################################################################
## Source..: plot1.R  
## Action    : Script for collect and plot histogram "Global active power" (exercise: plot 1 )
##            - download and unzip file
##            - Read data between dates.
##            - finally draw a histogram like exercise 1 and save as plot1.png.
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
png_file  <- paste(workdir,"plot1.png",sep="/")
# download and unzip zip file from file.

if (!file.exists(workdir)){
  dir.create(workdir)
  download.file(file,destfile=targ_file,method="auto")
  unzip(targ_file, exdir=workdir)
}  


# Read household_power_consumption.txt between dates
library("sqldf")
df4 <- read.csv.sql(txt_file,sep=";",header=TRUE, sql = 'select * from file where Date = "1/2/2007" or Date ="2/2/2007"')

# Draw histogram
png(filename=png_file, width = 480, height = 480)
hist(df4$Global_active_power, main="Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## create png file
 
dev.off()

