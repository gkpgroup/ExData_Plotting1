#
# Assumes that the data file to read is downloaded and is available 
# in the working directory
#

library("data.table")

# fread is a much faster and efficient way to read large files
data <- fread("./household_power_consumption.txt", header = TRUE, 
              sep = ";", data.table = F)

# Now to select only rows of interest
fdata <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# Release memory of the large data set
rm(data)

# Merge the time with date before converting
fdata$Date <- paste(fdata$Date, fdata$Time, sep = " ")

# Convert the character date column to proper date
fdata$Date = strptime(fdata$Date, "%d/%m/%Y %H:%M:%S")

# Convert to numeric before making the histogram
fdata$Global_active_power = as.numeric(fdata$Global_active_power)
fdata$Voltage = as.numeric(fdata$Voltage)
fdata$Sub_metering_1 = as.numeric(fdata$Sub_metering_1)
fdata$Sub_metering_2 = as.numeric(fdata$Sub_metering_2)
fdata$Sub_metering_3 = as.numeric(fdata$Sub_metering_3)
fdata$Global_reactive_power = as.numeric(fdata$Global_reactive_power)

# Open a png device of 480x480 with point size 10
png(filename = "./Plot4.png", width = 480, height = 480, 
    units = "px", pointsize = 12)

# Create a two by two matrix on the open device (row major)
par(mfrow = c(2,2))

# Add the first plot "Global Active Power"
plot(fdata$Date, fdata$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power")

# Add the second plot "Voltage/Datetime"
plot(fdata$Date, fdata$Voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")

# Add the Third plot "Energy sub metering"
plot(fdata$Date, fdata$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")

points(fdata$Date, fdata$Sub_metering_2, col = "red", type = "l", xlab = "",
       ylab = "Energy sub metering")

points(fdata$Date, fdata$Sub_metering_3, col = "blue",type = "l", xlab = "",
       ylab = "Energy sub metering")

legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1), lwd = c(1,1))

# Add the fourth plot "Global_reactive_power"
plot(fdata$Date, fdata$Global_reactive_power, type = "l", xlab = "datetime",
     ylab = "Global_reactive_power")

# Close the device
dev.off()
