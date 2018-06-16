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

par(mfrow = c(2,2))

plot(power_cons$Datetime, power_cons$Global_active_power,
     xlab = "", type = "l", ylab = "Global Active Power")

power_cons$Voltage = as.numeric(as.character(power_cons$Voltage))
plot(power_cons$Datetime, power_cons$Voltage,
     xlab = "datetime", type = "l", ylab = "Voltage")

plot(power_cons$Datetime, power_cons$Sub_metering_3, type = "l", col = "blue", xlab = " ",
     ylab = "Energy sub metering")
lines(power_cons$Sub_metering_2 ~ power_cons$Datetime, col = "red")
lines(power_cons$Sub_metering_1 ~ power_cons$Datetime, col = "black")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_2"),
       col = c("black", "red", "blue"), lty = 1, lwd = 2, cex = 0.5)

power_cons$Global_reactive_power = as.numeric(as.character(power_cons$Global_reactive_power))
plot(power_cons$Datetime, power_cons$Global_reactive_power, xlab = "datetime",
     ylab = "Global_reactive_power", type = "l")

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
