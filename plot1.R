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
# Exporting Plot
png("plot1.png", width = 480, height = 480)
hist(combdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()
