library(xlsx)
library(XML)
library(data.table)

# Question 1
# Data also used in Question 2 - interpretation, no code required
ACSFile <- paste(getwd(), "Data", "ACS2006Idaho.csv", sep = "/")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              ACSFile, method = "curl")
ACS2006Idaho <- read.csv(ACSFile, header=TRUE)

# Question 3
NGAFile <- paste(getwd(), "Data", "GovNGAP.xlsx", sep = "/")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",
              NGAFile, method = "curl")
dat <- read.xlsx(NGAFile, rowIndex = 18:23, colIndex = 7:15, sheetIndex = 1)
sum(dat$Zip*dat$Ext,na.rm=T)

# Question 4
BalRestFile <- paste(getwd(), "Data", "BalRestFile.xml", sep = "/")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",
              BalRestFile, method = "curl")
doc <- xmlTreeParse(BalRestFile, useInternal = TRUE)
rootNode <- xmlRoot(doc)
xpathSApply(rootNode, "//zipcode", xmlValue)
allZips <- xpathSApply(rootNode, "//zipcode", xmlValue)

# Question 5
ACSFile2 <- paste(getwd(), "Data", "ACS2006Idaho2.csv", sep = "/")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              ACSFile2, method = "curl")
DT <- fread(ACSFile2)
