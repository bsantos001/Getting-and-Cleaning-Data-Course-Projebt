## Getting and Cleaning Data Project

Borja Santos Zorrozúa

### Description
Additional information about the variables, data and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course.

### Source Data
A deeper description of the data used  can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### About Data Set
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Attribute Information
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Section 1. Merge the training and the test sets to create one data set.
After setting the source directory for the files, you have to read and save as data.frames the data located in the following files:
- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

The next step was assign column names and merge to create one data set.

## Section 2. Extract only the measurements on the mean and standard deviation for each measurement. 
The first thing I did was define a logical vector that contains TRU values for the ID, mean and SD columns (variables) and FALSE for the others.
I did that in order to keep only the necessary variables subsetting the dataset in order to keep that variables.

## Section 3. Use descriptive activity names to name the activities in the data set
Merge data subset with the activityType table to add the descriptive activity names to the dataset so as to have a better description of them.

## Section 4. Appropriately label the data set with descriptive activity names.
Use gsub function for to cleaning up the data labels.

## Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
Per the project instructions, we need to produce only a data set with the average of each veriable for each activity and subject.
Once I did that database I exported it to a external tabbulate file (tidydata.txt).
