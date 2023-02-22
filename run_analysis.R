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

## create a function that can tidy the sets
tidyObs <- function (set){
        ##initialize the tidySet that will be returned
        tidySet<-list()
        for(i in 1:length(set)){
                ## trim the leading whitespaces
                ## split the character string using the whitespaces
                ## transform into numbers
                tidySet[[i]]<-
                        set[i]%>%trimws()%>%str_split_1(" +")%>%as.numeric()
        }
        tidySet
}
tidytestset <- tidyObs(testset)

## create a matrix to store the data in a tidy format
## Getting the matrix dimensions
nrows <- length(testset)
## Calculating the number of columns
## Number of columns is the number of variables in the data set.
## To calculate it, we get the first tidy observation and look at it's length
ncols <- length(tidytestset[[1]])

## The names of the variables are described in "features.txt"
## we will read that file now so that it may name our variables
variablenames<-read_lines("./data/UCI HAR Dataset/features.txt")
## those names aren't properly formatted, so we need to reformat them
## we will exclude all the numbers on the start of the line and 
## all the whitespaces
variablenames<-gsub("^([0-9]+)|(\\s+)","",variablenames)

## create a list and pass variable names as the second element
## so that we can use it to name the columns when creating the matrix with the
## matrix() function
variablenameslist<-list()
variablenameslist[[2]]<-variablenames

tidytestmatrix<-matrix(unlist(tidytestset), nrow = nrows, ncol = ncols,
                       byrow = TRUE, dimnames = variablenameslist)

# the same that was done above now needs to be done to create the training data
nrowstraining <- length(trainingset)
tidytrainingset <- tidyObs(trainingset)
## number of variables is the same (same variables)
tidytrainingmatrix<- matrix(unlist(tidytrainingset),
                            nrow = nrowstraining, ncol = ncols, byrow = TRUE,
                            dimnames = variablenameslist)

## now that both the data sets have been created, we need to add the
## activities and subjects to the observations contained in them

## create activity labels
activity_labels <- read_lines("./data/UCI HAR Dataset/activity_labels.txt") %>%
        substring(3) %>% unique() %>% 
        { 
                {. -> tmp} %>% factor(levels = tmp)
        }

## read the activities and subjects
activity_test <- read_lines(paste(testdir,sep="/","y_test.txt"))
activity_training <- read_lines(paste(traindir,sep="/","y_train.txt"))
subject_test <- read_lines(paste(testdir,sep="/","subject_test.txt"))
subject_train <- read_lines(paste(traindir,sep="/","subject_train.txt"))

## convert activity to the labels
activity_test <- factor(activity_test,
                        levels = 1:length(activity_labels),
                        labels = activity_labels)
activity_training <- factor(activity_training,
                            levels = 1:length(activity_labels),
                            labels = activity_labels)

## add the activities and subjects to their respective data set
tidytrainingmatrix %>% as_tibble(.name_repair = "unique") %>% 
        mutate(activity=activity_training,
               subject = as.numeric(subject_train),
               type = rep("TRAIN",times=nrowstraining)) -> tidytrainingtibble
tidytestmatrix %>% as_tibble(.name_repair = "unique") %>% 
        mutate(activity=activity_test, subject = as.numeric(subject_test),
               type = rep("TEST",times=nrows)) -> tidytesttibble

## merge both the tibbles
merged<-bind_rows(tidytrainingtibble,tidytesttibble)

## select variables of interest as provided by the assignment
merged%>%select(grep("std|mean\\(|activity|subject",colnames(merged)))-> 
        mergedselected

## group by the activity and calculate the mean
mergedselected%>%group_by(subject,activity)%>%
        summarize(across(everything(),mean, .names = "mean_{.col}")) ->
        finaldataset

finaldataset
