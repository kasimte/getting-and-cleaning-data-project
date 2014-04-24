# run_analysis.R

# The code should have a file run_analysis.R in the main directory that 
# can be run as long as the Samsung data is in your working directory. 
# The output should be the tidy data set you submitted for part 1. 
# You should include a README.md in the repo describing how the script works. 

# You should create one R script called run_analysis.R that does the following. 
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation 
#   for each measurement. 
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive activity names. 
# 5 Creates a second, independent tidy data set with the average of each 
#   variable for each activity and each subject. 

# Set working directory.
# getwd()
# setwd("/Users/Kasim/Documents/Coursera/DataScience/getting-and-cleaning-data/getting-and-cleaning-data-project/UCI HAR Dataset/")

setwd("./UCI HAR Dataset/")
# Install and load packages.
install.packages("reshape2")
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
write.csv(tidy, "tidy.csv")

