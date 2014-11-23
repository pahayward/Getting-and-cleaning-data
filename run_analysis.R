
run_analysis <- function() 
{  
  # This script should be copied to/run from "UCI HAR Dataset" directory 
  
  ####################################################################
  # 1. Merges the training and the test sets to create one data set.
  ####################################################################
  
  # Read subject, x & y data sets from training data set 
  message("Reading data in...")
  train_subject<-read.table("train/subject_train.txt", sep="") # Subject# associated with each data row (non sequential)
  xtrain_coldata<-read.table("train/X_train.txt", sep="") # 561 columns 
  ytrain_coldata<-read.table("train/y_train.txt", sep="") # Activity associated with each row 
  
  test_subject<-read.table("test/subject_test.txt", sep="") # Subject No associated with each row 
  xtest_coldata<-read.table("test/X_test.txt", sep="") # 561 columns 
  ytest_coldata<-read.table("test/y_test.txt", sep="") # Activity associated with each row 
  
  # Read the columns names for subject, x, y data sets
  message("Reading column names...")
  xtrain_colnames<-read.table("features.txt", sep="") # 561 variable names for X data 
  activity_names<-read.table("activity_labels.txt", sep="") # 6 Activity type names
  
  
  # Add in subjects columns 
  message("Name all the data columns...")
  colnames(train_subject)<-c("Subject")
  colnames(test_subject)<-c("Subject")
  
  # Label up columns for Xtrain 
  colnames(xtrain_coldata)<-paste(sapply(xtrain_colnames[2],paste))
  colnames(xtest_coldata)<-paste(sapply(xtrain_colnames[2],paste))
  
  # Activity column 
  colnames(ytrain_coldata)<-c("Activity")
  colnames(ytest_coldata)<-c("Activity")
  
  # Make one train data set from 3 column sets
  message("Combine datasets...")
  final_train<-xtrain_coldata
  final_train[ncol(final_train)+1]<-train_subject 
  final_train[ncol(final_train)+1]<-ytrain_coldata
  
  # Make one test data set from 3 column sets 
  final_test<-xtest_coldata
  final_test[ncol(final_test)+1]<-test_subject
  final_test[ncol(final_test)+1]<-ytest_coldata
  
  # Make one big set of everything
  message("Make final (large) data set...")
  final_set<-rbind(final_train,final_test)
  
  ####################################################################
  # 2. Subset - only mean() and std() (And subject|Activity as well)
  ####################################################################
  message("Subset the data...")
  subset_meanstd<-final_set[grep("-mean..-|-std..-|Subject|Activity", colnames(final_set))]
  
  
  ####################################################################
  # 3: Name the activities (from a number to a name) - extra column 
  ####################################################################
  message("Add in additional column - activity descriptions...")
  subset_meanstd$'Activity Description' <- activity_names$V2[subset_meanstd$Activity]
  
  
  ######################################################################
  # 4. Appropriately labels the data set with descriptive variable names.  
  ######################################################################
  
  # Hopefully I've done this already!
  
  ##############################################################################
  # 5. From the data set in step 4, creates a second, independent tidy data set 
  # with the average of each variable for each activity and each subject.
  ##############################################################################
  message("Generate average(mean) for EACH subject and for EACH activity")
  
  # Todo: 
  # Average of EACH variable for EACH subject and for EACH activity
  
  final_result <- ddply(.data =  subset_meanstd, .variables=c("Activity", "Subject"), mean=mean(), na.rm=TRUE )
  

}



