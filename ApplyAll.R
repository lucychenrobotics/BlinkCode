setwd("/Users/lucychen/Documents/Lab/NIH lab/BlinkCode")
source("LoadingData2.R")

#Global Variables
dataFile <<- "hello"
#Number of samples per second
hrtz <<- 120

files <- list.files("/Users/lucychen/Documents/Lab/NIH lab/DataTxt", pattern="*.txt", full.names=T,  recursive=FALSE)
print(length(files))
finalDataEyeBlink <<- data.frame(matrix(ncol = length(files), nrow = 1))

print(ncol(finalDataEyeBlink))
print(colnames(finalDataEyeBlink))
print("what")
#Because when there is only one file it doesn't automatically name columns X1, X2, etc
if(length(files) < 1){
  colnames(finalDataEyeBlink) <- c("X1")
}

IDNum <<- 1
lapply(files, function(x) {
  print(c("IDNUM", IDNum))
  print(colnames(finalDataEyeBlink))
  print("colnames 3 but not really")
  #print(as.character(IDNum))
  currCol <- paste("X", as.character(IDNum), sep="")
  #print(currCol)
  
  #finalDataEyeBlink[1, currCol] <<- "hello"
  #finalDataEyeBlink[1,currCol] <- 0
  dataLocation <- loadData(x)
  numBlinksData <- numBlinks(60, currCol)
  #print(colnames(finalDataEyeBlink))
  #print("this is colnames 1")
  colnames(finalDataEyeBlink)[colnames(finalDataEyeBlink)==currCol] <<- x
  IDNum <<- IDNum + 1
  #print(colnames(finalDataEyeBlink))
  #print("colnames2")
  print(IDNum)
})

setwd("/Users/lucychen/Documents/Lab/NIH lab/Output")
write.table(finalDataEyeBlink, "firstOutput2.csv", row.names=F, sep=",")


