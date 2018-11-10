##setwd("F:/projects/github/ExData_Plotting1/ExData_Plotting1/")
if(!file.exists("household_power_consumption.txt"))
{
  
  file <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                        ,"household_power_consumption.zip")
  file2 <- unzip("household_power_consumption.zip",c("household_power_consumption.txt"),overwrite = TRUE)
}

#Load the data into the variable
data <- read.csv("household_power_consumption.txt",
                 header=TRUE, 
                 sep=";",
                 na.strings = "?",
                 dec = ".",
                 stringsAsFactors=FALSE)
data$Time <- strptime(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S",tz = "GMT")
data$Date <- as.Date(data$Date,format = c("%d/%m/%Y"))
data <- subset (data,Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## get data ends


##make the vectors of the X names and the X labels positions.
xNames <- c("Thu","Fri","Sat")
xPos <- c(0, nrow(data)/2, nrow(data))

#make plot without X axis names
plot(
  data$Global_active_power, type="l",xaxt = "n", xlab="", ylab="Global Active Powers (kilowatts)"
)
#add X axis names
axis(1, at=xPos, labels=xNames)

#copy to the file
dev.copy(png,"plot2.png",width=480, height= 480)

#cose PNG device
dev.off()


