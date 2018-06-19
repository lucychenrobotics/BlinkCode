library(XML)
library(plyr)
library(ggplot2)

 #you will need to change the filepath on  your machine
xmlfile=xmlParse("/Users/lucychen/Documents/Lab/NIH lab/Data/exportedTest.xml")

print(class(xmlfile)) #"XMLInternalDocument" "XMLAbstractDocument"
xmltop = xmlRoot(xmlfile) #gives content of root
print(class(xmltop))#"XMLInternalElementNode" "XMLInternalNode" "XMLAbstractNode"
print(xmlName(xmltop)) #give name of node, PubmedArticleSet
print(xmlSize(xmltop)) #how many children in node, 19
print(xmlName(xmltop[[1]])) #name of root's children
print(xmlName(xmltop[[2]])) #name of root's children
print(xmlName(xmltop[[3]])) #name of root's children

#Root Node's children
print(xmlSize(xmltop[[2]])) #number of nodes in each child
print(xmlSApply(xmltop[[2]][[1]][[3]][[1]], xmlName)) #name(s)
print("these are the names")
print(xmltop[[2]][[1]])
print(xmlSApply(xmltop[[2]], xmlAttrs)) #attribute(s)
print(xmlSApply(xmltop[[2]], xmlSize)) #size
#print(head(xmltop[[2]]))

#Turning XML into a dataframe
#Madhu2012 <- xmlToList(xmltop[[2]][[1]][[1]][[1]][[1]]) #completes with errors: "row names were found from a short variable and have been discarded"
#View(Madhu2012) #for easy checking that the data is properly formatted
#Madhu2012.Clean=Madhu2012[Madhu2012[25]=='Y',] #gets rid of duplicated rows
