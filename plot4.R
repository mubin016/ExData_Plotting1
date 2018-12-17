
g <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(g) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
g_new <- subset(g,g$Date=="1/2/2007" | g$Date =="2/2/2007")


g_new$Date <- as.Date(g_new$Date, format="%d/%m/%Y")
g_new$Time <- strptime(g_new$Time, format="%H:%M:%S")
g_new[1:1440,"Time"] <- format(g_new[1:1440,"Time"],"2007-02-01 %H:%M:%S")
g_new[1441:2880,"Time"] <- format(g_new[1441:2880,"Time"],"2007-02-02 %H:%M:%S")



par(mfrow=c(2,2))


with(g_new,{
  plot(g_new$Time,as.numeric(as.character(g_new$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(g_new$Time,as.numeric(as.character(g_new$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(g_new$Time,g_new$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(g_new,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(g_new,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(g_new,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(g_new$Time,as.numeric(as.character(g_new$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})