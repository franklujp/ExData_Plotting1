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
       
}
DataFile <- unzip(myFileName,exdir = ".")
#Reading the Zip file for Data Processing
dataAll <-
        read.table(
                DataFile, header = T, sep = ";", stringsAsFactors = F,dec = ".", na.strings = "?"
        )
# Subsetting the Data for the range of date
dataRange <- dataAll[dataAll$Date %in% c("1/2/2007","2/2/2007") ,]
#rm(dataAll)
# Make sure the data is numeric
Sub_metering_1 <- as.numeric(dataRange$Sub_metering_1)
Sub_metering_2 <- as.numeric(dataRange$Sub_metering_2)
Sub_metering_3 <- as.numeric(dataRange$Sub_metering_3)
## Combining Date and time
dateTime <- paste(dataRange$Date, dataRange$Time, sep = " ")
Date <- strptime(dateTime,"%d/%m/%Y %H:%M:%S")
## Plot 3
png("plot3.png", width=480, height=480)
plot(Date,Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(Date,Sub_metering_2, type="l",col = "Red")
lines(Date,Sub_metering_3, type="l",col = "blue")

legend(
        "topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty =
                1, lwd = 2.5, col = c("black", "red", "blue")
)
dev.off()

