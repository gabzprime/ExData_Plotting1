library(tidyr )
library(tidyverse)
ds<-read.delim("household_power_consumption.txt", header=TRUE, sep=";")
base<-as.POSIXct("1/2/2007 00:00:00",format="%d/%m/%Y %H:%M:%S"  )
x <- ds%>% drop_na(Date) %>% mutate(datex=as.Date(Date, "%d/%m/%Y") )  %>% 
  filter( datex == "2007-02-01" | datex == "2007-02-02") %>% 
  mutate(datetime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S") )  %>% 
  mutate(diff_time=as.numeric(difftime(datetime,base,unit="mins")) )  %>% 
  mutate(Sub_metering_1= as.numeric(Sub_metering_1))%>% 
  mutate(Sub_metering_2= as.numeric(Sub_metering_2))%>% 
  mutate(Sub_metering_3= as.numeric(Sub_metering_3))%>% 
  mutate(Global_active_power= as.numeric(Global_active_power))

png("plot4.png", width=480, height=480)

par(mfcol=c(2,2),  cex = 0.5)
#plot1
with(x, plot(diff_time,Global_active_power, type="l", 
             ylab="Global Active Power(kilowatts)",xlab="",xaxt="n"))
axis(1, c(0,1440,2880), c("Thursday","Friday","Saturday") )

#plot2
with(x, plot(diff_time,Sub_metering_1, type="l",
             ylab="Energy Sub metering",xlab="",xaxt="n"))
with(x,lines(diff_time,Sub_metering_2, col="red"))
with(x,lines(diff_time,Sub_metering_3, col="blue"))

legend("topright", pch=NA,  col=c("black","red","blue"), lty=c(1,1,1),
       legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
axis(1, c(0,1440,2880), c("Thursday","Friday","Saturday") )

#plot3
with(x, plot(diff_time,Voltage, type="l", 
             ylab="Voltage",xlab="",xaxt="n"))
axis(1, c(0,1440,2880), c("Thursday","Friday","Saturday") )

#plot4
with(x, plot(diff_time,Global_reactive_power, type="l", 
             ylab="Global_reactive_power",xlab="",xaxt="n"))
axis(1, c(0,1440,2880), c("Thursday","Friday","Saturday") )

dev.off()
