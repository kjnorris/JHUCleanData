# Load the feature names and assign them to a vector
myDir <- getwd()
featureList <- read.csv(paste(myDir, "Data", "features.txt", sep = "/"),
                         header = FALSE, sep = " ",
                        col.names = c("ID", "Feature"),
                        stringsAsFactors = FALSE)
featureNames <- unlist(featureList$Feature)
textWidth <- rep(16, times = 561)

# Read the training data
trainDir <- paste(myDir, "Data", "train", sep ="/")
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
testDir <- paste(myDir, "Data", "test", sep ="/")
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

# Save data frame as R Data file for future processing
outFile <- paste(myDir, "Data", "StudyResults.RData", sep = "/")
save(list = c("studyResults"), file = outFile)

# Clean up environment
rm(trainDir)
rm(trainSubject)
rm(trainActivity)
rm(trainX)
rm(trainMean)
rm(trainStd)
rm(trainFinal)
rm(testDir)
rm(testSubject)
rm(testActivity)
rm(testX)
rm(testMean)
rm(testStd)
rm(testFinal)
rm(featureList)
rm(featureNames)
rm(textWidth)
rm(myDir)
rm(outFile)


