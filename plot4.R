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


#change the amount of the plots on the page
old.par <- par("mfrow")
par(mfrow = c(2,2))


#drow global active plot

plot(
  data$Global_active_power, type="l",xaxt = "n", xlab="", ylab="Global Active Powers"
)
#add X axis names
axis(1, at=xPos, labels=xNames)



#drow the Voltage over datetime
plot(
  data$Voltage, type="l",xaxt = "n", xlab="datetime", ylab="Voltage"
)
#add X axis names
axis(1, at=xPos, labels=xNames)


#drow the Energy sub metering
plot(
  data$Sub_metering_1, type="l",xaxt = "n", xlab="", ylab="Energy sub  metering"
)

#add data for Sub_metering_2 in red 
lines(data$Sub_metering_2, type="l", pch=1, col="red", lty=1)
#add data for Sub_metering_3 in blue
lines(data$Sub_metering_3, type="l", pch=1, col="blue", lty=1)

#add legend cex=0.7 makes the text smaller and make them to fit into the 480x480 png image
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lty=1,
       cex=0.7
)

#add X axis names
axis(1, at=xPos, labels=xNames)


#drow the Global reactive power
with (data,
  plot(
    Global_reactive_power, type="l",xaxt = "n", xlab="datetime"
  )
)
#add X axis names
axis(1, at=xPos, labels=xNames)



#copy to the file
dev.copy(png,"plot4.png",width=480, height= 480)

#cose PNG device
dev.off()
#return the parameter back fr dispaly
par(mfrow = old.par)
