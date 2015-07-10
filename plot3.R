# Use the function specified below to load the data from the textfile
power<-load.data()
# Add a column of POSIX coded time called "Moment"
power<-cbind(power,Moment=strptime(paste(power$Date,power$Time,sep=" "),format="%d/%m/%Y %H:%M:%S"))
# Set the current graphics device to a PNG file
png(filename = "plot3.png")
# Create the plot in the active device
with(power,plot(Moment,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
with(power,lines(Moment,Sub_metering_2,col="red"))
with(power,lines(Moment,Sub_metering_3,col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),col=c("black","red","blue"))
# Close the device to save the PNG file
dev.off()

# This function loads the data for the two dates needed from the text file.
load.data<-function(filename="household_power_consumption.txt") {
  # This identifies the lines in the text file that refer to 2007/2/1 and 2007/2/2
  lines<-grep("^[12]/2/2007",readLines(filename))
  # Loads only the lines for the correct dates
  data<-read.csv(filename,skip=lines[1]-1,header=F,sep=";",na.strings="?",nrows=length(lines))
  # Reads the first line to be used as the column names and set those names in the data frame.
  names<-read.csv(filename,header=F,sep=";",na.strings="?",nrows=1,stringsAsFactors=F)
  names(data)<-names
  data
}