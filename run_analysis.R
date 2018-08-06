##This script is based on the following implementation:
##1. Merges the training and the test sets to create one data set.
##2. Extracts only the measurements on the mean and standard deviation for each measurement.
##3. Uses descriptive activity names to name the activities in the data set
##4. Appropriately labels the data set with descriptive variable names.
##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#required package
library(dplyr)

##load txt data in memory as data.frames
trainingsubject<-tbl_df(read.table("train/subject_train.txt"))
trainingset<-tbl_df(read.table("train/X_train.txt"))
traininglabels<-tbl_df(read.table("train/y_train.txt"))
testsubject<-tbl_df(read.table("test/subject_test.txt"))
testset<-tbl_df(read.table("test/X_test.txt"))
testlabels<-tbl_df(read.table("test/y_test.txt"))
activitylabels<-tbl_df(read.table("activity_labels.txt"))
features <-tbl_df(read.table("features.txt"))

#describe test activity
testlabels2 <-inner_join(testlabels, activitylabels, by="V1")
#combine test data
testDF <- cbind(testsubject,testlabels2$V2,testset)

#describe training activity
traininglabels2 <-inner_join(traininglabels, activitylabels, by="V1")
#combine training data
trainingDF <- cbind(trainingsubject,traininglabels2$V2, trainingset)

#label col variables appropriately 
names(testDF) <- c("Subject", "Activity", as.character(features$V2))
names(trainingDF) <- c("Subject", "Activity", as.character(features$V2))

#combine test data and training data
DF <- rbind(trainingDF, testDF)

#clean workspace
rm(list=setdiff(ls(), c("DF", "activitylabels")))

#Extracts the measurements on the mean and standard deviation
DF<-DF[,grep("Subject|Activity|mean\\(\\)|std\\(\\)", colnames(DF))]

#Construct tidy data set
tidyset = c()

#split relevant rows and calculate mean
for (subjectID in 1:30){
        subjectdata <- DF[DF$Subject == subjectID,]
        for (action in activitylabels$V2){
                row <- c(subjectID, as.character(action), colMeans(subjectdata[subjectdata$Activity == action,3:68]))
                tidyset <- rbind(tidyset, row)
        }
}

#fix lost column names from split
colnames(tidyset)[1] <- "Subject"
colnames(tidyset)[2] <- "Activity"

#clean workspace
rm(list=setdiff(ls(), "tidyset"))

#write to file
write.table(tidyset, "TidyData.txt", row.name=FALSE)
