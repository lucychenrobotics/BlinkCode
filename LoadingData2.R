#Notes save the xml files opened in excel as csv files
#Notes write a method that will manually put in numbers in xdat to determine beginning and end

dataLocation <<- "/Users/lucychen/Documents/Lab/NIH lab/EyeBlink/Data/exportedTestCSV.csv"
dataLocation <<- read.csv(file = dataLocation, header = TRUE)

#SET THESE GLOBAL VARIABLES
#Number of samples per second
hrtz <<- 120
#number of frames in entire dataset
numFrames <<-nrow(dataLocation)
#duration of entire dataset in seconds
numSeconds<<-floor(numFrames/hrtz)

numBlinks = function(secondsInInterval = 60){
  numBlinksDataFrame <- matrix(NA, nrow = numSeconds/secondsInInterval)
  for(i in 0:(nrow(numBlinksDataFrame)-1)){
    numBlinksInThisInterval <- 0
    subset <- dataLocation$blink[(i*secondsInInterval*hrtz+1):((i+1)*secondsInInterval*hrtz)]
    for(j in 1:secondsInInterval*hrtz)
      if(is.na(subset[j]))
        sameBlink <- FALSE
      else
        if(!sameBlink)
          numBlinksInThisInterval = numBlinksInThisInterval + 1
        sameBlink <- TRUE
    numBlinksDataFrame[i+1] <- numBlinksInThisInterval
    print("running")
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

numBlinksData <- numBlinks(60)
