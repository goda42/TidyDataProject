## This script will import the raw data, select the means and
## standard deviations of measures, tidy the data and create a
## new dataset with the clean data

## Created 2/14/2018
## Chris M.

#Dependencies
library(readr)
library(tools)

#This function loads the data into memory for cleaning, can be sent args for
#directories if file tree is different
loadRaw<-function(rootDir="./UCI HAR Dataset/",testDir="test/",trainDir="train/") {
  activity<-read.csv(paste(rootDir,"activity_labels.txt",sep=""),sep=" ",header=F)
  activity<-toTitleCase(tolower(sub("_"," ",activity[,2])))
  
  testSubject<-read.csv(paste(rootDir,testDir,"subject_test.txt",sep=""),header=F)
  trainSubject<-read.csv(paste(rootDir,trainDir,"subject_train.txt",sep=""),header=F)
  names(testSubject)<-"Subject"
  names(trainSubject)<-"Subject"
  
  widths<-rep(c(-1,15),561)
  
  suppressMessages(testXRaw<-read.fwf(paste(rootDir,testDir,"X_test.txt",sep=""),widths))
  suppressMessages(trainXRaw<-read.fwf(paste(rootDir,trainDir,"X_train.txt",sep=""),widths))

  testLabels<-read.csv(paste(rootDir,testDir,"y_test.txt",sep=""),header=F)
  trainLabels<-read.csv(paste(rootDir,trainDir,"y_train.txt",sep=""),header=F)
  names(testLabels)<-"Activity"
  names(trainLabels)<-"Activity"
  
  features<-read.csv(paste(rootDir,"features.txt",sep=""),sep=" ",header=F)
  
  means<-grep("mean",features[,2])
  stds<-grep("std",features[,2])
  cols<-sort(c(means,stds))
  colNames<-features[cols,2]
  testX<-testXRaw[,cols]
  trainX<-trainXRaw[,cols]
  
  names(testX)<-colNames
  names(trainX)<-colNames
  
  test<-cbind(testSubject,testLabels,testX)
  train<-cbind(trainSubject,trainLabels,trainX)
  
  allData<-arrange(rbind(test,train),Subject,Activity)
  
  for(i in 1:6) {
    allData[allData[,2]==i,2]<-activity[i]
  }
  
  nameVec<-names(allData)
  
  nameVec<-sub("^f","FFT ",nameVec)
  nameVec<-sub("^t","Time ",nameVec)
  
  names(allData)<-nameVec
  
  tidyData<-summarize_all(group_by(allData,Subject,Activity),mean)
  
  assign("allData",allData,envir = .GlobalEnv)
  assign("tidyData",tidyData,envir = .GlobalEnv)
}

#Main
loadRaw()