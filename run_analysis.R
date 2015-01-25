# This function was written as a solution to the project in the Coursera Course "Getting and Cleaning Data"
# It returns a tidy dataset, by reading data from a raw dataset
# The tidy dataset is created as per specifications defined in the problem
# The raw data is obtained from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# The instructions on how the data was collected are provided here:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


run_analysis<-function(){
  
  library(plyr)
  library(dplyr)
    
  activity_labels<-read.table("./activity_labels.txt")
  
  features<-read.table("./features.txt")
  
  
  #reading the Training dataset into three data frames
  training_data<- read.table("./train/X_train.txt")
  training_subject<-read.table("./train/subject_train.txt")
  training_activity<-read.table("./train/y_train.txt")
  colnames(training_data)<-as.character(features[,2]) 
  
  #Merging the three data frames into one master Training data frame
  training_data$subject_mean<-training_subject$V1
  training_data$activity_mean<-training_activity$V1
  
  
  
  
  #reading the Test dataset into three data frames
  test_data<- read.table("./test/X_test.txt")
  test_subject<- read.table("./test/subject_test.txt")
  test_activity<- read.table("./test/y_test.txt")
  colnames(test_data)<-as.character(features[,2])  
    
  #Merging the three data frames into one master Test data frame
  test_data$subject_mean<-test_subject$V1
  test_data$activity_mean<-test_activity$V1
  
  
  
  #Merging the Training and Test data frames to create one master Dataframe
  Data<-rbind(training_data,test_data)
    
  
  colnames(Data)<-make.names(colnames(Data), unique=TRUE)
  
  #Select only the measurements that are either MEAN or STD
  Data1<-select(Data,(contains("mean")))
  Data2<-select(Data,(contains("std")))
  Data3<-list(Data1,Data2)
  Data<-join_all(Data3)
  
  
  # Iterating over the Master data frame to only have one entry per Subject/Activity pair by performing colMeans on the duplicate entries
  
  tidy<-data.frame()
  
  for (i in (1:30)){
    for (j in (1:6)){
      s<-filter(Data, (subject_mean==i & activity_mean==j))
      tidy<-rbind(tidy,colMeans(s,na.rm=T))
            
    }
    
  }
  colnames(tidy)<-colnames(Data)
  tidy$activity_mean<-factor(tidy$activity_mean,labels=as.character(activity_labels[,2]))
  
  
  # Providing the columns of the Tidy data set with meaningful names
  colnames(tidy)[87]<-"Subject"
  colnames(tidy)[88]<-"Activity performed"
  
  tidy<-tidy[,c(87:88,1:86)]
  colnames(tidy)<-gsub(pattern="fBody",replacement="fBody ",colnames(tidy),fixed=F,perl=T)
  colnames(tidy)<-gsub(pattern="tBody",replacement="tBody ",colnames(tidy),fixed=F,perl=T)
  colnames(tidy)<-gsub(pattern="std...",replacement="std ",colnames(tidy))
  colnames(tidy)<-gsub(pattern="Mag.",replacement="Magnitude ",colnames(tidy))
  colnames(tidy)<-gsub(pattern="Jerk|Jerk.",replacement="Jerk  ",colnames(tidy))
  colnames(tidy)<-gsub(pattern="tGravity",replacement="Gravity  ",colnames(tidy))
  colnames(tidy)<-gsub(pattern=".std...|.std|.std..|Std.|Std|Std..",replacement=" Std Dev   ",colnames(tidy),fixed=F,perl=T)
  colnames(tidy)<-gsub(pattern="X|...X|.X",replacement="  in X axis ",colnames(tidy))
  colnames(tidy)<-gsub(pattern="Y|...Y|.Y",replacement="    in Y axis ",colnames(tidy))
  colnames(tidy)<-gsub(pattern="Z|...Z|.Z",replacement="in Z axis ",colnames(tidy))
  colnames(tidy)<-gsub(pattern="Gyro.|Gyro",replacement="Gyro ",colnames(tidy))
  colnames(tidy)<-gsub(pattern=".mean...|.mean|.mean..|Mean.|Mean|Mean..",replacement=" Mean ",colnames(tidy),fixed=F,perl=T)
  
  colnames(tidy)<-gsub(pattern="Acc",replacement="Acc ",colnames(tidy))
  colnames(tidy)<-gsub(pattern="fBody",replacement="Body ",colnames(tidy))
  
  # Writing the Tidy Data set to a Text File
  write.table(tidy, file = "./Tidy.txt",row.names=F)
  
}