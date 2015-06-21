library(data.table)

#loads two files and merges the tables.  Does not do errorchecking
#Assumes that the files have the same format and number of columns
loadMerge<-function(file1,file2)
{
  dt1<-read.table(file1)
  dt2<-read.table(file2)
  dtOut<-rbind(dt1, dt2)
}

#features.txt lists all the variable names in the "X_*.txt" files.
#After loading features.txt into a data frame, will clean the variable names
#and then dump the data frame
dtF<-read.table("features.txt")

#set column names to human readable (reduce errors)
setnames(dtF,names(dtF),c("Number","Name"))

#Store the variable names as a vector and delete the data frame to free space
features<-dtF$Name
rm(dtF)

#clean the variable names by replacing - with . and removing ()
features<-sapply(features, function(x){gsub("-",".",x)})
features<-sapply(features, function(x){gsub("\\(\\)","",x)})

#clean up the repeated body body
features<-sapply(features, function(x){gsub("BodyBody","Body",x)})

#rename the names from t/f to time/fourier
features<-sapply(features, function(x){gsub("^t","Time\\.",x)})
features<-sapply(features, function(x){gsub("^f","Frequency\\.",x)})

#rename Acc to accelerometer, Gyro to gyroscope
features<-sapply(features, function(x){gsub("Acc","\\.Accelerometer\\.", x)})
features<-sapply(features, function(x){gsub("Gyro","\\.Gyroscope\\.", x)})

#Separate out the Jerk signals and the Magnitude Signals
features<-sapply(features, function(x){gsub("Jerk","\\.Jerk\\.", x)})
features<-sapply(features, function(x){gsub("Mag","\\.Magnitude\\.", x)})

#now get rid of any repeated dots
features<-sapply(features, function(x){gsub("\\.\\.","\\.", x)})


#activity_labels.txt contains the activities by label and name
dtAL<-read.table("activity_labels.txt")

#set column names to human readable (reduce errors)
setnames(dtAL,names(dtAL),c("Activity","Name"))

#store the activity names as a vector and delete the data frame to free space
#NB - this relies on the activity labels being in order, which they are
activity<-as.character(dtAL$Name)
rm(dtAL)

#merge the test and train data sets (Step 1)
dtMerged<-loadMerge("test/X_test.txt", "train/X_train.txt")

#now extract the mean/std deviation measurements (Step 2)
#Extract the target columns from the features list;
# Target columns are anything with mean or std in their name but
# NOT including meanFreq
targetCols<-intersect(grep("mean|std", features), grep("meanFreq", features, invert=TRUE))
dtMerged<-dtMerged[,targetCols]

#rename the columns to their friendlier names (Step 4)
setnames(dtMerged, names(dtMerged), features[targetCols])

#add and merge the subjects to the merged table
dtSubject<-loadMerge("test/subject_test.txt", "train/subject_train.txt")

#rename to a friendly name
setnames(dtSubject,names(dtSubject),"Subject")

#merge subject with the main data frame
dtMerged<-cbind(dtMerged, dtSubject)
rm(dtSubject)

#merge the activities with the data frame
dtActivity<-loadMerge("test/y_test.txt", "train/y_train.txt")

#rename to a friendly name
setnames(dtActivity,names(dtActivity),"Activity")

#merge activity with the main data frame
dtMerged<-cbind(dtMerged, dtActivity)
rm(dtActivity)

#rename activities to their textual names (Step 3)
dtMerged$Activity<-sapply(dtMerged$Activity, function(x){activity[x]})

#okay, now to create a tidy data set. (Step 5)
#use the built in group functions in data.table to group by
dtTidy<-data.table(dtMerged)
dtTidy<-dtTidy[, lapply(.SD, mean), by=c("Subject", "Activity")]

#order the activities
dtTidy<-dtTidy[order(Subject, Activity)]

#now write the tidy dataset
write.table(dtTidy, "tidy.txt", row.names=FALSE)