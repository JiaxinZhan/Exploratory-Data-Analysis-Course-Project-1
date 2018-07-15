
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

# Create plot 1
hist(dt$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.copy(png, "C:\\Users\\DELL\\Desktop\\plot 1.png", width = 480, height = 480)
dev.off()
