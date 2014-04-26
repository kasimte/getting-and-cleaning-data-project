# run_analysis.R

# This R script demonstrates reading in a dataset, cleaning it up,
# and outputting it in a tidy format ("tidy.txt" to the working directory).

# It requires that the Samsung data from 
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 
# be unzipped and in the working directory (in a directory named "UCI HAR Dataset",
# as in the compressed file).

# Enter the dataset directory.
setwd("./UCI HAR Dataset/")

# Load necessary packages
# install.packages("reshape2")
library(reshape2)

## 1. Merge the training and the test sets to create one data set.

# Set the necessary filenames.
trainfile <- "train/X_train.txt"
trainlabelsfile <- "train/y_train.txt"
trainsubjectfile <- 'train/subject_train.txt'
testfile <- "test/X_test.txt"
testlabelsfile <- "test/y_test.txt"
testsubjectfile <- 'test/subject_test.txt'

# Import the training files.
traindata <- read.table(trainfile)
trainlabeldata <- read.table(trainlabelsfile)
trainsubjectdata <- read.table(trainsubjectfile)
training <- cbind(trainsubjectdata,trainlabeldata,traindata)

# Import the testing files.
testdata <- read.table(testfile)
testlabeldata <- read.table(testlabelsfile)
testsubjectdata <- read.table(testsubjectfile)
testing <- cbind(testsubjectdata,testlabeldata,testdata)

# Merge the test and training datasets into one
data <- rbind(testing,training)

# Rename the headers as appropriate.
features <- read.table("features.txt")
headers <- c("subject", "activity", as.character(features$V2))
names(data) <- headers

# Tidy up id column classes
data$subject <- as.factor(data$subject)
data$activity <- as.factor(data$activity)

## 3 Use descriptive activity names to name the activities in the data set
## 4 Appropriately label the data set with descriptive activity names. 
activityLabels <- read.table("activity_labels.txt")
levels(data$activity) <- activityLabels$V2

## 2. Extract only the measurements on the mean and standard deviation 
##    for each measurement.

# Filter feature columns for matches of "mean()" or "std()"
filteredFeatures <- subset(features, 
                           (grepl("mean()", V2, fixed=TRUE) | 
                            grepl("std()", V2, fixed=TRUE)))
columns <- c(1,2,filteredFeatures[,1] + 2)
# Subset our data and only take variable names with "mean()" or "std()" 
# in the title.
filtered <- data[,columns]

## 5 Create a second, independent tidy data set with the average of each 
##   variable for each activity and each subject.

# Melt the data then decast to create our tidy dataset.
melted <- melt(filtered,id=c("subject","activity"))
tidy <- dcast(melted, subject + activity ~ variable, mean)

# Output our tidy dataset.
setwd("../")
write.table(tidy, "tidy.txt")

