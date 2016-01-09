#READ IN & TRANSFORM DATA
dataplot1 <- read.table("household_power_consumption.txt", 
                        header = TRUE, 
                        sep = ";", 
                        na.strings = "?")

##CREATE SUBSET
dataplot1sub <- subset(dataplot1, dataplot1$Date == "1/2/2007" | dataplot1$Date == "2/2/2007") 

##TRANSFORM DATE & TIME
dataplot1sub$Time <- strptime(paste(as.Date(dataplot1sub$Date, format = "%d/%m/%Y"), dataplot1sub$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S")
dataplot1sub$Date <- as.Date(dataplot1sub$Date, format = "%d/%m/%Y")

#CREATE PNG PLOT 1
##OPEN DEVICE AND PREPARE PLOT
png("plot1.png", width=480, height=480, type="quartz")
par(mar=c(5,5,3,2), bg = "transparent")

##PREPARE BASE PLOT
xticks <- seq.int(0, 6, 2)
yticks <- seq.int(0, 1200, 200)

hist(dataplot1sub$Global_active_power, 
     col = "red", 
     axes = FALSE,
     breaks = 20,
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

##ADD ANNOTATIONS
axis(2, at = yticks, labels = yticks)
axis(1, at = xticks, labels = xticks)

##CLOSE DEVICE
dev.off()