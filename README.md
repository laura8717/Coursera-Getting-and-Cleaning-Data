
==================================================================
Coursera - Getting and Cleaning Data - Course Project - August 2014
==================================================================
Professors:
Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD
==================================================================
The assignment entailed:
 Creating one R script, run_analysis.R, to take data derived from the website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones,
merging both the the training and the test sets into one data set, extracting
measurements on the mean and standard deviation, adding activity names and data labels, and 
finally creating a tidy data set that will be available for further analysis as the need arises.
======================================

The data was separated into testing and training data which both contained the exact same measurements. The files
differed in the number of test subjects for which the data was collected. Additionally, it was necessary to join
files in order to match the test subjects, activities and the data together. The process that was followed is outlined below.
But, first, I have copied from the data's README, the list of files and their contents.
List of Files in the Data set - Text opied from the data set's README file. (Publication - referenced below)
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. 
   Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Procedure to extract and form Tidy Data: 
======
First it was necessary to read in the following data files from the working directory:
X_test.txt, y_test.txt, X_train.txt, y_train.txt, activity_labels.txt, subject_train.txt, subject_test.txt,
and features.txt.

From the features.txt file it was necessary to find the column numbers of all the fields that contain "_std()" and 
"_mean()". This probably brought in a few more fields than necessary as some of the fields did not conform to the
X, Y, or Z direction, but I decided to add that data in case it was needed by someone. If these few extra fields
weren't present, then the tidy data set might be worthless to an individual wishing to analyze these values. I 
appened and sorted the mean and standard deviation column numbers so that I could use this information to extract
all the data I needed from the test and train data. Once I had the information extracted, I labeled the data column
appropriately. Since I did not entirely understand what each field meant, I used the data descrition specified in 
the original data as my column headers. To further complete the data, I used column bind to bind the subjects, 
the activities, and the data for both the test and train data. Then I bound the test and train data together. Since
the subject and activity were new columns, I needed to give them header titles as well. The data is now complete, but
it is not ordered, so it was necessary to order the data first by subject and then by activity. The data is now in a
form that it can be aggregated by the mean for each column. The ending result is a tidy data set.

License Information:
========
This README file referenced the following: 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

