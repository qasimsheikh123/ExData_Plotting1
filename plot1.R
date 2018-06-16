if(!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "file")
  unzip("file")
}
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")
power$Date = as.Date(power$Date, format = "%d/%m/%Y")
power_cons <- power[power$Date == "2007-02-01" | power$Date == "2007-02-02", ]
power_cons$Global_active_power = as.numeric(as.character((power_cons$Global_active_power)))
png("plot1.png", width = 480, height = 480)
hist(power_cons$Global_active_power, xlab = "Global Active Power (kilowatts)", 
main = "Global Active Power", col = "red")
dev.off()

