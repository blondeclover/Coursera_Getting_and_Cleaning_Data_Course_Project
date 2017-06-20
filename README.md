## Getting and Cleaning Data: Course Project
The purpose of this project is to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.
## Data
30 subjects performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone (Samsung Galaxy S II) on their waist. Researchers collected data from the smartphone accelerometers and calculated various measurements. The full description is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).    
Data was separated into a training set and a test set. For the purpose of this course, only the measurements on the mean and standard deviation for each measurement were extracted from each set. 
## Analysis
The R script `run_analysis.R` does the following:  
1. Downloads and unzips the dataset, if it does not already exist in the working directory
2. Identifies columns that contain the measurements on the mean or standard deviation for each measurement
3. Reads in train/test set columns that contain the mean or standard deviation and names columns appropriately
4. Adds columns with subject identifier (`Subject`), activity labels (`Label`), and from which set the data was obtained (`Set`)
5. Binds the train and test data together
6. Adds descriptive activity labels (`Activity`)
7. Calculates the average of each variable for each activity and subject
8. Writes out the dataset created in step 7 (`variable_averages.txt`).  

The `data.table` and `dplyr` packages are required to run this script.
## Files
`CodeBook.md` describes the variables in each dataset.
`run_analysis.R` contains the code used to tidy the data.
`variable_averages.txt` is the tidy dataset containing the average of each variable for each activity and subject.
