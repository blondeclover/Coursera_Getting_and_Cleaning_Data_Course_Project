##### Coursera: Getting & Cleaning Data Course Project #####

##### Download and unzip files, if necessary #####
# 1. check if file exists in current directory
# 2. if file does not exist, download the data
filename <- "galaxy.zip"
if(!file.exists(filename)) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL,
                  destfile = filename, 
                  method = "curl")
}
# 3. if file is not unzipped, unzip the data
if(!file.exists("UCI HAR Dataset")) {
    unzip(filename)
}
rm(filename)

##### find columns that have mean or std measurements #####
features <- read.table("UCI Har Dataset/features.txt", stringsAsFactors = FALSE)
featuresPositions <- features[grep("mean\\(|std", features$V2), ]

##### read in train and test data #####
# 1. only read train/test set columns that contain mean or std measurements
# 2. cbind labels and subject info
# 3. add column specifying which data set (i.e. train/test)

## test data ##
library(data.table)
testSet <- fread("UCI Har Dataset/test/X_test.txt", stringsAsFactors = FALSE, 
                 select = featuresPositions[, 1], col.names = featuresPositions[, 2])
testLabels <- read.table("UCI Har Dataset/test/y_test.txt", 
                         stringsAsFactors = FALSE, col.names = "Label")
testSubject <- read.table("UCI Har Dataset/test/subject_test.txt", 
                          stringsAsFactors = FALSE, col.names = "Subject")
test <- cbind(testSubject, testLabels, testSet)
test <- cbind(Set = "Test", test)
rm(testSubject, testLabels, testSet)

## training data ##
trainSet <- fread("UCI Har Dataset/train/X_train.txt", stringsAsFactors = FALSE, 
                  select = featuresPositions[, 1], col.names = featuresPositions[, 2])
trainLabels <- read.table("UCI Har Dataset/train/y_train.txt", 
                          stringsAsFactors = FALSE, col.names = "Label")
trainSubject <- read.table("UCI Har Dataset/train/subject_train.txt", 
                           stringsAsFactors = FALSE, col.names = "Subject")
train <- cbind(trainSubject, trainLabels, trainSet)
train <- cbind(Set = "Train", train)
rm(trainSubject, trainLabels, trainSet, features, featuresPositions)

##### bind train and test data #####
trainTest <- rbind(train, test)
rm(train, test)

##### add activity labels #####
labels <- read.table("UCI Har Dataset/activity_labels.txt", 
                     stringsAsFactors = FALSE, col.names = c("Label", "Activity"))
trainTest <- merge(labels, trainTest, by = "Label")
rm(labels)

##### get average of each variable for each activity and subject #####
# 1. gather dataframe from wide to long form
# 2. create groups based on activities, subject, and variable tested
# 3. calculate mean of each group
library(dplyr)
avgData <- trainTest %>%
    gather(Variable, Value, -Label, -Activity, -Set, -Subject) %>%
    group_by(Activity, Subject, Variable) %>%
    dplyr::summarise(mean = mean(Value))

##### write out avgData #####
write.table(avgData, file = "variable_averages.txt", row.names = FALSE)

