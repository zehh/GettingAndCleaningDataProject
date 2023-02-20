## load packages that will be useful
library (tidyverse)
## create data subdirectory if it doesn't already exist
if(!file.exists("./data")){dir.create("./data")}
## get the url for the dataset zipfile
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## create temporary file to store the zip file
temp<-tempfile()
## download zip file into the temporary file
download.file(fileurl,temp)
## unzip the temporary zip file into the data subdirectory
unzip(temp,exdir = "./data")
## remove temp from the global environment
rm(temp)
## create traindir and testdir to make things simpler
traindir<-"./data/UCI HAR Dataset/train"
testdir<-"./data/UCI HAR Dataset/test"
## read the training set
trainingset <- read_lines(paste(traindir,sep="/","X_train.txt"))
## read the test set
testset <- read_lines(paste(testdir,sep="/","X_test.txt"))
## trim the leading white space from the testset rows
## then split the row using the whitespaces between numbers as separators
## finally, convert to numeric
testset[1]%>%trimws()%>%str_split_1(" +")%>%as.numeric()
## these values correspond to the variables in "features.txt"
