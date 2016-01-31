# Getting-and-Cleaning-Data-Course-Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
Data collected from the accelerometers from the Samsung Galaxy S smartphone.
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Before start:
* Install packages needed
* Download zip file (from the web page)
* Unzip downloaded file

Step 1. Merges the training and the test sets to create one data set.
* Read the different files (training and tests sets)
* For each kind of databases... merge training and test sets
* Label and merge all de databases

Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
* Select de variable names that include the word "mean" on "std"
* Create a new databases with the selected variables

Step 3. Uses descriptive activity names to name the activities in the data set
* Read the activity names from the file
* Recode the values of the activity variable according to data read

Step 4.	Appropriately labels the data set with descriptive variable names.
* Change the descriptive variable names

5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* Create a tidy set with the average of each variable for each activity and each subject