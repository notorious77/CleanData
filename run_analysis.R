##install.packages("stringr")
library(stringr)

setwd("//admin-fs1/Users/rwaiters/My Documents/R/RProgamming/Data/UCI_HAR_Dataset/")
testdata <- readLines("test/Xtest.txt",encoding="UTF-8")
colnames(testdata) <- c()

traindata <- readLines("train/X_train.txt",encoding="UTF-8")
colnames(traindata) <- c()

allTestData <- merge(testdata, traindata)