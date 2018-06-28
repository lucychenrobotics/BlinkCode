#Notes save the xml files opened in excel as csv files
#Notes write a method that will manually put in numbers in xdat to determine beginning and end
#Blinks count towards the interval they are first in
#Round to the closest second
library(data.table)
numTime <<- 5192
numFrames <<- numTime*hrtz

findTime = function(dataFile){
  #Finding the Time
  dataFile <- readLines(dataFile)
  numTimeLines <- (grep("Duration", dataFile, value = TRUE))
  print(numTimeLines)
  numTime <- strsplit(numTimeLines[1], " ")
  numTime <- floor(as.numeric(numTime[[1]][3]))
  
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
  #dataFile  <- gsub(pattern = "                ", replace = "               0", x = dataFile)
  #dataFile <- unlist(dataFile)
  #dataFile<-paste(dataFile, collapse = '\n')

  return(dataFile)
}


loadData = function(dataFile){
  #dataFileFixed <- findTime(dataFile)
  #print(head(dataFileFixed))
  #dataLocation <<- "/Users/lucychen/Documents/Lab/NIH lab/Data/exportedTestCSV.csv"
  #dataLocation <<- read.csv(file = dataLocation, header = TRUE)
  #newText<<-readLines("/Users/lucychen/Documents/Lab/NIH lab/Data/exportedTestTxt.txt")
  #dataLocation<-read.fwf(file = dataFile, skip = 1, widths = c(30,16,16,16,16,16,16,16,16,16,16,16), n=numFrames)
  dataLocation<<-read.table(file = dataFile, skip = 1, col.names = paste0("V",seq_len(21)), fill = TRUE, header = FALSE)
  #print("hi")
  
  colnames(dataLocation)[colnames(dataLocation)=="V13"] <<- "blink"
  colnames(dataLocation)[colnames(dataLocation)=="V17"] <<- "CR"
  
  
  finalRow <- nrow(dataLocation)-10
  numSeconds <<- floor(finalRow/120)
  numFrames <<- numSeconds*hrtz
  startTime <<- dataLocation[finalRow+8,"V3"]
  print(startTime)
  startTime <<- as.POSIXct(startTime,format='%H:%M:%S',tz = "UTC")
  print(startTime)
  #dataLocation <<- dataLocation[1:numFrames,]

  print("Done loading data")
}


#code to edit the column names
#	time_secs	pupil_diam	scaled_pupil_diam	xdat	blink	interpolated
#dataLocation <<- read.table(file = dataLocation, fill = TRUE)


numBlinks = function(secondsInInterval = 60, minBlinkTime = .1, maxBlinkTime = .4, currColData) {
  print(numSeconds/secondsInInterval)
  print("this is matrix")
  print(head(dataLocation))
  
  minBlinkRows <- floor(hrtz*minBlinkTime)
  print(minBlinkRows)
  print("min")
  maxBlinkRows <- floor(hrtz*maxBlinkTime)
  #numSeconds/secondsInInterval
  numBlinksDataFrame <- matrix(NA, nrow = 20)
  lastBlink <- 0 #Set here just in case the blink goes onto the next interval it doesn't double count
  blinkTimes <- 0
  
  #(nrow(numBlinksDataFrame)-1
  print(colnames(dataLocation))
  randomThing <- 0
  for(i in 0:(nrow(numBlinksDataFrame)-1)){
    numBlinksInThisInterval <- 0
    subsetTest <- dataLocation[(i*secondsInInterval*hrtz+1):((i+1)*secondsInInterval*hrtz),"blink"]
    
    #print(subsetTest)
    #print(head(subsetTest))
    #print("this is head of subset Test")
    #:secondsInInterval*hrtz
    for(j in 1:(secondsInInterval*hrtz)){
      #print(c(i, j))
      if(subsetTest[j] != 0){
        blinkTimes <- 0
        lastBlink <- 0
        #print("this is na?")
      }
      else{
        blinkTimes <- blinkTimes + 1
        #print(blinkTimes)
        #print("this is blinkTimes")
        if(blinkTimes == 1){
          lastBlink <- i
        }
        else if(blinkTimes == minBlinkRows){
          if(lastBlink != i){
            finalDataEyeBlink[lastBlink, currColData] <<- finalDataEyeBlink[lastBlink, currColData]+1
          }
          
          else{
            numBlinksInThisInterval <- numBlinksInThisInterval + 1
            print("this is working")
            print(c(i,j))
            print("here is a blink")
          }
          #print(i)
        }
        else if(blinkTimes == maxBlinkRows && lastBlink == i)
        {
          numBlinksInThisInterval <- numBlinksInThisInterval - 1
          print("hit max")
        }
        #sameBlink <- TRUE
        #flush.console()
      }
    #print(numBlinksInThisInterval)a
    #print("numBLinks")
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
