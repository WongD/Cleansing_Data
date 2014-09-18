This document describes the variables in the 'tidy_data' file in this repository.

The raw data was obtained from the UCI machine learning repository on 17/09/2014 [1].
Their collection methods and descriptions of their variables can be found in the data referenced at the end of this document and are not listed in this document except where neccessary for clarification.
For futher clarification please see the 'features_info' and the 'README' file contained in the raw data mentioned above.

This data was downloaded and decompressed using R 3.1.1's  download.file and unzip functions.
Futher details can be found in the run_analysis script and Read.me files in this repository.

The 'tidy_data' set contains 180 observations of 81 variables;
- the Subject_ID variable is an integer uniquely identifying the person/subject carrying the phone
- the Activity variable identifies the physical activity the subject was undertaking when the data was collected

The remaining 79 variables are the arithmetic mean of values taken from the raw data where the original variable name contained the text strings 'std' or 'mean' grouped by 'Subject_ID' and 'Activity'.


The naming convention for these variables
-----------------------------------------

- the source of the measurement i.e. either accelerometer or gyroscope is indicated by variable names containing "Acc" or "Gyro" respectively

note the accelerometer values are subdivided into Body and Gravity values indicated by the variable names containing "Body" and "Gravity" respectively

- where relevant the axis of direction is indicated in the variable by the suffix -X,-Y-Z

- the prefix "Time" or "Freq" indicates the Time or Frequency domain of these values

- the derived linear acceleration and angular velocity are indicated by the variable names containing 'Jerk' and 'GyroJerk' respectively 

- where the magnitude of these signals have been calulated this is indicated by the variable name containing 'Magnitude'

- the values 'mean()' or 'std()' in the variable name indicate the original value was a arithmetic mean or standard deviation 





References
----------

1. Raw data (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012