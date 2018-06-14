library(XML)
#reading in the file into a data frame
data_location <-xmlParse(file = "/Users/lucychen/Documents/Lab/NIH lab/EyeBlink/Data/exportedTestShorter.xml")
#data_location <-read.csv(file = data_location, skip = skip_num, header = TRUE, sep = sep_char)

class(data_location)
data_location <- xmlRoot(data_location)
data_location <- xmlSApply(data_location, function(x) xmlSApply(x, xmlValue))
data_frame <- data.frame(t(data_location), row.names=NULL)
#data_frame <- data.frame[1:2000]


