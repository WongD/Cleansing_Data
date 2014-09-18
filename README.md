Cleansing_Data Course Project
==============

This document explains the steps taken in manipulating the raw data [1]
in order to obtain a tidy data set as required for the Coursera, Getting and Cleansing data project.
For exact details and methods see the script run_analysis in this repository.

- the data is downloaded from the source (mentioned above) and unzipped to the 'Data' folder  (which will be created if it doesn't already exist) in the working directory of R.
  Whilst the downloading of this file was not specificly required by the instructions for this project it does provide some assurance that the source data is entirely unadulterated and further ensures that all of the processing required to obtain the 'tidy' data set is entirely reproducible.

- a vector is created listing all the extracted files (with their full file paths)
- a vector is created listing the relevant files
("features.txt", "X_train.txt", "y_train.txt", "X_test","y_test", "subject_test.txt", "subject_train.txt", "activity_labels.txt")
- these files are then loaded to R with the above names (less the file extension)
- the columns of the X_test and y_test tables are renamed using the names in the 'features' file
- to assist in linking and combining these tables a integer sequence is assigned as a 'primary key' unique identifier

Combining the data
- the y_test table is then merged with the activity_labels and the activity variable is renamed appropriately
- the resultant table is then merged with the subject_test table and the new column is renamed Subject_ID
- this table is then merged with the X_test table
- the above three steps are then repeated using the training data (X_train, y_train, subject_train)
- the training and test data is then combined

Summarising and tidying
- any columns in this new data set which do not contain the following strings are then removed from the table;
ID, Activity, Subject_ID, mean, std.
- a new data set is created containing the mean of these columns summarised by Activity and Subject_ID
- the variable names are then modified to be more accesible (see Code book in this repository for further details)
- this table is then exported to a (double quote text delimited, space seperated) text file named "tidy_data".


References
----------
- 1. Raw data (Source :  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, dowloaded at 17/09/2014)
