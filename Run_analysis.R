
library(dplyr)

#setting the working directory where all files would be placed.
getwd()
setwd("C:/Users/mmucyberjaya/Documents/R-Studio/R-programming_Hopkin Uni")

#downloading the required "dataset". 
ziped_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(ziped_url, destfile = "./fprojectfile.zip")

list.files() #list of files in the given directoryfile.
zfp<- file.choose("fprojectfile.zip")

#the downloaded dataset is in a zip format, hence it needs to be unzipped
unzip(zipfile= "./fprojectfile.zip" , exdir = "./R-programming_Hopkin Uni")
list.files()
setwd ("./UCI HAR Dataset")
getwd()
list.files()

# 1. Merge the training and test datasets

# 1.1 Reading files

# 1.1.1 Reading training datasets
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

# 1.1.2 Reading test datasets
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

# 1.1.3 Reading feature vector
setwd("C:/Users/mmucyberjaya/Documents/R-Studio/R-programming_Hopkin Uni/UCI HAR Dataset")
list.files()
features <- read.table("./features.txt")

# 1.1.4 Reading activity labels
activityLabels = read.table("./activity_labels.txt")

# 1.2 Assigning variable names to the columns for each of the datasets
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"

colnames(activityLabels) <- c("activityID", "activityType")

# 1.3 Merging all datasets into one set
alltrain <- cbind(y_train, subject_train, x_train)
alltest <- cbind(y_test, subject_test, x_test)
finaldataset <- rbind(alltrain, alltest)



# 2. Filter the measurements for the mean and sd for each measurement

# 2.1 Reading column names and calling the columnn names to verify the counts.
colNames <- colnames(finaldataset)
colNames

# 2.2 Create vector for defining ID, mean, and sd
mean_and_std <- (grepl("activityID", colNames) |
                   grepl("subjectID", colNames) |
                   grepl("mean..", colNames) |
                   grepl("std...", colNames)
)



# 2.3 Making necessary subset
set_for_Mean_and_Std <- final_dataset[ , mean_and_std == TRUE]




# 3. Use descriptive activity names
setWithActivityNames <- merge(setforMeanandStd, activityLabels,
                              by = "activityID",
                              all.x = TRUE)


# 4. Label the data set with descriptive variable names
# This can be found in these section; 1.3, 2.2, 2.3 which 
# has been demonstrated above... 



# 5. Creating a second,  independent tidy data set with the avg of each variable for each activity and subject

# 5.1 Making a second tidy data set
tidyDataSet <- aggregate(. ~subjectID + activityID, setWithActivityNames, FUN = "mean")
tidyDataSet <- tidyDataSet[order(tidyDataSet$subjectID, tidyDataSet$activityID), ]
tidyDataSet

# 5.2 Write second tidy data set into a .txt file
write.table(tidySet, "tidySet.txt", row.names = FALSE)

