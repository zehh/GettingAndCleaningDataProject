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

tidytestmatrix<-matrix(unlist(tidytestset), nrow = nrows, ncol = ncols, byrow = TRUE,
                       dimnames = variablenameslist)