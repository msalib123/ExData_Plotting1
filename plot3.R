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
        na.omit() %>%
        data.table()


png(filename = "plot3.png", #save plot
    width = 480, height = 480)

plot(DT$DateTime, DT$Sub_metering_1,
     "n",
     xlab = "",
     ylab = "Energy sub metering")

points(DT$DateTime, DT$Sub_metering_1, type = "line")

points(DT$DateTime, DT$Sub_metering_2, type = "line", col = "red")

points(DT$DateTime, DT$Sub_metering_3, type = "line", col = "blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = c(1, 1, 1))


dev.off()
