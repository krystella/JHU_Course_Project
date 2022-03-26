## **README**

Author: Krystella Rattan

Date: 23-March-2022

Project: Getting and Cleaning Data Course Project

##

### **Table of Contents**
1. [Introduction](#Introduction)
2. [Project Description and Instructions](#Project-Description-and-Instructions)
3. [Repository Contents](#Repository-Contents)
4. [Data Analysis Summary](#Data-Analysis-Summary)
5. [References](#References)

##

### **Introduction**

This project is the final assessment for the course "Getting and Cleaning Data" offered by John Hopkins University through Coursera.

The project requires that students demonstrate an ability to collect, work with, and clean a data set. The goal is to prepare a tidy data set that can be used for later analysis. 

##

### **Project Description and Instructions**

As taken from the Assignment Instructions on the course website:

One of the most exciting areas in all of data science right now is wearable computing [...]. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


You should create one R script called run_analysis.R that does the following:

  1. Merge the training and test sets to create one data set.
  
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  
  3. Uses descriptive activity names to name the activities in the data set
  
  4. Appropriately labels the data set with descriptive variable names.
  
  5. From the data set in step 4. creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##  

### **Repository Contents**

This repository contains the following files:

  * readme.md

  * run_analysis.R
  
  * codebook.md

  * TidyData.txt

The R script 'run_analysis.R' contains the code which performs the analysis. 

The script is comprised of 11 code sections, which work together to achieve the 5 requirements stipulated in "Project Description and Instructions". The code sections are:


  1. Downloading and unzipping the data
  
  2. Reading the files into R
  
  3. Becoming familiar with the data
  
  4. Descriptive variable names for each data set
  
  5. Collating Test data
  
  6. Collating Train data
  
  7. Merging the Test and Train data sets
  
  8. Extracting Mean and Std variables
  
  9. Descriptive 'Activity' names
  
  10. Tidying variable names
  
  11. Tidy data set


The final output is a text file containing the tidy data data frame "TidyData.txt". To read this code into R, the following code can be used after downloading from Coursera:

```{r}
read.table(file = "filelocation", header = TRUE)

# Example:
read.table("./TidyData.txt", header = TRUE)

```


The codebook ("codebook.md") provides a description of each code section and the steps taken to produce the final tidy data set. The file also provides a description of the variables used and notes manipulation of the original data set.

##

### **Data Analysis Summary**

**1. Training and test data sets were merged to create one data set called "FeaturesData".**

  Code sections 1-7 
  
  These sections of run_analysis.R entails the preparation and manipulation of the original data set to produce a single data frame with variables containing the volunteer identifiers, the activities performed by each volunteer and the measurements taken for a number of different attributes recorded while the volunteers were performing each activity.
  
  The data was first downloaded, unzipped and read into R using the read.table() function. Each file containing data was assigned to an R object similar to its filename. The codebook found in this repository describes each R object created.
  
  To gain an understanding of the contents of each file and the type and structure of each, a number of functions were applied to each object to obtain an understanding of their dimenstions, structure, names of the variables, and the number of unique elements present. The information gathered in this step showed that data for the volunteer IDs, activities performed, and feature measurements were all saved in separate files, with the labels for variable names and activities stored in separate files as well. Files containing test data represented measurements for 9 volunteers, while training data represented measurements for 21 volunteers.
  
  Before the data could be merged, the various parts of each data set needed to be collated and variable names assigned. This was done for both test and training data using functions such as colnames(), rename() and cbind(). The outputs were stored in the data frames TestData and TrainData.
  
  Finally, the test and training data sets (TestData and TrainData) were merged together using rbind() to produce a single data set called 'FeaturesData', which contained measurements for all 30 volunteers.
  

**2. Variables for measurements of mean and standard deviation only were extracted.**

  Code section: 8

  Variables for measurements of mean and standard deviation only were extracted from the full data set, along with the variables 'ID' and 'Activity' which represented volunteer identifiers and actvities performed respectively. This subset of data was stored as a new data frame called 'FeaturesMS'.


**3. Descriptive activity names were used to describe the activities performed.**

  Code Section: 9

  Up to this point, the variable 'Activity' contained only integers representing the different activites performed. To make these more descriptive, each activity integer was replaced by its associated description guided by the data provided in the file "activity_labels.txt". The resulting variable was now a character vector with descriptive names such as "walking", "sitting", and "laying".
  

**4. Variable names were appropriately labelled.**

  Code Sections: 4 & 10

  During the initial steps to merge the data sets, descriptive variable names were assigned to each of the variables, using the data provided in "features.txt".
  
  As part of the tidying process, some of the variable names were edited to ensure the followed the suggested guidelines for naming of variables set out by Prof. Leek in the lecture "Editing text variables". The guidelines for the variable names state that they should be:
  
  a. all lowercase when possible
  
  b. descriptive
  
  c. not duplicated
  
  d. not have any underscores, dots, or whitespaces
  
Since the variable names for feature measurements described many different attributes, 'CamelCase' was used to distinguish each.


**5. A second, independent tidy data set was created with the average of each variable for each activity and subject.**

  Code Section: 11
  
  The final step of this assignment required creating and exporting a second, independent tidy data set with the average of each variable for each activity and subject. This was done by applying the dplyr 'group_by()' function to the variables 'ID' and 'Activity' of the data set 'FeaturesMS' (which contains the extracted mean and standard deviation measurements). To calculate the mean, the function 'summarise_all()' was used. The output was a data frame called 'TidyData' containing 180 rows and 68 columns.
  
  To check that this final data set was tidy, the 'three rules of tidy data' by Hadley Wickham were referenced. It was ensured that:
  
  1. Each variable had its own column
  2. Each observation had its own row
  3. Each value had its own cell
  
  
  The result was saved as a text file "TidyData.txt" using the command write.table().
  
  To download the TidyData.txt data set, see the section "Repository Contents" of this readme.

##  

### **References**

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


Grolemund, Garrett, and Hadley Wickham. R for Data Science. O’Reilly Media, 2017.
https://r4ds.hadley.nz/data-tidy.html


Leek, Jeffrey. Editing Text Variables [Coursera Lecture]. In Jeffrey Leek, Roger D. Peng, Brian Caffo: Getting and Cleaning Data by John Hopkins University. (Retrieved march 2022).
https://www.coursera.org/learn/data-cleaning/home/info







