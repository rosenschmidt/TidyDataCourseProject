################################################################################

# run_analysis.R

# Coursera June 2014 Getting and Cleaning Data

# Fred Schmidt, Columbia Missouri USA fred@rosenschmidt.org

# unzip the directory, if necessary.
#dataDir <- "./UCI HAR Dataset"
#if(file.exists(dataDir))
#   file.remove(dataDir,recurseive=TRUE)
# for some reason all, attempts at testing existence fail
# so do attempts to remove; they fail silently.
dataFile <- "getdata-projectfiles-UCI HAR Dataset.zip"
unzip(dataFile)

# Read in column headings and make them legal R variable names.
# There are not 561 unique column names, but 447 or thereabouts.
# fwiw, my solution is to prepend the 3-digit column number with leading zeros.

colHeadsRaw <- read.table("UCI HAR Dataset/features.txt")

colheads1 <- as.character(colHeadsRaw$V2)
colheads2 <- gsub("\\()","",colheads1)
colheads3 <- gsub(",","-",colheads2)
colheads4 <- gsub(")","",colheads3)
colheads5 <- gsub("\\(","",colheads4)
colheads6 <- paste(sprintf("C%03d",colHeadsRaw$V1),colheads5,sep="_")
column_heads_final <- gsub("-","_",colheads6)

rm(colheads1,colheads2,colheads3,colheads4,colheads5,colheads6)
rm(colHeadsRaw)

################################################################################

# read in train and test datasets, bind them together

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(y_train) <- "Activity"
colnames(subject_train) <- "Subject"
colnames(X_train) <- column_heads_final
data_train <- cbind(y_train,subject_train,X_train)

rm(X_train,y_train,subject_train)

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(y_test) <- "Activity"
colnames(subject_test) <- "Subject"
colnames(X_test) <- column_heads_final

data_test <- cbind(y_test,subject_test,X_test)

rm(X_test,y_test,subject_test)

# append them

theData1 <- rbind(data_train,data_test)

rm(data_train,data_test)

################################################################################

# squash out columns not related to mean or std dev
# there is some debate about this; I keep all columns with std or mean in the name
# This gives me a few more columns than I am hearing about on the forums.
# But for purposes of the assignment, demonstrates the concept.

tidyDataFrame1 <- theData1[,
                      colnames(theData1) == "Activity" |
                      colnames(theData1) == "Subject" |
                      grepl("mean",colnames(theData1),ignore.case = TRUE) |
                      grepl("std",colnames(theData1),ignore.case = TRUE)   ]


# the below does not work for some reason
# tidyDataFrame1 <- cbind(as.integer(theData1$Activity),tidyDataFrame1)

rm(theData1)

################################################################################

# create the second matrix of row means

theData3 <- split(tidyDataFrame1,paste(tidyDataFrame1$Activity,tidyDataFrame1$Subject))
theData4 <- lapply(theData3,colMeans)
tidyDataFrame2 <- do.call("rbind",theData4)

rm(theData3,theData4)

################################################################################

# add the Activity NAMES along with Activity code using merge

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

colnames(activity_labels) <- c("Activity","Activity_Name")

tidyDataFrame1 <- merge(x = activity_labels,
                        y = tidyDataFrame1,
                        by = "Activity", 
                        all.y = TRUE)

tidyDataFrame2 <- merge(x = activity_labels,
                        y = tidyDataFrame2,
                        by = "Activity", 
                        all.y = TRUE)

rm(activity_labels)

################################################################################

# output the two tidy files

write.table(tidyDataFrame1,file="tidyDataFrame1.txt",row.names=FALSE,sep="\t")
write.table(tidyDataFrame2,file="tidyDataFrame2.txt",row.names=FALSE,sep="\t")

################################################################################

rm(column_heads_final)

#####END OF FILE################################################################
