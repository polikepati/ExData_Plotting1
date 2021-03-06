subset_data<-function(fulldata, start_date, end_date){
  fulldata$Date <- as.Date(fulldata$Date, format="%d/%m/%Y")
  
  twodaydata = subset(fulldata, as.Date(Date) >= start_date & # between start and end dates
                    as.Date(Date) <= end_date)
  
  twodaydata  
}



plot4<-function(file_name){

  data <- read.table("household_power_consumption.txt",sep=';',header=TRUE,na='?',colClasses=c("character","character","numeric"));
  twodaydata = subset_data(data,"2007-02-01","2007-02-02") #get data for 2 days only
  
  twodaydata$Date_Time <- paste(twodaydata$Date, twodaydata$Time) #concatenate date and time
  
  twodaydata$Date_Time <- strptime(twodaydata$Date_Time, "%Y-%m-%d %H:%M:%S")
  
  
  png(filename = file_name,width = 480,height = 480,units = "px",bg = 'white')
  par(mfcol=c(2,2)) #Column-wise multiplot
  
  # First Plot Global active power
  plot(twodaydata$Date_Time, twodaydata$Global_active_power, type = "l", 
       xlab = "", ylab = "Global Active Power")
 
  # Second Plot Sub metering
  plot(twodaydata$Date_Time, twodaydata$Sub_metering_1, type = "n", 
       xlab = "", ylab = "Energy sub metering")
  lines(twodaydata$Date_Time,twodaydata$Sub_metering_1)
  lines(twodaydata$Date_Time,twodaydata$Sub_metering_2, col='red')
  lines(twodaydata$Date_Time,twodaydata$Sub_metering_3, col='blue')
  
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1),lwd=c(2.5,2.5),col=c("black","red","blue")) # gives the legend lines the correct color and width
  
  # Third Plot Voltage
  plot(twodaydata$Date_Time, twodaydata$Voltage, type = "l", 
       xlab = "datetime", ylab = "Voltage")
  
  # Fourth Plot Global reactive power
  plot(twodaydata$Date_Time, twodaydata$Global_reactive_power, type = "l", 
       xlab = "datetime", ylab = "Global_reactive_power")
  dev.off()
}

