#READ IN & TRANSFORM DATA
dataplot2 <- read.table("household_power_consumption.txt", 
                        header = TRUE, 
                        sep = ";", 
                        na.strings = "?")

##CREATE SUBSET
dataplot2sub <- subset(dataplot2, dataplot2$Date == "1/2/2007" | dataplot2$Date == "2/2/2007") 

##TRANSFORM DATE & TIME
dataplot2sub$Time <- strptime(paste(as.Date(dataplot2sub$Date, format = "%d/%m/%Y"), dataplot2sub$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S")
dataplot2sub$Date <- as.Date(dataplot2sub$Date, format = "%d/%m/%Y")

#CREATE PLOT 2
##OPEN DEVICE AND PREPARE PLOT
png("plot2.png", width=480, height=480, type="quartz")
par(mar=c(4,5,3,2), bg = "transparent")

##PREPARE BASE PLOT
with(dataplot2sub, plot(Time, Global_active_power, 
                        ylab = "Global Active Power (kilowatts)", 
                        xlab = "", 
                        type = "l"))

##CLOSE DEVICE
dev.off()