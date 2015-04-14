# Question 1
library(httr)
library(jsonlite)
oauth_endpoints("github")
myapp <- oauth_app("github", "78c2d30c8f106d414baf",
                   secret = "31b831e8b44ceb4e6ca6598d1af24fb90c9f25c9")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)
json1 <- content(req)
json2 <- jsonlite::fromJSON(toJSON(json1))
json2[json2$name %in% list("datasharing"), c(2, 45)]

# Question 2
library(sqldf)
ACSFile <- paste(getwd(), "Data", "ACS2006
                 .csv", sep = "/")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              ACSFile, method = "curl")
acs <- read.csv(ACSFile, header=TRUE)
sqldf("SELECT pwgtp1 FROM acs WHERE AGEP < 50")

# Question 3
sqldf("SELECT DISTINCT AGEP FROM acs")

# Question 4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)
len10 <- nchar(htmlCode[10])
len20 <- nchar(htmlCode[20])
len30 <- nchar(htmlCode[30])
len100 <- nchar(htmlCode[100])
paste(len10, len20, len30, len100, sep = " ")

# Question 5
WKSFile <- paste(getwd(), "Data", "wksst8110.for", sep = "/")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",
              WKSFile, method = "curl")
wksst8110 <- read.fwf(WKSFile, c(15, 4, 9, 4, 9, 4, 9, 4, 9),
                      skip = 4,
                      col.names = c("Week", "Nino1+2SST", "Nino1+2SSA",
                                    "Nino3SST", "Nino3SSA",
                                    "Nino34SST", "Nino34SSA",
                                    "Nino4SST", "Nino4SSA"))
sum(wksst8110[, 4])

