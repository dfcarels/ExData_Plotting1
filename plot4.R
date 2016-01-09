#READ IN & TRANSFORM DATA
dataplot4 <- read.table("household_power_consumption.txt", 
                        header = TRUE, 
                        sep = ";", 
                        na.strings = "?")

##CREATE SUBSET
dataplot4sub <- subset(dataplot4, dataplot4$Date == "1/2/2007" | dataplot4$Date == "2/2/2007") 

##TRANSFORM DATE & TIME
dataplot4sub$Time <- strptime(paste(as.Date(dataplot4sub$Date, format = "%d/%m/%Y"), dataplot4sub$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S")
dataplot4sub$Date <- as.Date(dataplot4sub$Date, format = "%d/%m/%Y")

#CREATE PNG OF PLOT 4
##OPEN DEVICE AND PREPARE PLOT
png("plot4.png", width=480, height=480, type="quartz")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), bg = "transparent")

##CREATE SUBPLOT 1 (Global Active Power)
par(mar=c(4,5,3,2))
with(dataplot4sub, plot(Time, Global_active_power, 
                        ylab = "Global Active Power", 
                        xlab = "", 
                        type = "l"))

##CREATE SUBPLOT 2 (Voltage)
par(mar=c(4,5,3,2))
with(dataplot4sub, plot(Time, Voltage, 
                        ylab = "Voltage", 
                        xlab = "datetime", 
                        type = "l"))

##CREATE SUBPLOT 3 (Energy Sub Metering)
par(mar=c(4,5,3,2))
with(dataplot4sub, plot(Time, Sub_metering_1, xlab = "", ylab = "", type = "l"))
with(dataplot4sub, lines(Time, Sub_metering_2, xlab = "", ylab = "", col = "red", type = "l")) 
with(dataplot4sub, lines(Time, Sub_metering_3, xlab = "", ylab = "", col = "blue", type = "l"))

legend("topright", 
       lty = c(1,1),
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

title(ylab = "Energy sub metering")

##CREATE SUBPLOT 4 (Global Reactive Power)
par(mar=c(4,5,3,2))
with(dataplot4sub, plot(Time, Global_reactive_power, 
                        ylab = "Global_reactive_power", 
                        xlab = "datetime",
                        type = "l"))

yticks <- seq.int(0, 0.5, 0.1)
axis(2, at = yticks, labels = yticks)

##CLOSE DEVICE
dev.off()