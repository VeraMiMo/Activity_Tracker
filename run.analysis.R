#required libraries
library(data.table)
library(plyr)
library(dplyr)
library(tidyr)

#Check, if folder for downloaded data exists. If not, create it
if(!file.exists("data")){
        dir.create("data")
}
#download file
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile ="./data/ProjectData.zip", method = "curl")
#extract files from zip file
unzip("data/ProjectData.zip", exdir = "./data")
#read files into R
features <- fread("./data/UCI HAR Dataset/features.txt")
activity_labels <- fread("./data/UCI HAR Dataset/activity_labels.txt")
training_set <- fread("./data/UCI HAR Dataset/train/X_train.txt")
training_labels <- fread("./data/UCI HAR Dataset/train/y_train.txt")
test_set <- fread("./data/UCI HAR Dataset/test/X_test.txt")
test_labels <- fread("./data/UCI HAR Dataset/test/y_test.txt")
test_subject <- fread("./data/UCI HAR Dataset/test/subject_test.txt")
training_subject <- fread("./data/UCI HAR Dataset/train/subject_train.txt")

#add colnames and variables
colnames(training_set) <- features$V2
training_set$subject <- training_subject$V1
training_set$activity_key <- training_labels$V1
training_set$data_set <- "training"

colnames(test_set) <- features$V2
test_set$subject <- test_subject$V1
test_set$activity_key <- test_labels$V1
test_set$data_set <- "test"

colnames(activity_labels) <- c("activity_key", "activity")

#extract mean and standard deviation
test_mean_stdv <- select(test_set,contains("data_set") | contains("subject")
                                       | contains("activity_key")
                                       | contains("mean()") | contains("std()"))
                         
                         
training_mean_stdv <- select(training_set,contains("data_set") |contains("subject")
                                |contains("activity_key")
                                               |contains("mean()") |contains("std()"))

#merge test and training data
DT <- rbind(test_mean_stdv, training_mean_stdv)

#use descriptive activity names
setkey(DT, activity_key)
setkey(activity_labels, activity_key)
DT <- merge(activity_labels, DT)
DT <- DT[, !"activity_key"]
write.table(DT, "./data/CombinedData.txt", row.name=FALSE)

#data set with average of each variable for each activity and each subject
Summary <- ddply(DT, .(activity, subject), numcolwise(mean))
write.table(Summary, "./data/Summary.txt", row.name=FALSE)









