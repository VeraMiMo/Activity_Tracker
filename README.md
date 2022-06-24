# Activity_Tracker
Getting and Cleaning Data Course Project Week 4

R script "run.analysis.R"

run.analysis.R downloads and unpacks the zip file from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The following files are read into R: 

features.txt: List of all features. Used as column names of test and training set

activity_labels.txt: Links class labels with their activity name. Column names are set to „activity_key“ and „activity“ to enable merging

X_train.txt: Training set

y_train.txt: Training labels identifying the respective activity. Introduced as variable „activity_key“ into the training set

X_test.txt: Test set

y_test.txt: Test labels identifying the respective activity. Introduced as variable „activity_key“ into the test set

subject_test.txt: subjects of test data set. Introduced as variable „subject“ into the test set

subject_train.txt: subjects of training data set. Introduced as variable „subject“ into the test set

The variable „data_set“ is introduced to the training set and the test set.

Columns containing mean values and standard deviations of training set and test set are extracted and combined in one data table.

The table containing the data and the table linking class labels with their activity name were merged via their common column „activity_key“, to introduce the variable „activity“ into the final data table. Thereby the variable „activity_key“ becomes superfluous and is deleted.

The resulting data table is saved as „CombinedData.txt“.

Mean values for every numeric variable are calculated for each activity and each subject.

Variable „data_set“ is ignored and average of each variable for each activity and each subject is calculated from combined test and training data. 

The resulting data table is save das „Summary.txt“.
