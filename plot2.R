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
## Combining Date and time
dateTime <- paste(dataRange$Date, dataRange$Time, sep= " ")
Datetime <- strptime(dateTime,"%d/%m/%Y %H:%M:%S")
## Plot 2
plot(Datetime,globalActivePower, type="l",ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
