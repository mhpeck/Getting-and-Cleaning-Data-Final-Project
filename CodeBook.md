# Getting and Cleaning Data: Final Course Assignment Code Book 

This code book describes the variables, data, and any transformations or work performed to clean up the data. The structure mirrors the steps in run_analysis.R.

## Pre-work: Set working directory, load packages, and download/read data

### Load required packages 
* dplyr package will be used 

### Download data set 
Data set downloaded and unzipped into a folder called "UCI HAR Dataset"

### Read in data for test and training datasets
* features (features.txt) - contains information on feature vector, containing two columns, featureID and description. There are 561 features, coming from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
    ```{r features, include = TRUE}
    features <- read.table("UCI HAR Dataset/features.txt", col.names = c("FeatureID", "Description"))
    head(features)
    ```
* activity_labels (activity_labels.txt) - links the class labels with their activity name. There are 6 activity labels:
    ```{r activity_labels, include = TRUE}
    activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("LabelID", "Activity"))
    activity_labels
    ```
* subject_test (test/subject_test.txt) - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30 (30 subjects). There are 2947 rows.
* x_test (test/x_test.txt) - test data measured across the 561 features (stored in columns), for the 2947 rows. Column names come from "features"
* y_test (test/y_test.txt) - test activity labels. The column maps to labelID, and corresponds to the associated activity label (2947 rows, 1 column)
* subject_train (train/subject_train.txt) - similar to "subject_test" but for the training set (7352 rows, 1 column)
* x_train (train/x_train.txt) - similar to "x_test", but for the training set (7352 rows, 561 columns)
* y_train (train/y_train.txt) - similar to "y_test" but for the training set (7352 rows, 1 column)

## Step 1: Merge test and training data 
* test: combines test data into a single data frame (subject_test, x_test, y_test). Resulting data frame contains 2947 rows, 563 columns.
* train: combines training data into a single data frame (subject_train, x_train, y_train). Resulting data frame contains 7352 rows, 563 columns. 
* data_consolidated: combines test and train into a single data frame using the rbind() function - contains 10299 rows and 563 columns.

## Step 2: Extract only the measurements for the mean and std. dev. for each measurement
* features_mean_std: a vector indicating where "mean" or "std" are contained in the feature name. This is used to subset the data set to only mean/std measurements.
* data_mean_std: the new data frame, after subsetting to only mean/std features (10299 rows, 81 columns)

## Step 3: Use descriptive activity names to name the activities in the data set
* joined: data_mean_std (the subset data frame above) joined with activity_labels on labelID to add in the label description. 
* data_tidy: a subset of the columns of joined, rearranged to include the activity label as the second column (10299 rows, 81 columns)

## Step 4: Appropriately label the data with descriptive variable names
#### This step applies a number of adjustments to the feature names, including (stored in a character vector called col_names):
* Removing ()
* Replacing "acc" and "gyro" with accelerometer and gyroscope, respectively
* Replacing "freq" with "frequency"
* Adding in "TimeDomain" or "FrequencyDomain" at the front of the feature name (where the name starts with t or f, respectively)
* Replacing "-" with "_"
* Replacing "mean" and "std" with "Mean" and "StandardDeviation"
* Replacing "mag" with "Magnitude"
* Replacing "BodyBody" with "Body"
Then renaming the columns in data_tidy with the character vector col_names


## Step 5: From the data in Step 4, create a new, independent tidy dataset with the average of each variable, for each activity and subject
#### This step first groups the data by Subject and Activity, and then calculates the average for each variable:
* data_tidy_grouped: the grouped data table (10299 rows, 81 columns)
* data_tidy_summarised: the final data frame grouped by subject and activity, with the mean calculated for each variable (180 rows, 81 columns)
The script then exports this to a .txt file.

