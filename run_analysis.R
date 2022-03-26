#        PREFACE --------------------------------------------------------------------------------------

#   For information on the aim of this script, the data sets used and the data manipulation sets, 
#   please see the readme.md and codebook.md files attached to this repository
#   
#   This script consists of 11 code sections:
#    1. Downloading and unzipping the data
#    2. Reading files into R
#    3. Becoming familiar with the data
#    4. Descriptive variable names for data sets
#    5. Collating the test data
#    6. Collating the train data
#    7. Merging the test and train data
#    8. Extracting mean and standard deviation variables
#    9. Descriptive 'Activity' names
#   10. Tidying variable names
#   11. Tidy data set

#     1. DOWNLOADING AND UNZIPPING THE DATA -----------------------------------------------------------------

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("./data")){dir.create("./data")}

download.file(fileUrl, destfile = "./data/UCIHAR.zip")

unzip(zipfile = "./data/UCIHAR.zip", exdir = "./data")


#     2. READING FILES INTO R ---------------------------------------------------------------------------

features <- read.table("./data/UCI HAR Dataset/features.txt")

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

x_train <- read.table("./data/UCI HAR Dataset/train/x_train.txt")

y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

x_test <- read.table("./data/UCI HAR Dataset/test/x_test.txt")

y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")


#     3. BECOMING FAMILIAR WITH THE DATA --------------------------------------------------------------

# Features Data

dim(features)

str(features)

head(features)

names(features)

unique(features$V1)

------------------------------------------------------------------------------------------------
# Test_Data 

dim(subject_test)

dim(x_test)

dim(y_test)

str(subject_test)

str(x_test)

str(y_test)

head(subject_test)

head(x_test)

head(y_test)

unique(subject_test)

unique(y_test)

names(x_test)

names(y_test)

# features : Character vector describing different measurements taken (561 x 2)
# subject_test: Volunteer ID numbers (2947 x 1)
# x_test : Data (2947 x 561)
# y_test : Integer vector with integers (1-6) representing the 6 different activities measured

-----------------------------------------------------------------------------------------
# Train Data

str(subject_train)

str(x_train)

str(y_train)

unique(subject_train)

unique(y_train)

names(subject_train)

names(x_train)

names(y_train)

# subject_train: Integer vector of Volunteer ID numbers (7352 x 1)
# x_train : Train data set (7352 x 561)
# y_train : Integer vector with numbers (1-6) representing the different activities measured


#     4. DESCRIPTIVE VARIABLE NAMES FOR THE DATA SET -----------------------------------------------------

# Appropriately label the data set with descriptive names

# A quick look at the data suggests 'features' consists of the variable names for the x_test and x_train data sets

# Attach 'features' as column names for these data sets

feat_labels <- c(features$V2)

colnames(x_test) <- feat_labels

x_test[1:5, 1:4] # quick check

colnames(x_train) <- feat_labels

x_train[1:5, 1:5] # quick check


# Rename subject_test$V1 'ID'
subject_test <- rename(subject_test, ID = V1)

# Rename y_test$V1 'Activity'
y_test <- rename(y_test, Activity = V1)

# Rename subject_train$V1 'ID'
subject_train <- rename(subject_train, ID = V1)

# Rename y_train$V1 'Activity'
y_train <- rename(y_train, Activity = V1)


#     5. COLLATING TEST DATA ----------------------------------------------------------------------------------

# Combine subject_test, y_test and x_test to collate Test data

TestData <- cbind(subject_test, y_test, x_test)

TestData[1:5, 1:5] # quick check


#     6. COLLATING TRAIN DATA ---------------------------------------------------------------------------------

# Combine subject_train, y_train, x_train to collate Train data

TrainData <- cbind(subject_train, y_train, x_train)

TrainData[1:5, 1:5] # quick check


#     7. MERGING TEST AND TRAIN DATA ---------------------------------------------------------------------

