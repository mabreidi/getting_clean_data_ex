setwd(choose.dir()) # choose directory containing the folder "UCI HAR Dataset"

#### Read and rbind()/c() the data

train <- read.table("./UCI HAR Dataset/train/X_train.txt")
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
df <- rbind(train,test)

train_labels <- scan("./UCI HAR Dataset/train/Y_train.txt")
test_labels <- scan("./UCI HAR Dataset/test/Y_test.txt")
labels <- c(train_labels,test_labels)

test_subject <- scan("./UCI HAR Dataset/test/subject_test.txt")
train_subject <- scan("./UCI HAR Dataset/train/subject_train.txt")
subject <- c(train_subject,test_subject)

act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

features <- read.table("./UCI HAR Dataset/features.txt")

#### Add subject/acticity information

# Name the columns according to features.txt to make variable names descriptive
colnames(df) <- features[,2]

# assign the subjects
df$subject <- subject

# matches activities in the data with the labels to make them descriptive
df$activity <- act_labels[,2][match(labels,act_labels[,1])]

#### Extract only means and stdv measurements

mean_index <- grep("mean()",colnames(df))
std_index <- grep("std()",colnames(df))
act_index <- grep("activity",colnames(df))
subj_index <- grep("subject",colnames(df))


keep_index <- c(mean_index,std_index,act_index,subj_index)

df_subset <- df[,keep_index]

# create second data set with means for each activity and subject

mean_per_subj_act <- df_subset %>% group_by(subject,activity) %>% summarise(across(everything(), list(mean)))

# save the mean set and the tidy set
write.table(mean_per_subj_act,"mean_tidy_data.txt",sep=",",dec=".",col.names=TRUE)
write.table(df_subset,"tidy_data.txt",sep=",",dec=".",col.names=TRUE)
