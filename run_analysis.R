# COURSE PROJECT.

# DATE: 2014/07/22

# My working directory:
setwd("D:/Documents and Settings/UPV-EHU/Escritorio/Getting_&_Cleaning_Data/Assignement")

##############
# FIRST STEP #
##############

# Merges the training and the test sets to create one data set.

# Read the necessary data related with train data.

features <- read.table("features.txt",header=F)
activity_labels <- read.table("activity_labels.txt",header=F)
subject_train <- read.table("subject_train.txt",header=F)
x_train <- read.table("X_train.txt",header=F)
y_train <- read.table("y_train.txt",header=F)

# Assign column names to the data.
colnames(activity_labels) <- c("Activity_id","Activity_type")
colnames(subject_train) <- "id"
colnames(x_train) <- features[,2]
colnames(y_train) <- "Activity_id"

# Generate the train dataset
train_data <- cbind(y_train,subject_train,x_train)
summary(train_data)

# Read the necessary data related with test data.
subject_test <- read.table("subject_test.txt",header=F)
x_test <- read.table("X_test.txt",header=F)
y_test <- read.table("y_test.txt",header=F)

# Assign column names to the data.
colnames(subject_test) <- "id"
colnames(x_test) <- features[,2]
colnames(y_test) <- "Activity_id"

# Generate the test dataset:
test_data <- cbind(y_test,subject_test,x_test)
summary(test_data)

# Create the final dataset merging the train data set and the test data set:
final_data <- rbind(train_data,test_data)

###############
# SECOND STEP #
###############

# Extracts only the measurements on the mean and standard deviation for each measurement. 

# Create a vector for the column names from the final dataset in order to use it to extract the mean and standard deviation 
# for each measurement:

column_names <- colnames(final_data)
vector <- ((grepl("mean()",column_names) | grepl("std()",column_names) | grepl("Activity_id",column_names) | grepl("id",column_names)) & (!grepl("meanFreq",column_names)))

# Exctract only the mean and standard deviation for each measuremnt
finaldata <- final_data[vector==TRUE]
names(finaldata)

##############
# THIRD STEP #
##############

# Uses descriptive activity names to name the activities in the data set

# Merge the finaldata dataset with the activity type table in order to add descriptive activity names to the dataset.
finaldata <- merge(finaldata,activity_labels,by="Activity_id",all.x=T)
column_names <- colnames(finaldata)

###############
# FOURTH STEP #
###############

# Appropriately labels the data set with descriptive variable names.

# Cleaning current variable names.
for (i in 1:length(column_names)){
  column_names[i] <- gsub("\\()","",column_names[i])
  column_names[i] <- gsub("-std","_SD",column_names[i])
  column_names[i] <- gsub("-mean","_Mean",column_names[i])
  column_names[i] <- gsub("^(t)","time_",column_names[i])
  column_names[i] <- gsub("^(f)","freq_",column_names[i])
  column_names[i] <- gsub("([Gg]ravity)","Gravity",column_names[i])
  column_names[i] <- gsub("([Bb]ody [Bb]ody | [Bb]ody)","Body",column_names[i])
  column_names[i] <- gsub("[Gg]yro","Gyro",column_names[i])
  column_names[i] <- gsub("AccMag","AccMagnitude",column_names[i])
  column_names[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",column_names[i])
  column_names[i] <- gsub("JerkMag","JerkMagnitude",column_names[i])
  column_names[i] <- gsub("GyroMag","GyroMagnitude",column_names[i])
}  

# Update the databases's variable names.

colnames(finaldata) <- column_names

##############
# FIFTH STEP #
##############

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Build a new dataset without Activity_type:
finaldata2 <- finaldata[,names(finaldata) != "Activity_type"]

# Summarize the new dataset so as to include the mean of each variable and each subject:
tidydata <- aggregate(finaldata2[,names(finaldata2) != c("Activity_id","id")],
                      by=list(Activity_id=finaldata2$Activity_id,id = finaldata2$id),mean)

# Merge to tidydata the Activity to include the descritptive activity names:
tidydata <- merge(tidydata,activity_labels,by="Activity_id",all.x=T)

# Export the final tidydata dataset:
write.table(tidydata,"tidydata.txt",row.names=T,sep="\t")
