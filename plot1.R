
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

  
#make histograme with red color label and title
hist(
    data$Global_active_power,
    col="red",
    xlab="Global Active Powers (kilowatts)",
    main="Global Active Power"
    )

#copy to the file
dev.copy(png,"plot1.png",width=480, height= 480)

#cose PNG device
dev.off()
