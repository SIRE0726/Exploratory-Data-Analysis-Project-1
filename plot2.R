library(readr)
library(dplyr)
# importing data
household_power_consumption <- read_delim("Coursera/Getting and CLeaning Data/exdata_data_household_power_consumption/household_power_consumption.txt", ";", escape_double = FALSE, col_types = cols(Global_active_power = col_number(), Global_reactive_power = col_number(), Voltage = col_number(), Global_intensity = col_number(), Sub_metering_1 = col_number(), Sub_metering_2 = col_number(), Sub_metering_3 = col_number()), trim_ws = TRUE)
# Finding all the measurements taken on 1/2/2007
subdata1 <- filter(household_power_consumption, household_power_consumption$Date == "1/2/2007")
# Finding all the measurements taken on 2/2/2007
subdata2 <- filter(household_power_consumption, household_power_consumption$Date == "2/2/2007")
# Combining data of both the dates
combdata <- rbind(subdata1, subdata2)
# Changing date field to dote format from default
combdata$Date <- as.Date(combdata$Date, format = "%d/%m/%Y")
# Creating new field with both date and time 
combdata$datetime <- strptime(paste(combdata$Date,combdata$Time), "%Y-%m-%d %H:%M:%S")
combdata$datetime <- as.POSIXct(combdata$datetime)
# Creating and Exporting Plot
png("plot2.png", width = 480, height = 480)
plot(combdata$Global_active_power ~ combdata$datetime, type = "l", ylab = "Global Active Power (kilowatts)", main = "", xlab ="")
dev.off()
