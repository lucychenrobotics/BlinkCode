setwd("/Users/lucychen/Documents/Lab/NIHLab/BlinkCode")
hrtz <<- 120

source("LoadingData2.R")

#Global Variables (EDIT THESE FIRST)
#Number of samples per second
#hrtz <<- 120
#Path to where all the files are
files <- list.files("/Users/lucychen/Documents/Lab/NIHLab/DataTxt2", pattern="*.txt", full.names=T,  recursive=FALSE)
finalDataEyeBlink <<- data.frame(matrix(ncol = length(files), nrow = 1))

#Because when there is only one file it doesn't automatically name columns X1, X2, etc
print(length(files))
print("this is length of files")
if(length(files) == 1){
  colnames(finalDataEyeBlink) <- c("X1")
}

IDNum <<- 1
lapply(files, function(x) {
  currCol <- paste("X", as.character(IDNum), sep="")
  dataLocation <- loadData(x)
  
  #Here put in whatever functions you want to be calculated on every file
  #numBlinksData <- numBlinks(60, .1, .4, currCol)
  
  colnames(finalDataEyeBlink)[colnames(finalDataEyeBlink)==currCol] <<- x
  IDNum <<- IDNum + 1
  print(IDNum)
})

#Set directory for where outputs go
setwd("/Users/lucychen/Documents/Lab/NIHLab/Output")
write.table(finalDataEyeBlink, "firstOutput4.csv", row.names=F, sep=",")


