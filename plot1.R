subset_data<-function(fulldata, start_date, end_date){
  fulldata$Date <- as.Date(fulldata$Date, format="%d/%m/%Y")
  
  twodaydata = subset(fulldata, as.Date(Date) >= start_date & 
                    as.Date(Date) <= end_date)
  
  twodaydata  
}



plot1<-function(file_name){

  
  data <- read.table("household_power_consumption.txt",sep=';',header=TRUE,na='?',colClasses=c("character","character","numeric"));
  twodaydata = subset_data(data,"2007-02-01","2007-02-02")
  
  
  png(filename = file_name,width = 480,height = 480,units = "px",bg = 'white')
  
  
  hist(twodaydata$Global_active_power, main = "Global Active Power",
       xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
  
  dev.off()
}

