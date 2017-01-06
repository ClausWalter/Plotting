Plot2 <- function(){
  
  ## Preparations: load necessary libraries, get/set paths, load, unzip and filter data:
  
  library(sqldf)
  library(lubridate)
  
  path<-getwd()
  pathIn <- file.path(path, "UCI HAR Dataset")
  print("Data loading and unzipping")
  url <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  filename<- "Powerconsumption.zip"
  filenameNpath<-file.path(path, filename)
  if (!file.exists(path)) {dir.create(path)}
  if (!file.exists(filenameNpath)){download.file(url, destfile = filenameNpath, mode = "wb")}
  unzip(file.path(path, filename), files = NULL, list = FALSE, overwrite = TRUE, junkpaths = FALSE, exdir = ".", unzip = "internal", setTimes = FALSE)
  dtAnalysis <- read.csv.sql(file.path(path, "household_power_consumption.txt"), sql = "SELECT * from file where (Date = '1/2/2007' OR Date = '2/2/2007')", eol = "\n", header = TRUE, sep=";")
  dtAnalysis$Date <- dmy(dtAnalysis$Date)
  dtAnalysis$Time<-hms(dtAnalysis$Time)
  dtAnalysis$supertime<-ymd_hms(paste(dtAnalysis$Date, dtAnalysis$Time))
  
  ## Now plotting on screen, copying and saving as files (PNG-file will be saved in your working directory):
  
  with(dtAnalysis, plot(supertime, Global_active_power, type = "l", main = "", xlab="", ylab = "Global Active Power (kilowatts)"))
  dev.copy(png, file=file.path(path, "Plot2.png"), width=480, height=480)
  dev.off()
  
}