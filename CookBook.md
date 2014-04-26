# Project Cookbook

This file describes the variables, data, and transformations
performed to clean up the data in this project.

Raw Data
----

The raw data for the project are linked
[here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). A
full description is available
[here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
at the site where the data was obtained. Refer to the raw data source
for detailed descriptions of the measurements.

Transformations
----

The "run_analysis.R" script transforms the raw data as follows:

1. Merges the training and the test data sets to create one data set.
1. Extracts only the measurements on the mean and standard deviation
for each measurement. More specifically, for each measurement,
variables matching "mean()" or "std()" were selected.
1. Appropriately labels the data set with descriptive activity names
(e.g., "WALKING" instead of "1").
1. Renames the column headers as appropriate (e.g. "subject",
"activity", (variable_name)).
1. Creates a second, independent tidy data set with the average of
each variable for each activity and each subject. 


Tidy Data Variables
----

The output is a tidy dataset named "tidy.txt". This dataset has 180
rows (30 subjects * 6 activities) and 68 columns ("subject",
"activity", and 66 variables for standard deviation and means of the
original measurements). 

    > dim(tidy)
    [1] 180  68

The value for each of the variables is the average for each activity
and each subject calculated from the appropriate set of observations
from the raw data. So, for example, please see the following example:

    > tidy[1,1:3]
      subject activity tBodyAcc-mean()-X
    1       1  WALKING         0.2773308

This shows the first three columns of the first row. The subject was
1, the activity was walking, and the mean of all the
"tBodyAcc-mean()-X" variable values for this subject and activity
combination from the raw dataset was 0.2773308.
