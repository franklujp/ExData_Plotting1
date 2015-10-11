# #####################################This Code is from Stackoverflow
# Function to Install and Load R Packages 
Install_And_Load <- function(Required_Packages)
{
        Remaining_Packages <-
                Required_Packages[!(Required_Packages %in% installed.packages()[,"Package"])];
        if (length(Remaining_Packages))
        {
                install.packages(Remaining_Packages);
        }
        for (package_name in Required_Packages)
        {
                library(package_name,character.only = TRUE,quietly = TRUE);
        }
}
# Specify the list of required packages to be installed and load
Required_Packages = c("R.utils","dplyr","data.table");
# Call the Function
Install_And_Load(Required_Packages);
############################################END Section
## Save the link to the zip data file
dataFileUrl <-
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
myFileName <- "./exdatadatahousehold_power_consumption.zip"
#Check if the file was previously downloaded if not download. Unzip and Save in DataFile
if (!file.exists(myFileName)) {
        download.file(dataFileUrl, destfile = myFileName,method = "wininet")
        DataFile <- unzip(myFileName,exdir = ".")
}
#Reading the Zip file for Data Processing
dataAll <- read.table(DataFile, header=T, sep=";", stringsAsFactors = F,dec = ".", na.strings = "?")
# Subsetting the Data for the range of date
dataRange <- dataAll[dataAll$Date %in% c("1/2/2007","2/2/2007") ,]
rm(dataAll)
# Make sure the data is numeric
globalActivePower <- as.numeric(dataRange$Global_active_power)
globalReactivePower <- as.numeric(dataRange$Global_reactive_power)
Voltage <- as.numeric(dataRange$Voltage)
Sub_metering_1 <- as.numeric(dataRange$Sub_metering_1)
Sub_metering_2 <- as.numeric(dataRange$Sub_metering_2)
Sub_metering_3 <- as.numeric(dataRange$Sub_metering_3)
## Combining Date and time
dateTime <- paste(dataRange$Date, dataRange$Time, sep= " ")
Date <- strptime(dateTime,"%d/%m/%Y %H:%M:%S")

#Ploting graph 4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1),oma=c(0,0,2,0))
plot(Date,globalActivePower, type="l", ylab="Global Active Power (kilowatts)", xlab="")
plot(Date,Voltage, type="l", ylab="Voltage (volt)", xlab="")
plot(Date,Sub_metering_1, type="l", ylab="Global Active Power (kilowatts)", xlab="")
lines(Date,Sub_metering_2,col='Red')
lines(Date,Sub_metering_3,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(Date,globalReactivePower, type="l", 
            ylab="Global Rective Power (kilowatts)",xlab="")

#dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

