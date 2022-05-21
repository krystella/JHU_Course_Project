## **TidyData Codebook**

Author: Krystella Rattan

Date: 23-March-2022

Project: Getting and Cleaning Data Course Project


### **Introduction**

The contents of this codebook describe the variables of the data set 'TidyData' and outline the data manipulation and transformation steps applied to the original data to achieve this tidy output. Code for the steps taken in creating this data set from the original data can be found in this repository as run_analysis.R

Some of the information provided in this codebook regarding the experiment, variables and observations of the data set have been sourced from documentation included with the data set. 

For more information on the project background and data used, see the readme.md file included in this repository.


### **Table of Contents**

1. The Original Data Set
2. Data Transformations & Tidying
3. TidyData Summary
4. TidyData Variables


### **1. The Original Data Set**

This project uses data from the 'Human Activity Recognition Using Smartphones' data set. A full description of this data and a link to download the data can be found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data in this study has been obtained from 30 volunteers using a Samsung Galaxy S smartphone, while performing each of six different activities (walking, walking upstairs, walking downstairs, sitting, standing and laying). 3-axial linear acceleration and angular velocity measurements were taken using the smartphone's embedded accelerometer and gyroscope. These measurements were then processed and filtered to produce a vector of features which were calculated using variables from the time and frequency domains. 

The data set was randomly partitioned into two sets, where 70% of the volunteers (21) were selected for generating training data, and 30% (9) were used to generate the test data.


### **2. Data Transformations & Tidying**

**1. Downloading, unzipping, reading the data into R:** 

The original data set was downloaded and the relevant files were read into R using the function read.table() and assigned to named objects:

  * features : a 561x2 data frame containing the names of the features for which measurements had been taken

  * subject_train : a 7352x1 data frame containing the unique identifiers for the 21 volunteers from whom the training data had been obtained

  * x_train : a 7352x561 data frame containing the measurements obtained for each of the features; this data represented the training group

  * y_train : a 7352x1 data frame containing integers representing the various activities performed by the volunteers in the training group

  * subject_test : a 2947x1 data frame containing the unique identifiers for the 9 volunteers from whom the test data had been obtained

  * x_test : a 2947x561 data frame containing the measurements obtained for each of the features; this data represented the test group

  * y_test : a 2947x1 data frame containing integers representing the various activities performed by the volunteers in the test group
  
###  
  
**2. Becoming familiar with the data:** 

For each of these objects, common characteristics were determined including:
  * dim() - dimensions; for number of rows and columns
  
  * str() - structure; for an overview of the variables contained in the data set and their classes
  
  * head() - to view the first few rows of data
  
  * names() - to determine what, if any, names were assigned to variables
  
  * unique() - to determine the number of unique elements

###

**3. Descriptive variable names for the data set:** 

From the previous step, it was found that for each of the data sets (test and training data), the data had been divided into separate files containing the identifiers for volunteers, the activities performed, and the values corresponding to measurements taken for the features. It was also found that the variable names for each of these sets of data were compiled in separate files. To address this, descriptive variable names were attached to these data.
        
The column containing descriptive labels found in 'features' was extracted and assigned to an object called feat_labels. feat_labels was then assigned as variable names to x_test and y_test using the function colnames().
        
  * feat_labels : a subset of 'features" containing the descriptive variable names for feature measurements
        
The variable containing volunteer identifiers in each of the dataframes subject_test and subject_train was then renamed 'ID', for identifier. This was done using the rename() function.
        
The variable containing integers representing the activities performed in each of y_test and y_train was also renamed using the function rename() to 'Activity'
        
All the variables now have desciptive names which would allow for easier manipulation.

###       
        
**4. Collating test and train data:** 

Since the variables were stored in different files, the data then needed to be collated, first into test data (the data corresponding to 9 volunteers) and training data (the data corresponding to 21 volunteers).
        
To collate the test data, the function cbind() was used to clip the variables for ID, Activity, and Feature measurements together. The result was assigned to an object called TestData.
        
  * TestData : a data frame of 2947 observations and 563 variables, including labelled variables for ID, Activity and feature measurements
        
To collate the training data, the function cbind() was again used to clip variables for ID, Activity and feature measurements together. The result was assigned to an object called TrainData.
        
  * TrainData : a data frame of 7352 observations and 563 variables, including labelled variables for ID, Activity and feature measurements.

###        
        
**5. Merging the Test and Train data sets:**

To obtain a full data set which contained both test and training data observations, TestData and TrainData were combined using the function rbind(). The result was stored in an object called FeaturesData, since it contained all the data for the feature measurements.
        
  * FeaturesData: a data frame of 10299 observations and 563 variables, containing feature measurements data for all the volunteers.

