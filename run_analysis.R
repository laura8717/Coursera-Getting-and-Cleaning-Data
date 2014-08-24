## read in the data files - this assumes the proper working directory has
## been set
testData <- read.table("./UCI HAR dataset/test/X_test.txt")
testActLabels <- read.table("./UCI HAR dataset/test/y_test.txt")
trainData <- read.table("./UCI HAR dataset/train/X_train.txt")
trainActLabels <- read.table("./UCI HAR dataset/train/y_train.txt")
actLabs <-  read.table("./UCI HAR dataset/activity_labels.txt")
whoTrain <- read.table("./UCI HAR dataset/train/subject_train.txt")
whoTest <- read.table("./UCI HAR dataset/test/subject_test.txt")

## find the mean() and std() columns by grepping for std and mean strings
features <- read.table("./UCI HAR dataset/features.txt")
stdCols <- grep ("-std()", features[,2])
meanCols <- grep ("-mean()", features[,2])

## append the column numbers together so there is a complete list
## sort them based on column number
extractCols <- append(meanCols, stdCols)
sortEC <- sort(extractCols)

# take just the columns we want (mean and std columns) from the test and train data
## First tease out the test data
newTestData=data.frame(matrix(NA, nrow=nrow(testData), 
                              (length(meanCols) + length(stdCols))))

newTestData <- testData[, sortEC]

## put the more understandable column headers in the test data
j <- 0
for (i in 1:ncol(newTestData)){
  j <- j + 1
  colnames(newTestData)[i] <- as.character(features[sortEC[j],2])
}

## Now move on and tease out the train Data
newTrainData=data.frame(matrix(NA, nrow=nrow(trainData), 
                              (length(meanCols) + length(stdCols))))

newTrainData <- trainData[, sortEC]

## put the more understandable column headers in the train Data
j <- 0
for (i in 1:ncol(newTrainData)){
  j <- j + 1
  colnames(newTrainData)[i] <- as.character(features[sortEC[j],2])
}

# column bind the subjects, the activities, and the data
cbindTestData = cbind(whoTest, testActLabels, newTestData)
cbindTrainData = cbind(whoTrain, trainActLabels, newTrainData)

# row bind the test and train data
mData = rbind(cbindTestData, cbindTrainData)

## add the column header for subject and activity
colnames(mData)[1] <- "Subject"
colnames(mData)[2] <- "Activity"

# order the data based on subject first and then activity
newMData <- mData[ order(mData[,1], mData[,2]), ]

## Now on to par 5 aggregate the Data based on the mean of each column for each
## subject/activity
aggData <- aggregate(newMData, by=list(newMData$Subject, newMData$Activity), 
                                         FUN=mean, na.rm=TRUE)

## Now we have all the aggregated data - Need to remove the Group.1 column 
## and the Group.2 column because it is not wanted in the data but it was
## insered via the aggregate function.
## Also, change the "Activity" column from a digit to a string.
aggData$Group.1 <- NULL
aggData$Group.2 <- NULL

aggData$Activity[aggData$Activity == 1] <- as.character(actLabs[1,2])
aggData$Activity[aggData$Activity == 2] <- as.character(actLabs[2,2])
aggData$Activity[aggData$Activity == 3] <- as.character(actLabs[3,2])
aggData$Activity[aggData$Activity == 4] <- as.character(actLabs[4,2])
aggData$Activity[aggData$Activity == 5] <- as.character(actLabs[5,2])
aggData$Activity[aggData$Activity == 6] <- as.character(actLabs[6,2])

# Done creating Tidy Data!!!!

