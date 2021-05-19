
# Peer Graded Assignment: Getting and Cleaning Data Course Project 

The purpose of this assignment is to demonstrate your ability to collect, work with, and clean a data set. 

## Assignment description 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

## Data set 

[Link to data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

[Information on the data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Files submitted:

* CodeBook.md: Describes the variables, the data, and any transformations or work performed to clean up the data
* run_analysis.R: an R-script that does the following:
  + Downloads the data 
  + Merges the training and the test sets to create one data set
  + Extracts only the measurements on the mean and standard deviation for each measurement. 
  + Uses descriptive activity names to name the activities in the data set
  + Appropriately labels the data set with descriptive variable names. 
  + From the data set in the previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* TidyData.txt: the final tidy data as described in the step above
