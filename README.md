# Getting-and-Cleaning-Data-Course-Project

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.

## R Dependency 
install.packages("dplyr")

## To run the Run_analysis.R file
We must set our working directory to the same directory of the unzipped dataset 
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
so that lines 12 through 19 can be read:
```
12> trainingsubject<-tbl_df(read.table("train/subject_train.txt"))
13> trainingset<-tbl_df(read.table("train/X_train.txt"))
14> traininglabels<-tbl_df(read.table("train/y_train.txt"))
15> testsubject<-tbl_df(read.table("test/subject_test.txt"))
16> testset<-tbl_df(read.table("test/X_test.txt"))
17> testlabels<-tbl_df(read.table("test/y_test.txt"))
18> activitylabels<-tbl_df(read.table("activity_labels.txt"))
19> features <-tbl_df(read.table("features.txt"))
```
## Explaination of Run_analysis.R file
1. The script begins by reading all datasets into memory. 
2. lines 22 and 27 assigns the activity labels of the event to the record in their respective datasets.
3. lines 24 and 27 column merges respective datasets while removing redundant column data.
4. lines 32 and 33 assigns column labels to the datasets.
5. line 36 merges all data sets into one.
6. line 39 and 61 clear the workspace of necessary data.
7. line 42 simplifies the dataset by selecting only particular columns and discarding the rest.
8. line 45 creates a temporary variable to store the final result.
9. line 48 to 53 is a nested for loops that selects all unique combinations of the first two columns and then calculates a scalar from the remaining column.
10. line 57 and 58 reassigns column labels lost in the pervious step.
11. line 64 writes the result to local dir.
