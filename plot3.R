plot3 <- function() {
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileURL, destfile="../household_power_consumption.zip", method="curl")
      unzip("../household_power_consumption.zip", overwrite=TRUE, exdir="..")
      
      housePwr <- read.table("../household_power_consumption.txt",header=TRUE,sep=";",
                             na.strings="?") #, rows=readrows,
      day1or2 <- grepl("^1.2.2007|^2.2.2007", housePwr[,"Date"])
      housePwr2days <- housePwr[day1or2,]
      
      #write.table(housePwrDay1or2, "housePwr2days.txt", sep=";")
      #housePwr2days <- read.table("housePwr2days.txt",header=TRUE, sep=";",
      #                             stringsAsFactors=FALSE)
      
      # Combine date and time (from Course Project forum):
      housePwr2days$Date <- paste(housePwr2days$Date, housePwr2days$Time, sep=" ")
      # Convert date-time character string to type Date:
      housePwr2days$Date <- strptime(housePwr2days$Date, "%d/%m/%Y %T")
      
      library(datasets)
      plot(housePwr2days$Date, housePwr2days$Sub_metering_1, xlab="",
           ylab="Energy sub metering", ylim=c(0, 38), type="l")
      lines(housePwr2days$Date, housePwr2days$Sub_metering_2, col="red")
      lines(housePwr2days$Date, housePwr2days$Sub_metering_3, col="blue")
      legend("topright", lty=1, col=c("black","red","blue"),
             legend=names(housePwr2days[,7:9]))
      
      dev.copy(png, "plot3.png", width=480, height=480)
      dev.off()
      
      #print("tail(housePwr2days):")
      #print(tail(housePwr2days[,1:4]))
      
}