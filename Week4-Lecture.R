# Week 4 Lectures
# Editing text variables
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
myFile <- paste(getwd(), "Data", "cameras.csv", sep = "/")
download.file(fileURL, myFile, method="curl")
cameraData <- read.csv(myFile)
names(cameraData)
tolower(names(cameraData))
splitNames <- strsplit(names(cameraData), "\\.")
splitNames[[5]]
splitNames[[6]]

myList <- list(letter = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(myList)

firstElement <- function(x) {x[1]}

fileURL1 <- "https://dl.dropboxusercontent.com//u/7710864//data/reviews-apr29.csv"
fileURL2 <- "https://dl.dropboxusercontent.com//u/7710864//data/solutions-apr29.csv"
myFile1 <- paste(getwd(), "Data", "reviews.csv", sep = "/")
myFile2 <- paste(getwd(), "Data", "solutions.csv", sep = "/")
download.file(fileURL1, myFile1, method="curl")
download.file(fileURL2, myFile2, method="curl")
reviews <- read.csv(myFile1)
solutions <- read.csv(myFile2)

sub("_", "", names(reviews),)

testName <- "this_is_a_test"
sub("_", "", testName)
gsub("_", "", testName)

grep("Alameda", cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection), ]

grep("Alameda", cameraData$intersection, value = TRUE)

library(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek", 1, 7)
paste("Jeffrey", "Leek")
paste0("Jeffrey", "Leek")
str_trim("Jeff      ")

# Regular Expressions

# Working with Dates
d1 = date()
d1
class(d1)
d2 = Sys.Date()
d2
class(d2)
format(d2, "%a %b %d")

x <- c("1Jan1960", "2Jan1960", "31mar1960", "30Jul1960")
z <- as.Date(x, "%d%b%Y")
z
z[1] - z[2]
as.numeric(z[1] - z[2])

weekdays(d2)
months(d2)
julian(d2)

library(lubridate)
ymd("20140108")
mdy("08/04/2013")
dmy("03-04-2013")
ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03", tz = "Pacific/Auckland")

x <- dmy(c("1Jan2013", "2Jan2013", "31mar2013", "30Jul2013"))
wday(x[1])
wday(x[1], label = TRUE)

# Data Resources

