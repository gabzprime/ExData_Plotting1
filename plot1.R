library(tidyr )
library(tidyverse)
ds<-read.delim("household_power_consumption.txt", header=TRUE, sep=";")
x <- ds%>% drop_na(Date) %>% mutate(datex=as.Date(Date, "%d/%m/%Y") )  %>% 
filter( datex == "2007-02-01" | datex == "2007-02-02") %>% 
 mutate(Global_active_power= as.numeric(Global_active_power))
png("plot1.png", width=480, height=480)
with(x, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(kilowatts)"))    
dev.off()