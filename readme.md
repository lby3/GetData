#Summary
This file describes how the script run_analysis.R works.  It assumes that you've unzipped the source data file into the working directory,  preserving the directory structure

run_analysis.R has five main segments:

##Loading Variable Names
This section loads and cleans up variable names from ```features.txt``` in the main directory.

1. The script reads the file into a data frame.  
2. It extracts the variable names into a vector and drops the data frame.
3. Finally, it transforms the variable names for readability.

##Loading Activities
This section loads the labels for activities from ```activity_labels.txt``` in the main directory

1. The script reads the activity labels into a data frame.
2. It extracts the activity labels into a vector, relying on the fact that the labels are in order.
3. Finally, it drops the data frame.

##Merge the test and train data sets and extract the right columns
This section loads the ```X_*.txt``` data files in the test and train directories and merges the resulting data frames into a measurements data frame

1. The script calls the function loadMerge() to load the two files and merges them into the measurements data frame using rbind

    ```
    loadMerge<-function(file1,file2)
    {
      dt1<-read.table(file1)
      dt2<-read.table(file2)
      dtOut<-rbind(dt1, dt2)
    }
    ```

    ```dtMerged<-loadMerge("test/X_test.txt", "train/X_train.txt")```

2. Next, the script selects the appropriate columns for mean and standard deviations from the list of column names:
    + Any column with mean or std in the name;
    + EXCLUDING any column with meanFreq in the name.
   
      ```targetCols<-intersect(grep("mean|std", features), grep("meanFreq", features, invert=TRUE))```
  
3. The script then subsets out these columns from the measurements data frame

    ```dtMerged<-dtMerged[,targetCols]```

4. Finally, the script renames the columns in the measurements data frame using the readable variable names
    ```setnames(dtMerged, names(dtMerged), features[targetCols])```

##Merging Subject and Activity
In this section, the script merges the subject and activity datasets with the measurements data frame using cbind

1. Subject dataset 

  + Calls loadMerge to merge the datasets
  
    ```dtSubject<-loadMerge("test/subject_test.txt", "train/subject_train.txt")```
    
  + Renames the column name to a friendly name
  
    ```setnames(dtSubject,names(dtSubject),"Subject")```
    
  + Merges the subject dataset with the measurements data frame
  
    ```dtMerged<-cbind(dtMerged, dtSubject)```
    
2. Activity dataset

  + Calls loadMerge to merge the datasets
  
    ```dtActivity<-loadMerge("test/y_test.txt", "train/y_train.txt")```
    
  + Renames the column name to a friendly name
  
    ```setnames(dtActivity,names(dtActivity),"Activity")```
    
  + Merges the activity dataset with the measurements data frame
  
    ```dtMerged<-cbind(dtMerged, dtActivity)```  
    
  + Replaces the activity rows with their textual names
  
    ```dtMerged$Activity<-sapply(dtMerged$Activity, function(x){activity[x]})```

##Creates a tidy dataset
This section wraps it up by creating a tidy grouped dataset.

1. Creates a tidy dataset using data.table

    ```dtTidy<-dtTidy[, lapply(.SD, mean), by=c("Subject", "Activity")]```
    
2. Orders the dataset

    ```dtTidy<-dtTidy[order(Subject, Activity)]```
    
3. Writes it to a text file

    ```write.table(dtTidy, "tidy.txt", row.names=FALSE)```
