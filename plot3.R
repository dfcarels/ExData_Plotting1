#READ IN & TRANSFORM DATA
dataplot3 <- read.table("household_power_consumption.txt", 
                        header = TRUE, 
                        sep = ";", 
                        na.strings = "?")

##CREATE SUBSET
dataplot3sub <- subset(dataplot3, dataplot3$Date == "1/2/2007" | dataplot3$Date == "2/2/2007") 

##TRANSFORM DATE & TIME
dataplot3sub$Time <- strptime(paste(as.Date(dataplot3sub$Date, format = "%d/%m/%Y"), dataplot3sub$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S")
dataplot3sub$Date <- as.Date(dataplot3sub$Date, format = "%d/%m/%Y")

#CREATE PNG OF PLOT 3
##OPEN DEVICE AND PREPARE PLOT
png("plot3.png", width=480, height=480, type="quartz")
par(mar=c(4,5,3,2), bg = "transparent")

##CREATE BASE PLOT
with(dataplot3sub, plot(Time, Sub_metering_1, xlab = "", ylab = "", type = "l"))
with(dataplot3sub, lines(Time, Sub_metering_2, xlab = "", ylab = "", col = "red", type = "l")) 
with(dataplot3sub, lines(Time, Sub_metering_3, xlab = "", ylab = "", col = "blue", type = "l"))

##ADD ANNOTATIONS
legend("topright", 
        lty = c(1,1),
        col = c("black", "red", "blue"),
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

title(ylab = "Energy sub metering")

##CLOSE DEVICE
dev.off()
