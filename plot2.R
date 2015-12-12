plot2 <- function() {
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileURL, destfile="../household_power_consumption.zip", method="curl")
      unzip("../household_power_consumption.zip", overwrite=TRUE, exdir="..")
      
      housePwr <- read.table("../household_power_consumption.txt",header=TRUE,sep=";",
                             na.strings="?") #, rows=readrows,
      housePwr07 <- housePwr[grepl("2007", housePwr[,"Date"]),]
      day1or2 <- grepl("^1.2.2007|^2.2.2007", housePwr07[,"Date"])
      housePwr2days <- housePwr07[day1or2,]

#      write.table(housePwrDay1or2, "housePwr2days.txt", sep=";")
#      housePwr2days <- read.table("housePwr2days.txt",header=TRUE, sep=";",
#                                  stringsAsFactors=FALSE)
      
      # Combine date and time (from Course Project forum):
      housePwr2days$Date <- paste(housePwr2days$Date, housePwr2days$Time, sep=" ")
      # Convert date-time character string to type Date:
      housePwr2days$Date <- strptime(housePwr2days$Date, "%d/%m/%Y %T")
      
      library(datasets)
      plot(housePwr2days$Date, housePwr2days$Global_active_power, xlab="",
           ylab="Global Active Power (kilowatts)", ylim=c(0, 8), type="l")
      
      dev.copy(png, "plot2.png", width=480, height=480)
      dev.off()
      
      #print("tail(housePwr2days):")
      #print(tail(housePwr2days[,1:4]))

}