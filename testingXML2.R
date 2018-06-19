library(xml2)

pg <- read_xml("/Users/lucychen/Documents/Lab/NIH lab/Data/exportedTest.xml")
# get all the <record>s
recs <- xml_find_all(pg, "/Workbook/Worksheet/Table[1]")

# extract and clean all the columns
vals <- trimws(xml_text(recs))

# extract and clean (if needed) the area names
labs <- trimws(xml_attr(recs, "label"))

# mine the column names from the two variable descriptions
# this XPath construct lets us grab either the <categ…> or <real…> tags
# and then grabs the 'name' attribute of them
cols <- xml_attr(xml_find_all(pg, "//data/variables/*[self::categoricalvariable or
                              self::realvariable]"), "name")

# this converts each set of <record> columns to a data frame
# after first converting each row to numeric and assigning
# names to each column (making it easier to do the matrix to data frame conv)
dat <- do.call(rbind, lapply(strsplit(vals, "\ +"),
                             function(x) {
                               data.frame(rbind(setNames(as.numeric(x),cols)))
                             }))

# then assign the area name column to the data frame
#dat$area_name <- labs

print(head(dat))