if(!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "file")
  unzip("file")
}
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")
power$Date = as.Date(power$Date, format = "%d/%m/%Y")
power_cons <- power[power$Date == "2007-02-01" | power$Date == "2007-02-02", ]
power_cons$Global_active_power = as.numeric(as.character((power_cons$Global_active_power)))
datetime = paste(power_cons$Date, power_cons$Time)
power_cons$Datetime <- as.POSIXct(datetime)
png("plot2.png", width = 480, height = 480)
plot(power_cons$Datetime, power_cons$Global_active_power,
     xlab = "", type = "l", ylab = "Global Active Power (kilowatts)")
dev.off()
