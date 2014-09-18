# Set source url
SourceUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Create directory for download if required
if(!file.exists("Data")) {dir.create("Data")}

#Create destination string
dest<- paste(getwd(), "/Data/source.zip", sep="")

#download file
download.file(SourceUrl, dest)

# extract file to data folder 
setwd("./Data")
unzip(dest)

#create vector of ALL file paths 
file_list<-list.files(getwd(), all.files=TRUE, full.names=TRUE, recursive=TRUE)

#create vector of relevant files
relevant <- c("features.txt", "X_train.txt", "y_train.txt", "X_test") 
relevant <- c(relevant, "y_test", "subject_test.txt", "subject_train.txt", "activity_labels.txt")

#intitalise vector of file paths to load
files_to_load <- vector()

#loop through all files and create vector of files to load
for(i in 1:length(file_list)){    # loop through file list
  
  for(x in 1:length(relevant)){   # loop through list of relevant files
    
    if(grepl(relevant[x],file_list[i]) & !grepl("Inertial",file_list[i])) {
      files_to_load <- c(files_to_load,file_list[i]) # add to list of files to load
    }
  }
}

# load all relevant data to R, name appropriately
for (i in 1:length(files_to_load)){
  assign(gsub(".txt","", basename(files_to_load[i])), read.table(files_to_load[i])) 
}

#assign column names
colnames(X_test) <-features[,2]
colnames(X_train)<- features[,2]

#create unique primary key columns to assist in linking data
X_test$ID = seq(along=X_test[,1])
y_test$ID = seq(along=y_test[,1])
X_train$ID = seq(along=X_train[,1])
y_train$ID = seq(along=y_train[,1])
subject_test$ID = seq(along=subject_test[,1])
subject_train$ID = seq(along=subject_train[,1])

#merge all TEST data, rename columns where useful
#merge y_test and activity labels
test_merge = merge(y_test, activity_labels, by.x="V1", by.y="V1", all=TRUE)
#remove redundant column
test_merge <- test_merge[,-1]
#rename column for future reference
names(test_merge)[2]<-"Activity"
#merge to add subject identifier
test_merge = merge(test_merge, subject_test, by.x="ID", by.y="ID", all=TRUE)
#rename column appropriately
names(test_merge)[3]<-"Subject_ID"
#merge to X_Test
test_merge = merge(test_merge, X_test, by.x="ID", by.y="ID", all=TRUE)

#merge all TRAINING data, rename columns where useful
#merge y_train and activity labels
train_merge = merge(y_train, activity_labels, by.x="V1", by.y="V1", all=TRUE)
#remove redundant column
train_merge <- train_merge[,-1]
#rename column for future reference
names(train_merge)[2]<-"Activity"
#merge to add subject identifier
train_merge = merge(train_merge, subject_train, by.x="ID", by.y="ID", all=TRUE)
#rename column appropriately
names(train_merge)[3]<-"Subject_ID"
#merge to X_train
train_merge = merge(train_merge, X_train, by.x="ID", by.y="ID", all=TRUE)

#unite test and training data sets
data<-rbind(test_merge, train_merge)

#remove irrelevant columns
data<-data[,(colnames(data) %in% c("ID","Activity","Subject_ID"))|grepl("mean",colnames(data))|grepl("std",colnames(data))]
data<- data[,-1] #remove the ID column which is no longer required

#create tidy data set, summarise mean
library(plyr)
summary<-ddply(data, c("Subject_ID", "Activity"), numcolwise(mean))

#rename variables to make more meaningful
colnames(summary)<- gsub('^t', 'Time_', colnames(summary))
colnames(summary)<- gsub('^f', 'Freq_', colnames(summary))
colnames(summary)<- gsub('Mag-', '_Magnitude_', colnames(summary))
write.table(summary, "tidy_data.txt", row.names=FALSE)