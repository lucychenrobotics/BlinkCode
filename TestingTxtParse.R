dataFile <<-"/Users/lucychen/Documents/Lab/NIH lab/Data/exportedTestTxt.txt"
numTimeLines <- (grep("Event duration", readLines(dataFile), value = TRUE))
numTime <- strsplit(numTimeLines[1], " ")
print(floor(as.numeric(numTime[[1]][4])))
