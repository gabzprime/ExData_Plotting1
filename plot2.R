library(tidyr )
library(tidyverse)
ds<-read.delim("household_power_consumption.txt", header=TRUE, sep=";")
base<-strptime("1/2/2007 00:00:00","%d/%m/%Y %H:%M:%S"  )
x <- ds%>% drop_na(Date) %>% mutate(datex=as.Date(Date, "%d/%m/%Y") )  %>% 
  filter( datex == "2007-02-01" | datex == "2007-02-02") %>% 
  mutate(datetime=strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S") )  %>% 
  mutate(diff_time=as.numeric(difftime(datetime,base,unit="mins")) )  %>% 
  mutate(Global_active_power= as.numeric(Global_active_power))
png("plot2.png", width=480, height=480)
with(x, plot(diff_time,Global_active_power, type="l", 
             ylab="Global Active Power(kilowatts)",xlab="",xaxt="n"))
axis(1, c(0,1440,2880), c("Thursday","Friday","Saturday") )
dev.off()
