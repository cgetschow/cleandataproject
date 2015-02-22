# load raw data files into data frames
activity_labels<-read.table("activity_labels.txt")
features<-read.table("features.txt")
subject_test<-read.table("test/subject_test.txt")
X_test<-read.table("test/X_test.txt")
y_test<-read.table("test/y_test.txt")
subject_train<-read.table("train/subject_train.txt")
X_train<-read.table("train/X_train.txt")
y_train<-read.table("train/y_train.txt")

# rename feature columns in test and training sets
#  according to features list
names(X_test)<-features$V2
names(X_train)<-features$V2
# rename columns for labels and subjects
names(y_test)<-"activity_index"
names(y_train)<-"activity_index"
names(subject_test)<-"subject"
names(subject_train)<-"subject"

# combine data frames for test and training sets
testset<-cbind(y_test,X_test,subject_test)
trainset<-cbind(y_train,X_train,subject_train)

# combine test and training sets into one data frame
alldata<-rbind(testset,trainset)

# Extract only the measurements on the mean 
#   and standard deviation for each measurement
meandata<-alldata[,grep("mean",names(alldata),ignore.case=TRUE)]
stddata<-alldata[,grep("std",names(alldata),ignore.case=TRUE)]

# extract activity and subject columns
act_subj<-alldata[,c("activity_index","subject")]

# assign names to the activity indexes
names(activity_labels)<-c("activity_index","activity")
act_subj<-merge(activity_labels, act_subj, by="activity_index")

# drop the activity_index column; we don't need it any more
act_subj<-act_subj[,c("activity","subject")]

# put together the combined data set
dataset<-cbind(act_subj,meandata,stddata)

###

# Now create a second, independent tidy data set with the average 
#   of each variable for each activity and each subject.

suppressWarnings(dataset_ave<-aggregate(dataset,by=list(dataset$subject,dataset$activity),FUN=mean))
# (ignore the warnings as these are due to attempting to average the
#    "activity" values; we'll replace this column with 'Group.2')

# drop unnecessary columns Group.1 (corresponds to "subject") and
#   "activity" (computed as NA's, corresponds to "Group.2)
dataset_ave<-dataset_ave[,!(names(dataset_ave) %in% c("activity","Group.1"))]
# rename "Group.2" column back to "activity"
names(dataset_ave)[names(dataset_ave)=="Group.2"]<-"activity"

# write the second data set to a file
write.table(dataset_ave, "uci_har_mean_std_average.txt", row.name=FALSE)


