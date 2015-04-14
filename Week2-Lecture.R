# Reading Data from MySQL using DBI
ucscDb <- dbConnect(MySQL(), user = "genome",
                    host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases")
allTables[1:5]
dbDisconnect(ucscDb)

hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19",
                  host = "genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]
dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19, "affyU133Plus2")
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)
affyMisSmall <- fetch(query, n=10)
dbClearResult(query)
dbDisconnect(hg19)

# Reading Data from HDF5
h5File <- paste(getwd(), "Data", "example.h5", sep = "/")
created <- h5createFile(h5File)
created <- h5createGroup(h5File, "foo")
created <- h5createGroup(h5File, "baa")
created <- h5createGroup(h5File, "foo/foobaa")
h5ls(h5File)

A <- matrix(1:10, nr = 5, nc = 2)
h5write(A, h5File, "foo/A")
B <- array(seq(0.1, 2.0, by = 0.1), dim = c(5, 2, 2))
attr(B, "scale") <- "liter"
h5write(B, h5File, "foo/foobaa/B")
h5ls(h5File)

df <- data.frame(1L:5L, seq(0, 1, length.out = 5),
                 c("ab", "cde", "fghi", "a", "s"),
                 stringsAsFactors = FALSE)
h5write(df, h5File, "df")
h5ls(h5File)

h5read(h5File, "foo/A")
h5read(h5File, "foo/foobaa/B")
h5read(h5File, "df")

h5write(c(12, 13, 14), h5File, "foo/A", index = list(1:3, 1))
h5read(h5File, "foo/A")
h5read(h5File, "foo/A", index = list(1:3, 1))

# Reading Data from the Web
con <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode <- readLines(con)
close(con)
htmlCode

library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = TRUE)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

library(httr)
html2 <- GET(url)
content2 <- content(html2, as = "text")
parsedHtml <- htmlParse(content2, asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

pg1 <- GET("http://httpbin.org/basic-auth/user/passwd")
pg1

pg2 <- GET("http://httpbin.org/basic-auth/user/passwd",
           authenticate("user", "passwd"))
pg2
names(pg2)

google <- handle("http://google.com")
pg1 <- GET(handle = google, path = "/")
pg2 <- GET(handle = google, path = "search")

# Reading from APIs

#Function EnsurePackage() loads a given library
#If the library is not installed, EnsurePackage will
#install it and then load it.
EnsurePackage<-function(x)
{
    x <- as.character(x)
    if (!require(x,character.only=TRUE))
    {
        install.packages(pkgs=x,repos="http://cran.r-project.org")
        require(x,character.only=TRUE)
    }
}

#Function PrepareTwitter() loads all necessary packages
#to access twitter from R
library(httr)
myapp <- oauth_app("twitter",
                   key = "hlX4ePAuPfPeo7KEIKGeIH4Pl",
                   secret = "CpbdzOEg867bfCrPMeD2Sz185rB8JrlNxVVuEKBB2R4JvoQyzl")
sig <- sign_oauth1.0(myapp,
                     token = "97057675-9yo77cik2tKMnu4tIVceaObzkHfBf9dl7daW6IKm5",
                     token_secret = "68xiEansC85PQXLsMJBj47sb3dxpag67W2xeZL82wvHwZ")
homeTL <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

json1 <- content(homeTL)
json2 <- jsonlite::fromJSON(toJSON(json1))
json2[1, 1:4]

# Reading from Other Sources