###        
        
**6. Extracting the mean and standard deviation measurements:** 

To extract measurements on only mean and standard deviation for each of the measurements, the select() function of the 'dplyr' package was used to extract ID, Activity, and only those columns whose names contained 'mean()" or "std()". The resulting data was stored in an object called FeaturesMS, to represent Features-Mean-Standard Deviation.
        
  * FeaturesMS : a data frame of 10299 observations and 68 variables, containing data for ID, Activity, and only the measurements on mean and standard deviation for each of the measurements.

###        
         
**7.  Descriptive 'Activity' names:**

Since this subsetted data contained all the feature measurements of interest, the next step was clarifying the data in the other columns. The variable 'ID' contained 30 unique elements corresponding to each of the volunteers who participated, however, the variable 'Activity' contained integers 1:6 which corresponded to the activities performed by the volunteers. 

To make these more descriptive, each of the integers was replaced by a descriptive name for the activity. To do this,  the file "activity_labels.txt" was read into R using read.table() and assigned to the object activity_labels. Since the variable contained integers, the function as.character() was used to overwrite the integers with the descriptive names provided in activity_labels.
         
  * activity_labels : a data frame of 6 observations and 2 variables which provided the descriptive names for each activity and its corresponding integer

###         
         
**8.  Tidying variable names:**

Although descriptive variable names were assigned to the features measurements in an earlier step, using data from the file "features.txt", the names required tidying as there were a number of abbreviations and special characters. The variable names were 'tidied' using guidelines provided in the lecture "Editing text variables" by Jeffrey Leek:
         
  "Names of variables should be:
  
  a. all lowercase when possible
  
  b. descriptive (Diagnosis vs Dx)
  
  c. not duplicated
  
  d. not have underscores or dots or white spaces"
                

Using this guide, the function gsub() was used to remove parentheses, hyphens, underscores, duplicated names, and replace abbreviated attributes with descriptive names. Since the names comprised several different attributes, CamelCase was used to distinguish each, that is, each attribute name began with a capital letter. gsub() was applied to the data set FeaturesMS using the names() function and the results were reassigned to names(FeaturesMS).
        
###

**9. Tidy data set:** 

The final step in tidying the data was grouping the data by ID and Activity. Several measurements were obtained for each volunteer for each of the activities performed. To summarise this, the mean of each of these measurements for the activities performed by each volunteer was deduced by applying the functions group_by() and summarise_all() sequentially. The result was stored in an object called 'TidyData' as the final tidy data set.
        
  * TidyData : a data frame of 180 observations and 68 variables, containing the mean for each of the measurements taken during each activity performed by each volunteer.
        
To ensure the data was tidy, the three rules of tidy data by Hadley Wickham were referenced. It was ensured that:

  1. Each variable had its own column
  
  2. Each observation had its own row
  
  3. Each value had its own cell
                
TidyData was then saved as a text file using the function write.table()
        
###        

### **3. TidyData Summary**

  * Dimensions: 180 rows; 68 columns
        
  * Class: A grouped data frame
  
  * Size: 109.3 KB
        
###

### **4. TidyData Variables**

- Col 1  : ID : Subject/Volunteer identifier ; 1:30
            

- Col 2  : Activity

Activity performed
  
  1. Walking
  
  2. Walking_Upstairs
  
  3. Walking_Downstairs
  
  4. Sitting
  
  5. Standing
  
  6. Laying


- Col 3:68  :  

  The measurements in this data set were 3-axial raw signals obtained from the 
  accelerometer and gyroscope. These signals are time domain and captured 
  at a constant rate of 50Hz. The acceleration signal was then separated into           body and gravity acceleration signals (TimeBodyAcceleration-XYZ and
  TimeGravityAcceleration-XYZ). 
        
  Body linear acceleration and angular velocity were then used to obtain Jerk 
  signals (TimeBodyAccelerometerJerk-XYz and TimeBodyGyroscopeJerk-XYZ)
        
  The magnitude of these three-dimenstional signals were then calculated using          the Euclidean norm (TBodyAccelerometerMagnitude, TGravityAccelerometerMagnitude, 
  TBodyAccelerometerJerkMagnitude, TBodyGyroscopeMagnitude and
  TBodyGyroscopeJerkMagnitude).
        
  A Fast Fourier Transform was then applied to some of these signals producing
  FrequencyBodyAccelerometer-XYZ, FrequencyBodyAccelerometerJerk-XYZ,
  FrequencyBodyGyroscope-XYZ, FrequencyBodyAccelerometerJerkMagnitude,
  FrequencyBodyGyroscopeMagnitude and FrequencyBodyGyroscopeJerkMagnitude.
        
  For each of these measurements, the mean and standard deviations were estimated.
  
        
