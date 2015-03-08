subset_data<-function(fulldata, start_date, end_date){
  fulldata$Date <- as.Date(fulldata$Date, format="%d/%m/%Y")
  
  twodaydata = subset(fulldata, as.Date(Date) >= start_date & # between start and end dates
                        as.Date(Date) <= end_date)
  
  twodaydata  
}



plot2<-function(file_name){

  data <- read.table("household_power_consumption.txt",sep=';',header=TRUE,na='?',colClasses=c("character","character","numeric"));
  twodaydata = subset_data(data,"2007-02-01","2007-02-02") #get data for 2 days only
  
  twodaydata$Date_Time <- paste(twodaydata$Date, twodaydata$Time) #concatenate date and time
  
  twodaydata$Date_Time <- strptime(twodaydata$Date_Time, "%Y-%m-%d %H:%M:%S")
  
  
  png(filename = file_name,width = 480,height = 480,units = "px",bg = 'white')
  plot(twodaydata$Date_Time, twodaydata$Global_active_power, type = "l", 
       xlab = "", ylab = "Global Active Power (kilowatts)")
  dev.off()
}

