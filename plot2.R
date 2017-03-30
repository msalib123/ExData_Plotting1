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


png(filename = "plot2.png", #save plot
    width = 480, height = 480)

plot(DT$DateTime, DT$Global_active_power, 
     type="line", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")


dev.off()