- Col 3  : TimeBodyAccelerometerMeanX : Time-Body-Accelerometer-Mean - X

- Col 4  : TimeBodyAccelerometerMeanY : Time Body Accelerometer Mean - Y

- Col 5  : TimeBodyAccelerometerMeanZ : Time Body Accelerometer Mean - Z
            
- Col 6  : TimeGravityAccelerometerMeanX : Time Gravity Accelerometer Mean - X
            
- Col 7  : TimeGravityAccelerometerMeanY : Time Gravity Accelerometer Mean - Y
            
- Col 8  : TimeGravityAccelerometerMeanZ : Time Gravity Accelerometer Mean - Z
            
- Col 9  : TimeBodyAccelerometerJerkMeanX : Time Body Accelerometer Jerk Mean - X
            
- Col 10 : TimeBodyAccelerometerJerkMeanY : Time Body Accelerometer Jerk Mean - Y
            
- Col 11 : TimeBodyAccelerometerJerkMeanZ : Time Body Accelerometer Jerk Mean - Z
            
- Col 12 : TimeBodyGyroscopeMeanX : Time Body Gyroscope Mean - X
            
- Col 13 : TimeBodyGyroscopeMeanY : Time Body Gyroscope Mean - Y
            
- Col 14 :  TimeBodyGyroscopeMeanZ : Time Body Gyroscope Mean - Z
            
- Col 15 :  TimeBodyGyroscopeJerkMeanX : Time Body Gyroscope Jerk Mean - X
            
- Col 16 :  TimeBodyGyroscopeJerkMeanY : Time Body Gyroscope Jerk Mean - Y
            
- Col 17 :  TimeBodyGyroscopeJerkMeanZ : Time Body Gyroscope Jerk Mean Z
            
- Col 18 :  TimeBodyAccelerometerMagnitudeMean : Time Body Accelerometer Magnitude Mean
            
- Col 19 :  TimeGravityAccelerometerMagnitudeMean : Time Gravity Accelerometer Magnitude Mean
            
- Col 20 :  TimeBodyAccelerometerJerkMagnitudeMean : Time Body Accelerometer Jerk Magnitude Mean
            
- Col 21 :  TimeBodyGyroscopeMagnitudeMean : Time Body Gyroscope Magnitude Mean
            
- Col 22 :  TimeBodyGyroscopeJerkMagnitudeMean : Time Body Gyroscope Jerk Magnitude Mean
            
- Col 23 :  FrequencyBodyAccelerometerMeanX : Frequency Body Accelerometer Mean - X
            
- Col 24 :  FrequencyBodyAccelerometerMeanY : Frequency Body Accelerometer Mean - Y
            
- Col 25 :  FrequencyBodyAccelerometerMeanZ : Frequency Body Accelerometer Mean Z
            
- Col 26 :  FrequencyBodyAccelerometerJerkMeanX : Frequency Body Accelerometer Jerk Mean - X
            
- Col 27 :  FrequencyBodyAccelerometerJerkMeanY : Frequency Body Accelerometer Jerk Mean - Y

- Col 28 :  FrequencyBodyAccelerometerJerkMeanZ : Frequency Body Accelerometer Jerk Mean - Z
            
- Col 29 :  FrequencyBodyGyroscopeMeanX : Frequency Body Gyroscope Mean - X
            
- Col 30 :  FrequencyBodyGyroscopeMeanY : Frequency Body Gyroscope Mean - Y
            
- Col 31 :  FrequencyBodyGyroscopeMeanZ : Frequency Body Gyroscope Mean - Z
            
- Col 32 :  FrequencyBodyAccelerometerMagnitudeMean : Frequency Body Accelerometer Magnitude Mean
            
- Col 33 :  FrequencyBodyAccelerometerJerkMagnitudeMean : Frequency Body Accelerometer Jerk Magnitude Mean
            
- Col 34 :  FrequencyBodyGyroscopeMagnitudeMean : Frequency Body Gyroscope Magnitude Mean
            
- Col 35 :  FrequencyBodyGyroscopeJerkMagnitudeMean : Frequency Body Gyroscope Jerk Magnitude Mean
            
- Col 36 :  TimeBodyAccelerometerStdX : Time Body Accelerometer Standard Deviation - X
            
- Col 37 :  TimeBodyAccelerometerStdY : Time Body Accelerometer Standard Deviation - Y
            
- Col 38 :  TimeBodyAccelerometerStdZ : Time Body Accelerometer Standard Deviation - Z
            
