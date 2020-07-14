library(dplyr)

#------------------------------------------
# 1. Merging the training and the test sets
#------------------------------------------

# Data on features
features_data <- read.table("UCI HAR Dataset/features.txt", 
                            col.names = c("featnum","feature"))

# Data on activity labels
activity_data <- read.table("UCI HAR Dataset/activity_labels.txt", 
                            col.names = c("actnum", "activity"))

# Training data sets
train_Xdata <- read.table("UCI HAR Dataset/train/X_train.txt", 
                          col.names = features_data$feature)
train_Ydata <- read.table("UCI HAR Dataset/train/Y_train.txt", 
                          col.names = "actnum")
train_subdata <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "subject")

# Test data sets
test_Xdata <- read.table("UCI HAR Dataset/test/X_test.txt",
                         col.names = features_data$feature)
test_Ydata <- read.table("UCI HAR Dataset/test/Y_test.txt",
                         col.names = "actnum")
test_subdata <- read.table("UCI HAR Dataset/test/subject_test.txt",
                           col.names = "subject")

# Merging training and test data sets
total_Xdata <- rbind(train_Xdata, test_Xdata)
total_Ydata <- rbind(train_Ydata, test_Ydata)
total_subdata <- rbind(train_subdata, test_subdata)
merged_data <- cbind(total_subdata, total_Xdata, total_Ydata)

#-------------------------------------------------------------------
# 2. Extracting the mean and standard deviation for each measurement
#-------------------------------------------------------------------

select_data <- merged_data %>% 
  select(subject, actnum, contains("mean"), contains("std"))

#------------------------------
# 3. Descriptive activity names
#------------------------------

select_data$actnum <- activity_data[select_data$actnum,2]

#----------------------------------------------------
# 4. Labeled data set with descriptive variable names
#----------------------------------------------------

names(select_data) <- gsub("^t", "Time", names(select_data))
names(select_data) <- gsub("^f", "Frequency", names(select_data))
names(select_data) <- gsub("-mean()", "Mean", names(select_data), 
                           ignore.case = TRUE)
names(select_data) <- gsub("-std()", "STD", names(select_data), 
                           ignore.case = TRUE)
names(select_data) <- gsub("-freq()", "Frequency", names(select_data), 
                           ignore.case = TRUE)
names(select_data) <- gsub("Acc", "Accelerometer", names(select_data))
names(select_data) <- gsub("angle", "Angle", names(select_data))
names(select_data) <- gsub("BodyBody", "Body", names(select_data))
names(select_data) <- gsub("Gyro", "Gyroscope", names(select_data))
names(select_data) <- gsub("gravity", "Gravity", names(select_data))
names(select_data) <- gsub("Mag", "Magnitude", names(select_data))
names(select_data) <- gsub("tBody", "TimeBody", names(select_data))
names(select_data)[2] = "activity"

#-----------------------------
# 5. Independent tidy data set
#-----------------------------

tidy_data <- select_data %>% group_by(subject, activity) %>% 
  summarize_all(funs(mean))
write.table(tidy_data, "TidyData.txt", row.name=FALSE)







