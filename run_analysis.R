##COURSE PROJECT

#Package required
if (!require("data.table")) {install.packages("data.table")}
require(data.table)

#Download file
if(!file.exists("./data")){dir.create("./data")}
URLzip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URLzip,destfile="./data/UCI-HAR-Dataset.zip")

#Unzip downloaded file
unzip(zipfile="./data/UCI-HAR-Dataset.zip",exdir="./data")


##1.Merges the training and the test sets to create one data set.

#Read Tests sets
TestSet <- read.table("./data/UCI HAR Dataset/test/X_test.txt",header=FALSE)
TestLabels <- read.table("./data/UCI HAR Dataset/test/y_test.txt",header=FALSE)
TestSubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header=FALSE)

#Read Training sets
TrainingSet <- read.table("./data/UCI HAR Dataset/train/X_train.txt",header=FALSE)
TrainingLabels <- read.table("./data/UCI HAR Dataset/train/y_train.txt",header=FALSE)
TrainingSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header=FALSE)

#For each kind of BD... merge training and test data
dataSet <- rbind(TrainingSet, TestSet)
dataLabels <- rbind(TrainingLabels, TestLabels)
dataSubjects <- rbind(TrainingSubjects, TestSubjects)

#Labels
features <- read.table("./data/UCI HAR Dataset/features.txt")
names(dataSet) <- features[,2]
colnames(dataLabels) <- "Activity"
colnames(dataSubjects) <- "Subject"

#Merge all files
dataAll <- cbind(dataSubjects, dataLabels, dataSet)


##2.Extracts only the measurements on the mean and standard deviation for each 
#measurement.

#Select the columns with the names mean or std
VarMeanOrStd <- grep(".*mean.*|.*std.*", names(dataAll), ignore.case=TRUE)
SelColumns <- c(1,2,VarMeanOrStd)

#New BD with the columns selected
dataAllsubset <- dataAll[,SelColumns]


##3.Uses descriptive activity names to name the activities in the data set

#Activiy names
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

#Recode
dataAllsubset$Activity <- as.character(dataAllsubset$Activity)
for (i in 1:6){
    dataAllsubset$Activity[dataAllsubset$Activity == i] <- as.character(activityLabels[i,2])
}
dataAllsubset$Activity <- as.factor(dataAllsubset$Activity)


##4.Appropriately labels the data set with descriptive variable names.
names(dataAllsubset)

#Change labels
names(dataAllsubset)<-gsub("-mean()", "Mean", names(dataAllsubset), ignore.case = TRUE)
names(dataAllsubset)<-gsub("-std()", "STD", names(dataAllsubset), ignore.case = TRUE)
names(dataAllsubset)<-gsub("^t", "Time", names(dataAllsubset))
names(dataAllsubset)<-gsub("^f", "Frequency", names(dataAllsubset))
names(dataAllsubset)<-gsub("Acc", "Accelerometer", names(dataAllsubset))
names(dataAllsubset)<-gsub("Gyro", "Gyroscope", names(dataAllsubset))
names(dataAllsubset)<-gsub("Mag", "Magnitude", names(dataAllsubset))
names(dataAllsubset)<-gsub("-freq()", "Frequency", names(dataAllsubset), ignore.case = TRUE)
names(dataAllsubset)<-gsub("gravity", "Gravity", names(dataAllsubset))

names(dataAllsubset)

##5.From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

dataAllsubset$Subject <- as.factor(dataAllsubset$Subject)
dataAllsubset <- data.table(dataAllsubset)

dataAllsubset2 <- aggregate(. ~Subject + Activity, dataAllsubset, mean)
dataAllsubset2 <- dataAllsubset[order(dataAllsubset2$Subject,dataAllsubset2$Activity),]
write.table(dataAllsubset2, file = "TidyData.txt", row.names = FALSE)