# Since the TestData and TrainData combined produces the full data set of all feature measurements taken per activity, the combined data set is called 'Features Data'

# Combine TestData and TrainData using rbind

FeaturesData <- rbind(TestData, TrainData)


# Quick check to ensure the data frames were combined correctly

FeaturesData[2940:2960, 1:5]

ncol(FeaturesData)

nrow(FeaturesData)

unique(FeaturesData$ID)

unique(FeaturesData$Activity)


#     8. EXTRACTING MEAN AND STD VARIABLES --------------------------------------------------------------------

# Required to extract only the measurements on the mean and standard deviation for each measurement, assumed to be mean() and std() measurements

# Since this is a subset of FeaturesData with only mean and std, the subset is called 'FeaturesMS', abbreviated from Features Mean and Std

# Columns 'ID' and 'Activity' also included with the extracted measurements

library(dplyr)

FeaturesMS <- FeaturesData %>% select(ID, Activity, contains("mean()") | contains("std()"))

# Quick check
ncol(FeaturesMS)

names(FeaturesMS)

FeaturesMS[1:5, 1:5]


#     9. DESCRIPTIVE 'ACTIVITY' NAMES ------------------------------------------------------------------

# Data provided in activity_labels.txt used to describe the activities

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

activity_labels

# 1 = Walking ; 2 = Walking_Upstairs ; 3 = "Walking_Downstairs ; 4 = "Sitting" ; 5 = "Standing" ; 6 = "Laying"

class(FeaturesMS$Activity)

FeaturesMS$Activity <- as.character(c("1" = "Walking", "2" = "Walking_Upstairs", "3" = "Walking_Downstairs", "4"= "Sitting", "5" = "Standing", "6" = "Laying")[FeaturesMS$Activity])


# Quick check

FeaturesMS[1:5, 1:5]

unique(FeaturesMS$Activity)


#     10. TIDYING VARIABLE NAMES -------------------------------------------------------------------

# Descriptive variable names were used to label columns in a previous section 'Descriptive variable names for the data set'

# This section uses the guide set out in the lecture 'Editing Text Variables' for tidying those variable names

# Current variable names:
names(FeaturesMS)

# Tidying:
names(FeaturesMS) <- gsub("\\()", "", names(FeaturesMS))
names(FeaturesMS) <- gsub("-", "", names(FeaturesMS))
names(FeaturesMS) <- gsub("_", "", names(FeaturesMS))
names(FeaturesMS) <- gsub("mean", "Mean", names(FeaturesMS))
names(FeaturesMS) <- gsub("std", "Std", names(FeaturesMS))
names(FeaturesMS) <- gsub("^t", "Time", names(FeaturesMS))
names(FeaturesMS) <- gsub("^f", "Frequency", names(FeaturesMS))
names(FeaturesMS) <- gsub("Acc", "Accelerometer", names(FeaturesMS))
names(FeaturesMS) <- gsub("Gyro", "Gyroscope", names(FeaturesMS))
names(FeaturesMS) <- gsub("Mag", "Magnitude", names(FeaturesMS))
names(FeaturesMS) <- gsub("BodyBody", "Body", names(FeaturesMS))

# Quick check:
names(FeaturesMS)

# These adjustments ensured the variable names are:
# 1. all lowercase where possible (CamelCase used to distinguish attributes)
# 2. descriptive
# 3. not duplicated
# 4. without underscores, dots or whitespaces 


#     11. TIDY DATA SET -------------------------------------------------------------------------

# Create an independent tidy data set with the average of each variable for each activity and each subject

TidyData <- FeaturesMS %>% 
  group_by(ID, Activity) %>% 
  summarise_all(mean) %>% 
  print

# Check:
View(TidyData)

# Create output:

write.table(TidyData, "TidyData.txt", row.names = FALSE)

# The resulting data frame 'TidyData' shows that:

# 1. Each variable has its own column
# 2. Each observation has its own row
# 3. Each value has its own cell

# 'TidyData' is, therefore, a tidy data set







