# Getting and Cleaning Data Course Project -  run_analysis.R

# Step1. Merges the training and the test sets to create one data set.
# Read data
message("reading data X_train.txt....")
trainData <- read.table("C:/Users/home/Desktop/REx/week3/UCI HAR Dataset/train/X_train.txt")
message("reading data y_train.txt....")
trainLabel <- read.table("C:/Users/home/Desktop/REx/week3/UCI HAR Dataset/train/y_train.txt")
message("reading data subject_train.txt....")
trainSubject <- read.table("C:/Users/home/Desktop/REx/week3/UCI HAR Dataset/train/subject_train.txt")
message("reading data X_test.txt....")
testData <- read.table("C:/Users/home/Desktop/REx/week3/UCI HAR Dataset/test/X_test.txt")
message("reading data y_test.txt....")
testLabel <- read.table("C:/Users/home/Desktop/REx/week3/UCI HAR Dataset/test/y_test.txt") 
message("reading data subject_test.txt....")
testSubject <- read.table("C:/Users/home/Desktop/REx/week3/UCI HAR Dataset/test/subject_test.txt")
# Merge data
joinData <- rbind(trainData, testData)
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)

# Step2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Read the feature data
features <- read.table("C:/Users/home/Desktop/REx/week3/UCI HAR Dataset/features.txt")
# Find the mean and std columns
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2]) 
joinData <- joinData[, meanStdIndices]
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 

# Step3. Uses descriptive activity names to name the activities in the data set
activity <- read.table("C:/Users/home/Desktop/REx/week3/UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# Step4. Appropriately labels the data set with descriptive activity names. 
names(joinSubject) <- "subject"
# write clean Data
cleanedData <- cbind(joinSubject, joinLabel, joinData)

# write merged and cleaned Data
message("Writing merge cleaned data....")
write.table(cleanedData, "C:/Users/home/Desktop/REx/week3/UCI HAR Dataset/merged_clean_data.txt") 

# Step5. Creates a second, independent tidy data set with the average of  each variable for
#each activity and each subject. 
subjectLen <- length(table(joinSubject))
activityLen <- dim(activity)[1] 
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == cleanedData$subject
        bool2 <- activity[j, 2] == cleanedData$activity
        result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}
message("Writing Tidy data....")
write.table(result, "C:/Users/home/Desktop/REx/week3/UCI HAR Dataset/tidy_Data.txt") # write Tiday data.

