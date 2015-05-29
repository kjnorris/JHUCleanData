# Week 4 Quiz
# Question 1
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
myFile <- paste(getwd(), "Data", "Idaho2006ACSHousing.csv")
download.file(fileURL, myFile, method = "curl")
Idaho2006 <- read.csv(myFile)
splitNames <- strsplit(names(Idaho2006), "wgtp")
splitNames[[123]]


# Question 2
fileURL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
myFile2 <- paste(getwd(), "Data", "GDPData.csv", sep = "/")
download.file(fileURL2, myFile2, method = "curl")
GDPData <- read.csv(myFile2, skip = 4, as.is = TRUE, nrow = 190)

cleanVals <- as.numeric(gsub(",", "", GDPData$X.4))
mean(cleanVals)

# Question 3
grep("^United", GDPData$X.3)

# Question 4
fileURL3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
myFile3 <- paste(getwd(), "Data", "Education.csv", sep = "/")
download.file(fileURL3, myFile3, method = "curl")
Education <- read.csv(myFile3)

length(grep("[Ff]iscal year end: June", Education$Special.Notes))


# Question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
length(grep("^2012", sampleTimes))

length(grep("^Monday", weekdays(sampleTimes[grepl("^2012", sampleTimes)])))


