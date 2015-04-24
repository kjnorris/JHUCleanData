# Getting and Cleaning Data Project

### Johns Hopkins University through Coursera

 Due: 26 April 2015

This project assumes that the script (*run_analysis.R*) is in the current directory and the data set is extracted in a *Data* subdirectory. The library *dplyr* is assumed to be installed and will be loaded by the script.

The script executes as follows:

1. Load the feature names from the *features.txt* file and transform to a vector
2. Read the training data readings (*Data/train/X_train.txt*) - fixed width file with 561 entries each 16 characters wide and 7352 lines (*trainX*)
3. Read the training subjects (*Data/train/subject_train.txt*) - single entry per line with 7352 lines (*trainSubject*)
4. Read the training activities (*Data/train/y_train.txt*) - single entry per line with 7352 lines (*trainActivity*)
5. Read the test data readings (*Data/test/X_train.txt*) - fixed width file with 561 entries each 16 characters wide and 2947 lines (*testX*)
6. Read the test subjects (*Data/test/subject_train.txt*) - single entry per line with 2947 lines (*testSubject*)
7. Read the test activities (*Data/test/y_train.txt*) - single entry per line with 2947 lines (*testActivity*)
8. Create new data frames for training and test data containing only the columns with *mean* in their name (*trainMean* and *testMean*)
9. Create new data frames for training and test data containing only the columns with *std* in their name (*trainStd* and *testStd*)
10. Create new data frames for training and test combining by column the  subject, activity, mean, and std data frames (*trainFinal* and *testFinal*)
11. Create new data frame combining training and test data frames by row (*studyResults*)
12. Convert activity variable to a factor with levels found in the activity labels file (*Data/activity_labels.txt*)
13. Convert the subject variable to a factor
14. Create a new data frame showing the mean of each variable for each subject and activity combination (*meanResults*)
15. Save the final data frames to an RData file for future processing (*Data/StudyResults.RData*)
16. Output the grouped mean data frame as a text file for grading submission (*Data/KJNDataProject.txt*)