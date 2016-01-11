#
# Assumes that the data file to read is downloaded and is available 
# in the working directory
#

library("data.table")

# fread is a much faster and efficient way to read large files
data <- fread("./household_power_consumption.txt", header = TRUE, sep = ";")

# Now to select only rows of interest
fdata <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# Release memory of the large data set
rm(data)

# Convert the character date column to proper date
fdata$Date = as.Date(fdata$Date, "%d/%m/%Y")

# Convert to numeric before making the histogram
fdata$Global_active_power = as.numeric(fdata$Global_active_power)

# Open a png device of 480x480 with point size 10
png(filename = "./Plot1.png", width = 480, height = 480, 
    units = "px", pointsize = 12)

hist(fdata$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Close the device
dev.off()
