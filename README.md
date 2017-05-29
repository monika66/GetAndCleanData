README.md:    Describes step-by-step how to analys the raw data from UCI study "Human activities recognized by Smartphones",
              according to the expected results of the peer graded assignment project "Getting and cleaning data"
                          
Course:       Getting and cleaning data, Coursera Data Science
Assignment:   Peer graded project Assignment, week 4
Student:      Monika Hunkeler
Date: 28. of May 2017

Instruction list:
1.) Read the Instructions from the Peer Grade Assignment 
2.) Read the background information on http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
3.) Use R and setwd() to set your work directory ./Desktop/coursera 
4.) Create with R a new directory for your project in your ./Desktop/coursera directory
    if(!file.exists("./Assignment_3_4")){dir.create("./Assignment_3_4")}
5.) Download the zipped project data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
    to your project directory ./Assignment_3_4
    
6.) Enzip the order /UCI HAR Dataset to your project directory /Assignment_3_4
7.) The directory ./Assignment_3_4/UCI HAR Dataset should now contain the following orders and files:
    1. as explaining files:
    'README.txt' explains how files fit together
    'features_info.txt': Shows information about the variables used on the feature vector.
    'features.txt': List of all features.
    'activity_labels.txt': Links the class labels with their activity name.
    
    2. as data set 'train' files:
    'train/X_train.txt': Training set.
    'train/y_train.txt': Training labels.
    'train/subject_train.txt':  Links the subjects (humans) with the observation.
    
    3. as data set'test' files:
    'test/X_test.txt': Test set.
    'test/y_test.txt': Test labels.
    'train/subject_test.txt':  Links the subjects (humans) with the observation.
    
     Hint: the order 'Inertial Signals' and his files are not used for this project work.
     
     Hint: Each feature vector is a row on the data file.
     
     Hint: there are 2 data sets: 'train' and 'test'. The original data set was randomized splitted 70% and 30% 
           to the two data sets. In this project we bring all data (rows) back together in one tidy data set.
           
     Hint: the raw data of an observation: mesurement, activity label and subject are splitted to 3 files. In this project 
           we bring all data (columns) of an observation back together in one tidy data set.

     Hint: Read the explaining files and check dim() and names() of the data set in R. 

   4.) The project instruction expects the following steps to tidying the raw datas:
          1. Merges the training and the test sets to create one data set.
          2. Extracts only the measurements on the mean and standard deviation for each measurement. 
          3. Uses descriptive activity names to name the activities in the data set
          4. Appropriately labels the data set with descriptive variable names. 
          5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for 
             each activity and each subject.
      
   5. Source the script 'run_analysis.R'. The script follows the instrucions in step 4.) and prints the resulting tidy data as
      data.frame 'avXData' to the R console. In addition it creates a directory '/data' to your project ordner and stores 
      the resulting tidy data from step 4 as 'subXData.txt' and the tidy data from step 5 as 'avXData.txt' in it. 
      The script will be explained in more details at point 7.)
      
    6.) The resulting file 'avXData.txt' was uploaded to the github repository 
      
      
