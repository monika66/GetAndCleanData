#############################################################################
## Coursera: Data Science Specialisation
## Course 3: Getting and Cleaning Data
## Peer-graded Assignment: Getting and Cleaning Data Course Project
## Student: Monika Hunkeler
##################################################################################
## The R script "run_analysis.R" tidies and analysis Human-activity-data 
## sampled by the accelerometers from the Samsung Galaxy S smartphone.
## The used data sets are downloaded from the UCI machine learning repository
## ###############################################################################

## Loading needed packages
library(readr)
library(dplyr)
library(tidyr)

##  Assignment: 1. Merges the training and the test data sets to create one data set.
##  
##  The observation data are randomized splitted in: 70% training : 30% test data, 
##  stored in the files "X-train.txt" and "X-test.txt"
##
##  The observation data sets are splitted in 3 files:
##      1.) X-train.txt / X-train.txt containing the measured data
##      2.) subject_train.txt  containing for each observation of the training or test data 
##          the participating "subject" (human) as an ID
##      3.) y_train.txt containing for each observation of the training or test data 
##          the "activity" as an ID
##           
##   Tidy data: 
##      1.) To bring all data of an observation together in one row, the columns of the 3 files 
##      for each of the 2 data set (training, test) are combined in a training and test data frame.
##      2.) The rows of the splitted training and test data frames are combined in one data frame.
        xTraining <- read.table("./UCI HAR Dataset/train/X_train.txt")
        sTraining <- read.table("./UCI HAR Dataset/train/subject_train.txt")
        yTraining <- read.table("./UCI HAR Dataset/train/y_train.txt")
        xTraining <- cbind(xTraining, sTraining) # Add column with subject id
        xTraining <- cbind(xTraining, yTraining) # Add column with activity id

        xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
        sTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
        xTest <- cbind(xTest, sTest) # Add column with subject id
        xTest <- cbind(xTest, yTest) # Add column with activity id

        allXData <- rbind(xTraining, xTest)

## Assignment: 2. Extracts only the measurements on the mean and standard deviation for 
##                each measurement. 
##
##  Tidy data: 
##      The help file "features.txt" contains the variable names and as key the column id 
##      of the measurements. The variable names of the raw data includes the name of 
##      the arithmetic operations.  Extraction of all mean() or std() measurements.
##      Angle variables were not extracted because this is another kind of mean.
        
        features <- read.table("./features.txt")
        ## reading the column id number from features for each variable containing mean() or std()       
        colMean <- grep("mean()", features[,2], fixed = TRUE) 
        colStd <- grep("std()", features[,2], fixed = TRUE)
        ## extracting columns by column id numbers from colMean or colStd
        subXData <- cbind(allXData[ ,colMean], allXData[ ,colStd])
     

## Assignment: 3. Uses descriptive activity names to name the activities in the data set
##
## Tidy data:
##      Replace the activity number id with descriptive labels from the help file
##      "activity_labels.txt". This makes the data more understandable for humans.

        activityLabels <- read.table("./activity_labels.txt")  
        ## add the activity and subjects columns, equal last two columns of allXData
        subXData <- cbind(subXData, allXData[ , (ncol(allXData) -1): ncol(allXData)])
        subXData[ , ncol(subXData)] <- activityLabels[subXData[ , ncol(subXData)], 2]

## Assignment: 4. Appropriately labels the data set with descriptive variable names. 
##
## Tidy data:
##      Replace the R column names of "subXData" data frame by the measurement variable names 
##      from "features"

        ## Extract the column number from the subXData R column names
        colNumber <- parse_number(names(subXData))
        ## read and tidies the variable names
        colNames <- features[colNumber,2]
        colNames <- gsub("-", "", colNames)
        names(subXData) <- colNames
        names(subXData)[ncol(subXData) -1] <- "subject"
        names(subXData)[ncol(subXData)] <- "activity"

## Assignment: 5. From the data set in step 4, creates a second, independent tidy data set 
##             with the average of each variable for each activity and each subject.
##
## Tidy data:
##      The datas are grouped for each activity and subject combination and the average 
##      calculated by mean for every group and measure variable. 
##      The average variables are all in one column and has all a new unique name.

        ## Variables gathered and grouped for average calculation
        avXData <- gather(subXData, subject, activity)
        names(avXData)[3] <- "varName" ## temporay variable for the gathered data
        names(avXData)[4] <- "varMeasure"    ## temporay variable for the gathered data
        avXData <- summarise(group_by(avXData, varName, activity, subject), mean(varMeasure, na.rm = FALSE))
        ## Rename calculated variable and spread every variable in one column
        names(avXData)[4] <- "average"
        avXData <- spread(avXData, varName, average)
        ## Rename all columns containing the new group average.
        colNames <- names(avXData)
        colMax <- ncol(avXData)
        colNames <- paste(colNames[3:colMax], "mean", sep ="")
        names(avXData)[3:colMax] <- colNames
        
        ## Store the resulting tidy data in files and print the result to the R console
        if(!file.exists("./data")){dir.create("./data")}     ## create directory /data 
        file.create("./data/tidy_XData.txt")
        file.create("./data/tidy_avXData.txt")
        write.table(subXData, "./data/tidy_XData.txt", row.name=FALSE)
        write.table(avXData, "./data/tidy_avXData.txt", row.name=FALSE)
        print(avXData)



