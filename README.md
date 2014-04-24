Getting and Cleaning Data Project
===========

This project includes a script, run_analysis.R, that prepares a tidy
data set for analysis. The data for the project are linked
[here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). A
full description is available
[here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
at the site where the data was obtained.

The project includes the following files:
=========================================

- 'README.md'
- 'run_analysis.R'

### run_analysis.R

This script does the following:

1. Merges the training and the test sets to create one data set.
1. Extracts only the measurements on the mean and standard deviation for each measurement. 
1. Uses descriptive activity names to name the activities in the data set
1. Appropriately labels the data set with descriptive activity names. 
1. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
