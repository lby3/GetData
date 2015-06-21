# Code Book
This file is a code book describing the variables in the tidy dataset for the Coursera Getting and Cleaning Data Course Project.

##Source Data

The source data for the tidy dataset comes from the Human Activity Recognition Using Smartphones Dataset Version 1.0, created by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

The source data comes from a group of 30 volunteers performing six activities wearing a Samsung Galaxy S II smartphone on the waist. The source data measures 3-axial (i.e. X, Y and Z) signals from the smartphone over time, passed through various filters.  Some of the signals were also processed through a Fast Fourier Transform, and so are in denoted as frequency
  

##Data in Tidy Dataset

The tidy dataset contains the average of each mean and standard deviation measurement in the source data set, grouped by each activity and each subject.  The data set is ordered first by subject then by activity, in alphabetical order.

The source data set was transformed by grouping all mean and standard deviation measurements for a subject doing a particular activity, and taking the mean of the values

## Variables

There are 180 observations of 68 variables in the data set.  The first two variables are:

* Subject: Range is 1-30
* Activity: Range is (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

From the combination of these two, we derive 180 observations of the following 66 variables:

* Subject
* Activity
* Time.Body.Accelerometer.mean.X
* Time.Body.Accelerometer.mean.Y
* Time.Body.Accelerometer.mean.Z
* Time.Body.Accelerometer.std.X
* Time.Body.Accelerometer.std.Y
* Time.Body.Accelerometer.std.Z
* Time.Gravity.Accelerometer.mean.X
* Time.Gravity.Accelerometer.mean.Y
* Time.Gravity.Accelerometer.mean.Z
* Time.Gravity.Accelerometer.std.X
* Time.Gravity.Accelerometer.std.Y
* Time.Gravity.Accelerometer.std.Z
* Time.Body.Accelerometer.Jerk.mean.X
* Time.Body.Accelerometer.Jerk.mean.Y
* Time.Body.Accelerometer.Jerk.mean.Z
* Time.Body.Accelerometer.Jerk.std.X
* Time.Body.Accelerometer.Jerk.std.Y
* Time.Body.Accelerometer.Jerk.std.Z
* Time.Body.Gyroscope.mean.X
* Time.Body.Gyroscope.mean.Y
* Time.Body.Gyroscope.mean.Z
* Time.Body.Gyroscope.std.X
* Time.Body.Gyroscope.std.Y
* Time.Body.Gyroscope.std.Z
* Time.Body.Gyroscope.Jerk.mean.X
* Time.Body.Gyroscope.Jerk.mean.Y
* Time.Body.Gyroscope.Jerk.mean.Z
* Time.Body.Gyroscope.Jerk.std.X
* Time.Body.Gyroscope.Jerk.std.Y
* Time.Body.Gyroscope.Jerk.std.Z
* Time.Body.Accelerometer.Magnitude.mean
* Time.Body.Accelerometer.Magnitude.std
* Time.Gravity.Accelerometer.Magnitude.mean
* Time.Gravity.Accelerometer.Magnitude.std
* Time.Body.Accelerometer.Jerk.Magnitude.mean
* Time.Body.Accelerometer.Jerk.Magnitude.std
* Time.Body.Gyroscope.Magnitude.mean
* Time.Body.Gyroscope.Magnitude.std
* Time.Body.Gyroscope.Jerk.Magnitude.mean
* Time.Body.Gyroscope.Jerk.Magnitude.std
* Frequency.Body.Accelerometer.mean.X
* Frequency.Body.Accelerometer.mean.Y
* Frequency.Body.Accelerometer.mean.Z
* Frequency.Body.Accelerometer.std.X
* Frequency.Body.Accelerometer.std.Y
* Frequency.Body.Accelerometer.std.Z
* Frequency.Body.Accelerometer.Jerk.mean.X
* Frequency.Body.Accelerometer.Jerk.mean.Y
* Frequency.Body.Accelerometer.Jerk.mean.Z
* Frequency.Body.Accelerometer.Jerk.std.X
* Frequency.Body.Accelerometer.Jerk.std.Y
* Frequency.Body.Accelerometer.Jerk.std.Z
* Frequency.Body.Gyroscope.mean.X
* Frequency.Body.Gyroscope.mean.Y
* Frequency.Body.Gyroscope.mean.Z
* Frequency.Body.Gyroscope.std.X
* Frequency.Body.Gyroscope.std.Y
* Frequency.Body.Gyroscope.std.Z
* Frequency.Body.Accelerometer.Magnitude.mean
* Frequency.Body.Accelerometer.Magnitude.std
* Frequency.Body.Accelerometer.Jerk.Magnitude.mean
* Frequency.Body.Accelerometer.Jerk.Magnitude.std
* Frequency.Body.Gyroscope.Magnitude.mean
* Frequency.Body.Gyroscope.Magnitude.std
* Frequency.Body.Gyroscope.Jerk.Magnitude.mean
* Frequency.Body.Gyroscope.Jerk.Magnitude.std

The naming convention used above differs from the source data set naming convention by:

* replacing "-" with "."
* deleting all instances of "()"
* deleting repetitions of Body (e.g. BodyBody)
* expanding the opening character "t" to represent the Time domain
* expanding the opening character "f" to represent the Frequency domain
* expanding the abbreviation "Acc" to "Accelerometer"
* expanding the abbreviation "Gyro" to "Gyroscope"
* interposing a dot between Jerk and the next item in the name
* interposing a dot between Magnitude and the next item in the name