- Col 39 :  TimeGravityAccelerometerStdX : Time Gravity Accelerometer Standard Deviation - X
            
- Col 40 :  TimeGravityAccelerometerStdY : Time Gravity Accelerometer Standard Deviation - Y
            
- Col 41 :  TimeGravityAccelerometerStdZ : Time Gravity Accelerometer Standard Deviation - Z
            
- Col 42 :  TimeBodyAccelerometerJerkStdX : Time Body Accelerometer Jerk Standard Deviation - X
            
- Col 43 :  TimeBodyAccelerometerJerkStdY : Time Body Accelerometer Jerk Standard Deviation - Y
            
- Col 44 :  TimeBodyAccelerometerJerkStdZ : Time Body Accelerometer Jerk Standard Deviation - Z
            
- Col 45 :  TimeBodyGyroscopeStdX : Time Body Gyroscope Standard Deviation - X
            
- Col 46 :  TimeBodyGyroscopeStdY : Time Body Gyroscope Standard Deviation - Y
            
- Col 47 :  TimeBodyGyroscopeStdZ : Time Body Gyroscope Standard Deviation - Z
            
- Col 48 :  TimeBodyGyroscopeJerkStdX : Time Body Gyroscope Jerk Standard Deviation - X
            
- Col 49 :  TimeBodyGyroscopeJerkStdY : Time Body Gyroscope Jerk Standard Deviation - Y
            
- Col 50 :  TimeBodyGyroscopeJerkStdZ : Time Body Gyroscope Jerk Standard Deviation - Z
            
- Col 51 :  TimeBodyAccelerometerMagnitudeStd : Time Body Accelerometer Magnitude Standard Deviation
            
- Col 52 :  TimeGravityAccelerometerMagnitudeStd : Time Gravity Accelerometer Magnitude Standard Deviation
            
- Col 53 :  TimeBodyAccelerometerJerkMagnitudeStd : Time Body Accelerometer Jerk Magnitude Standard Deviation
            
- Col 54 :  TimeBodyGyroscopeMagnitudeStd : Time Body Gyroscope Magnitude Standard Deviation
            
- Col 55 :  TimeBodyGyroscopeJerkMagnitudeStd : Time Body Gyroscope Jerk Magnitude Standard Deviation
            
- Col 56 :  FrequencyBodyAccelerometerStdX : Frequency Body Accelerometer Standard Deviation - X
            
- Col 57 :  FrequencyBodyAccelerometerStdY : Frequency Body Accelerometer Standard Deviation - Y
            
- Col 58 :  FrequencyBodyAccelerometerStdZ : Frequency Body Accelerometer Standard Deviation - Z
            
- Col 59 :  FrequencyBodyAccelerometerJerkStdX : Frequency Body Accelerometer Jerk Std - X
            
- Col 60 :  FrequencyBodyAccelerometerJerkStdY : Frequency Body Accelerometer Jerk Standard Deviation Y
            
- Col 61 :  FrequencyBodyAccelerometerJerkStdZ : Frequency Body Accelerometer Jerk Standard Deviation - Z
            
- Col 62 :  FrequencyBodyGyroscopeStdX : Frequency Body Gyroscope Standard Deviation - X
            
- Col 63 :  FrequencyBodyGyroscopeStdY : Frequency Body Gyroscope Standard Deviation - Y
            
- Col 64 :  FrequencyBodyGyroscopeStdZ : Frequency Body Gyroscope Standard Deviation - Z
            
- Col 65 :  FrequencyBodyAccelerometerMagnitudeStd : Frequency Body Accelerometer Magnitude Standard Deviation
            
- Col 66 :  FrequencyBodyAccelerometerJerkMagnitudeStd : Frequency Body Accelerometer Jerk Magnitude Standard Deviation
            
- Col 67 :  FrequencyBodyGyroscopeMagnitudeStd : Frequency Body Gyroscope Magnitude Standard Deviation
            
- Col 68 :  FrequencyBodyGyroscopeJerkMagnitudeStd : Frequency Body Gyroscope Jerk Magnitude Standard Deviation
            
        
### **References**

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


Grolemund, Garrett, and Hadley Wickham. R for Data Science. O’Reilly Media, 2017.
https://r4ds.hadley.nz/data-tidy.html


Leek, Jeffrey. Editing Text Variables [Coursera Lecture]. In Jeffrey Leek, Roger D. Peng, Brian Caffo: Getting and Cleaning Data by John Hopkins University. (Retrieved march 2022).
https://www.coursera.org/learn/data-cleaning/home/info










            
          
            
