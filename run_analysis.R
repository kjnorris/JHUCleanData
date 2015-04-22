# Load useful libraries
library(dplyr)

# Load the feature names and assign them to a vector
myDir <- paste(getwd(), "Data", sep = "/")
featureList <- read.csv(paste(myDir, "features.txt", sep = "/"),
                         header = FALSE, sep = " ",
                        col.names = c("ID", "Feature"),
                        stringsAsFactors = FALSE)
featureNames <- unlist(featureList$Feature)

# Read the training data
textWidth <- rep(16, times = 561)
trainDir <- paste(myDir, "train", sep ="/")
trainX <- read.fwf(paste(trainDir, "X_train.txt", sep = "/"),
                   widths = textWidth, header = FALSE,
                   sep = "\t", stringsAsFactors = FALSE,
                   col.names = featureNames)
trainSubject <- read.csv(paste(trainDir, "subject_train.txt", sep = "/"),
                         header = FALSE, sep = " ",
                         stringsAsFactors = FALSE,
                         col.names = c("Subject"))
trainActivity <- read.csv(paste(trainDir, "y_train.txt", sep = "/"),
                          header = FALSE, sep = " ",
                          stringsAsFactors = FALSE,
                          col.names = c("Activity"))

# Read the test data
testDir <- paste(myDir, "test", sep ="/")
testX <- read.fwf(paste(testDir, "X_test.txt", sep = "/"),
                  widths = textWidth, header = FALSE,
                  sep = "\t", stringsAsFactors = FALSE,
                  col.names = featureNames)
testSubject <- read.csv(paste(testDir, "subject_test.txt", sep = "/"),
                        header = FALSE, sep = " ",
                        stringsAsFactors = FALSE,
                        col.names = c("Subject"))
testActivity <- read.csv(paste(testDir, "y_test.txt", sep = "/"),
                         header = FALSE, sep = " ",
                         stringsAsFactors = FALSE,
                         col.names = c("Activity"))

# Get columns with mean in the name
trainMean <- select(trainX, contains("mean", ignore.case = TRUE)) %>%
    select(-contains("Freq")) %>% select(-contains("angle"))
testMean <- select(testX, contains("mean", ignore.case = TRUE)) %>%
    select(-contains("Freq")) %>% select(-contains("angle"))

# Get columns with std in the name
trainStd <- select(trainX, contains("std"))
testStd <- select(testX, contains("std"))

# Combine all test and train data frames individually
trainFinal <- cbind(trainSubject, trainActivity, trainMean, trainStd)
testFinal <- cbind(testSubject, testActivity, testMean, testStd)

# Combine test and training data sets into a single data frame
studyResults <- rbind(trainFinal, testFinal)

# Convert Activity to a factor with appropriate labels
studyResults$Activity <- factor(studyResults$Activity,
                                labels = c("Walking", "Walking Upstairs",
                                           "Walking Downstairs", "Sitting",
                                           "Standing", "Laying"))

# Convert subject to a factor
studyResults$Subject <- factor(studyResults$Subject, levels = 1:30)

# Create new data frame of means grouped by activity and subject
meanResults <- ddply(studyResults, .(Subject, Activity), numcolwise(mean))

# Save data frame as R Data file for future processing
outFile <- paste(myDir, "StudyResults.RData", sep = "/")
save(list = c("studyResults", "meanResults"),
     file = outFile)

# Output grouped means to .txt file for project grading
outFile <- paste(myDir, "KJNDataProject.txt", sep = "/")
write.table(meanResults, outFile, row.name = FALSE)

