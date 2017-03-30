library(data.table)
library(dplyr)
library(lubridate)

DT <- fread("household_power_consumption.txt") 


DT <- DT %>%  
        mutate(Date = dmy(Date)) %>%
        filter(Date == "2007-02-01" |  Date == "2007-02-02") %>%
        mutate(DateTime = as.POSIXct(paste(Date, Time))) %>%
        mutate(Global_active_power = as.numeric(Global_active_power)) %>%
        mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
        mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
        mutate(Sub_metering_3 = as.numeric(Sub_metering_3))%>%
        mutate(Voltage = as.numeric(Voltage)) %>%
        mutate(Global_reactive_power = as.numeric(Global_reactive_power)) %>%
        na.omit() %>%
        data.table()

png("plot4.png", width=400, height=400)

par(mfrow=c(2,2))


# p1

plot(DT$DateTime, DT$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")
# p2

plot(DT$DateTime, DT$Voltage, type="l",
     xlab="dateDateTime", ylab="Voltage")
# p3

plot(DT$DateTime, DT$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
lines(DT$DateTime, DT$Sub_metering_2, col="red")
lines(DT$DateTime, DT$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1,
       box.lwd=0)
# p4
 
plot(DT$DateTime, DT$Global_reactive_power, type="n",
     xlab="dateDateTime", ylab="Global_reactive_power")
lines(DT$DateTime, DT$Global_reactive_power)

dev.off()
