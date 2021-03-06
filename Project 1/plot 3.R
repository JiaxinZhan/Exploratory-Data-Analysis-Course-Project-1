
dt <- read.table("C:\\Users\\DELL\\Desktop\\household_power_consumption.txt", header = T, sep = ";", na.strings = "?", 
                 colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'))

# Convert the Date and Time variables to Date/Time classes 
dt$Date <- as.Date(dt$Date, "%d/%m/%Y")

# Subset data from the dates 2007-02-01 and 2007-02-02
dt <- subset(dt, Date <= as.Date("2007-02-02") & Date >= as.Date("2007-02-01"))

# Remove Null observations
dt <- dt[complete.cases(dt),]

# Other data pre-processing procedures
Date_Time <- paste(dt$Date, dt$Time)
Date_Time <- setNames(Date_Time, "Date and Time")
dt <- dt[, !(names(dt) %in% c("Date", "Time"))]
dt <- cbind(Date_Time, dt)
dt$Date_Time <- as.POSIXct(Date_Time)

# Create plot 3
with(dt, {plot(Sub_metering_1~Date_Time, type = "l",
               ylab = "Global Active Power (kilowatts)", xlab = "")
          lines(Sub_metering_2~Date_Time, col = 'Red')
          lines(Sub_metering_3~Date_Time, col = 'Blue')      
                })
legend("topright", col = c("black", "red", "blue"), lwd = c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, "C:\\Users\\DELL\\Desktop\\plot 3.png", width = 480, height = 480)
dev.off()
