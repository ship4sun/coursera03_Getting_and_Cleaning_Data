
# You should create one R script called run_analysis.R that does the following. 
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# 1. Merges the training and the test sets to create one data set.

#1) Set the directory

setwd("D:/Bigdata/Coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

#2) Load the feature lables
features <- read.table("features.txt")
features_2 <- features[,2]

#3) load the test and train files
test <- read.table("./test/X_test.txt")
train <- read.table("./train/X_train.txt")

#4) Merge the test and train fils
activity <- rbind(test, train)

#5) Label variables
colnames(activity) <- features_2


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

extract_var  <- grepl("-mean\\(\\)|-std\\(\\)",features_2)
filteredactivity <- activity[,which(extract_var == TRUE)]


#3. Uses descriptive activity names to name the activities in the data set

#1) load the label of test and train files
test_L <- read.table("./test/Y_test.txt")
train_L <- read.table("./train/Y_train.txt")

#2) Merge the lables

allLabelSets <- rbind(test_L, train_L)

#3) Load theactivity names

activityLabels  <- read.table("./activity_labels.txt")[,2]

#4) load the subject of test and train files

subject_test <- read.table("./test/subject_test.txt")
subject_train <- read.table("./train/subject_train.txt")

#5) Merge the subjects

allsubject <- rbind(subject_test, subject_train)


#4. Appropriately labels the data set with descriptive variable names. 

filteredactivity[,"activity"] <- allLabelSets
filteredactivity$activity <- ifelse(filteredactivity$activity==1,"WALKING", 
      ifelse(filteredactivity$activity==2, "WALKING_UPSTAIRS",
      ifelse(filteredactivity$activity==3, "WALKING_DOWNSTAIRS",
      ifelse(filteredactivity$activity==4, "SITTING",
      ifelse(filteredactivity$activity==5, "STANDING","LAYING")))))
filteredactivity$activity <- as.factor(filteredactivity$activity)

filteredactivity[,"subject"] <- allsubject

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

final_table <- aggregate(filteredactivity[,1:66], list(filteredactivity$activity, filteredactivity$subject), mean, na.rm = FALSE)
write.table(final_table, file="tide_HCI_table.txt", row.name=FALSE)
