#Notes save the xml files opened in excel as csv files
#Notes write a method that will manually put in numbers in xdat to determine beginning and end
#Blinks count towards the interval they are first in
#Round to the closest second
library(data.table)


findTime = function(dataFile){
  #Finding the Time
  dataFile <- readLines(dataFile)
  numTimeLines <- (grep("Event duration", dataFile, value = TRUE))
  numTime <- strsplit(numTimeLines[1], " ")
  numTime <- floor(as.numeric(numTime[[1]][4]))
  
  #Settings some other global variables
  #number of frames in entire dataset
  numFrames <<- numTime*hrtz
  print(numFrames)
  print("this is frames")
  
  #duration of entire dataset in seconds
  numSeconds<<-numTime
  print(numSeconds)
  print("Seconds")
  print("Done calculating Time")
  print("this is data file")
  dataFile  <- gsub(pattern = "                ", replace = "               0", x = dataFile)
  dataFile <- unlist(dataFile)
  dataFile<-paste(dataFile, collapse = '\n')

  return(dataFile)
}


loadData = function(dataFile){
  dataFileFixed <- findTime(dataFile)
  #print(head(dataFileFixed))
  #dataLocation <<- "/Users/lucychen/Documents/Lab/NIH lab/Data/exportedTestCSV.csv"
  #dataLocation <<- read.csv(file = dataLocation, header = TRUE)
  #newText<<-readLines("/Users/lucychen/Documents/Lab/NIH lab/Data/exportedTestTxt.txt")
  #dataLocation<-read.fwf(file = dataFile, skip = 1, widths = c(30,16,16,16,16,16,16,16,16,16,16,16), n=numFrames)
  dataLocation<<-read.table(text = dataFileFixed, skip = 1, header = FALSE, col.names = paste0("V",seq_len(14)), fill = TRUE)

  #paste0("V",seq_len(14))
  print("hi")

  colnames(dataLocation)[colnames(dataLocation)=="V13"] <<- "blink"
  colnames(dataLocation)[colnames(dataLocation)=="V14"] <<- "interpolated"

  print("Done loading data")
}


#code to edit the column names
#	time_secs	pupil_diam	scaled_pupil_diam	xdat	blink	interpolated
#dataLocation <<- read.table(file = dataLocation, fill = TRUE)


numBlinks = function(secondsInInterval = 60, currColData) {
  print(numSeconds/secondsInInterval)
  print("this is matrix")
  print(head(dataLocation))
  numBlinksDataFrame <- matrix(NA, nrow = numSeconds/secondsInInterval)
  sameBlink <- FALSE #Set here just in case the blink goes onto the next interval it doesn't double count
  
  #(nrow(numBlinksDataFrame)-1
  print(colnames(dataLocation))
  randomThing <- 0
  for(i in 0:(nrow(numBlinksDataFrame)-1)){
    numBlinksInThisInterval <- 0
    subsetTest <- dataLocation[(i*secondsInInterval*hrtz+1):((i+1)*secondsInInterval*hrtz),"blink"]
    #print(head(subsetTest))
    #print("this is head of subset Test")
    #:secondsInInterval*hrtz
    for(j in 1:(secondsInInterval*hrtz)){
      if(subsetTest[j] == 0 || is.na(subsetTest[j])){
        sameBlink <- FALSE
        #print("this is na?")
      }
      else{
        if(!sameBlink){
          numBlinksInThisInterval <- numBlinksInThisInterval + 1
          #print("this is working")
          #print(j)
          #print(i)
        }
        sameBlink <- TRUE
        #flush.console()
      }
      if(currColData == "X2" && isThis){
        print(colnames(finalDataEyeBlink))
        print("THIS IS DATA")
        isThis<- FALSE
        }
    finalDataEyeBlink[i+1, currColData] <<- numBlinksInThisInterval
    #if(currColData == "X2" && i == 0){print(colnames(finalDataEyeBlink))}
    
    }
    #print("running")
  }
  return(numBlinksDataFrame)
}


#secondsInInterval is number of seconds for each interval you want to calculate
numBlinksRolling = function(secondsInInterval = 60){
  rollingDataFrame <- matrix(NA, nrow = numFrames)
  for(i in nrow(blinkRateDataFrame)){
    subset <- dataLocation$blink[(i*interval_rows+1):((i+1)*interval_rows)]
    sum <- "this is something"  
  }
}


#loadData()
#numBlinksData <- numBlinks(60)
#setwd("/Users/lucychen/Documents/Lab/NIH lab/Output")
#write.table(finalData, "firstOutput.csv", row.names=F, sep=",")
