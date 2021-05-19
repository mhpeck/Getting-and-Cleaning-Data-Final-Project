## Pre-work: Set working directory, load packages, and download/read data
library(dplyr)
  # Download and unzip files (only if it doesn't already exist)
  ProjectfileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    if(!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")){
      download.file(ProjectfileURL, "getdata_projectfiles_UCI HAR Dataset.zip", method = "curl")
      unzip("getdata_projectfiles_UCI HAR Dataset.zip")
    }
  
  #Read in data for test and train (not yet including measurements)
    # meta data
    features <- read.table("UCI HAR Dataset/features.txt", col.names = c("FeatureID", "Description"))
    activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("LabelID", "Activity"))
    
    # test 
    subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("Subject"))
    x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=features$FeatureID)
    y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names=c("LabelID"))
    
    # train
    subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names=c("Subject"))
    x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=features$FeatureID)
    y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names=c("LabelID"))


## Step 1: Merge test and training data 
  # First combine test
  test <- cbind(subject_test, y_test, x_test)

  # Now train 
  train <- cbind(subject_train, y_train, x_train)

  # Now combine them both
  data_consolidated <- rbind(test, train)


## Step 2: Extract only the measurements for the mean and std. dev. for each measurement
  # Find the elements in 'features' that correspond to mean + std.
  features_mean_std <- grep("mean|std", features[, 2])

  # Limit to these elements
  data_mean_std <- data_consolidated[, c(1, 2, features_mean_std + 2)]


## Step 3: Use descriptive activity names to name the activities in the data set
joined <- inner_join(data_mean_std, activity_labels, by = "LabelID")
data_tidy <- joined[ , c(1, 82, 3:81)]


## Step 4: Appropriately label the data with descriptive variable names
col_names <- c("Subject", "Activity", features$Description[features_mean_std])
col_names <- gsub("[()]", "", col_names)
col_names <- gsub("Acc", "Accelerometer", col_names)
col_names <- gsub("Freq", "Frequency", col_names)
col_names <- gsub("Gyro", "Gyroscope", col_names)
col_names <- gsub("^t", "TimeDomain_", col_names)
col_names <- gsub("^f", "FrequencyDomain_", col_names)
col_names <- gsub("-", "_", col_names)
col_names <- gsub("mean", "Mean", col_names)
col_names <- gsub("std", "StandardDeviation", col_names)
col_names <- gsub("Mag", "Magnitude", col_names)
col_names <- gsub("BodyBody", "Body", col_names)
names(data_tidy) <- col_names


## Step 5: From the data in Step 4, create a new, independent tidy dataset with
## the average of each variable, for each activity and subject
data_tidy_grouped <- data_tidy %>% group_by(Subject, Activity) 
data_tidy_summarised <- data_tidy_grouped %>% summarise(across(.fns = mean))

  #export
  write.table(data_tidy_summarised, "TidyData.txt")
