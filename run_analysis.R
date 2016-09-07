# make sure these packages are installed
##install.packages("stringr")
##install.packages("dplyr")
#load the packages
library(stringr)
library(plyr) ;library(dplyr)

setwd("//admin-fs1/Users/rwaiters/My Documents/R/RProgamming/Data/UCI_HAR_Dataset/")

feat <- read.table("features.txt",encoding="UTF-8")
act <-read.table("activity_labels.txt",encoding="UTF-8")

# Bring in all the test data
testdata <- read.table("test/Xtest.txt",encoding="UTF-8")
testdata2 <- read.table("test/y_test.txt",encoding="UTF-8")
testsubject <- read.table("test/subject_test.txt")
#colnames(testdata) <- c()


#Bring in all of the training data
traindata <- read.table("train/X_train.txt",encoding="UTF-8")
#colnames(traindata) <- c()
traindata2 <- read.table("train/y_train.txt",encoding="UTF-8")
trainsubject <- read.table("train/subject_train.txt")

#join the data sets
subject_dataset <- rbind(trainsubject,testsubject)
test_train_dataset_x <- rbind(testdata,traindata)
test_train_dataset_y <- rbind(traindata2,testdata2)

# find all of the columns in feat that have mean|std ***you have to escape out the () by \\(\\)***
mean_std <-grep("-(mean|std)\\(\\)", feat[,2])

#create new subset
test_train_dataset_x <- test_train_dataset_x[,mean_std]

#replace column names
names(test_train_dataset_x) <- feat[mean_std,2]

#put correct names on activities
test_train_dataset_y[,1] <- act[test_train_dataset_y[,1],2]

#tidy up activity column name
names(test_train_dataset_y) <- "activity"

#tidy up subject column name
names(subject_dataset) <- "subject"

#allData <- merge(testdata, traindata) does not work
alldata <-cbind(test_train_dataset_x,test_train_dataset_y,subject_dataset)


# step 5 create a new data set that provides averages by activity and subject  UGH
averagesdata <-ddply(alldata, .(subject,activity),function(x) colMeans(x[, 1:66]))
write.table(averagesdata, "averagesdata.txt", row.names = FALSE)
