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
png("plot4.png", height = 480, width = 480)
par(mfrow = c(2, 2))
plot(combdata$Global_active_power ~ combdata$datetime, type = "l", ylab = "Global Active Power (kilowatts)", main = "", xlab ="")
plot(combdata$Voltage ~ combdata$datetime, type = "l", xlab = "datetime", ylab = "Voltage")
plot(combdata$Sub_metering_1 ~ combdata$datetime, type = "l", ylab = "Enery Sub Metering", xlab= "", main="")
lines(combdata$Sub_metering_2 ~ combdata$datetime, col = "Red")
lines(combdata$Sub_metering_3 ~ combdata$datetime, col = "Blue")
legend("topright", lty = 1,  col = c("black", "red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(combdata$Global_reactive_power ~ combdata$datetime, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
