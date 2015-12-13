plot1 <- function() {
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileURL, destfile="../household_power_consumption.zip", method="curl")
      unzip("../household_power_consumption.zip", overwrite=TRUE, exdir="..")
      
      system("head -n1 ../household_power_consumption.txt > housePwr2days.txt")
      system("grep '^1.2.2007|^2.2.2007' ../household_power_consumption.txt >> housePwr2days.txt")
      housePwr2days <- read.table("../housePwr2days.txt",header=TRUE,sep=";",
                                  na.strings="?")
      
      # Combine date and time (from Course Project forum):
      housePwr2days$Date <- paste(housePwr2days$Date, housePwr2days$Time, sep=" ")
      # Convert date-time character string to type Date:
      housePwr2days$Date <- strptime(housePwr2days$Date, "%d/%m/%Y %T")
      
      library(datasets)
      hist(housePwr2days$Global_active_power, col="red", 
           main="Global Active Power", ylim=c(0, 1200), 
           xlab="Global Active Power (kilowatts)", yaxp=c(0,1200,5))
      dev.copy(png, "plot1.png", width=480, height=480)
      dev.off()
      
      #print("tail(housePwr2days):")
      #print(tail(housePwr2days[,1:4]))
      
}