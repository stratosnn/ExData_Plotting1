
load_data <- function(path = "household_power_consumption.txt") {
  cat("Loading data, please wait ...\n")
  stime <- Sys.time()
  # This is not most efficient way but good to start with
  raw_data <- read.csv(path, sep = ";", na.strings = "?", nrows = 2100000, 
                       colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
  
  cat("Pre-processing ...\n")
  data <- subset(raw_data, as.Date(Date, format = "%d/%m/%Y") %in% c(as.Date("2007-02-01", format = "%Y-%m-%d"), 
                                                                     as.Date("2007-02-02", format = "%Y-%m-%d")))
  rm(raw_data)
  
  data$datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S", tz = "GMT")
  data$weekday <- weekdays(data$datetime, abbreviate = T)
  cat("Done in", Sys.time() - stime, "seconds\n", sep = " ")
  
  return(data)
}

data <-load_data()

#plot3
png(file = "plot3.png", bg = "white")

par(mfrow = c(1,1), col = "black", cex = 0.9)
plot(data$datetime, data$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(data$datetime, data$Sub_metering_1, type = "l", col = "black")
lines(data$datetime, data$Sub_metering_2, type = "l", col = "red")
lines(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=c(1,1,1))

dev.off()
