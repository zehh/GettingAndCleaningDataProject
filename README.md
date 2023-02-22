# GettingAndCleaningDataProject
A project to be peer-reviewed which is created for the Coursera Course "Getting and Cleaning Data" from Johns Hopkins University

## Author
Pedro Henrique Caldeira Brant Faria

## Description
This assignment asks the learner to tidy a data set and perform a basic mean operation on a selected subset of this data. The detailed description of the steps taken to go from the original provided data set to a tidy version of it, with the required mean operation, is available in the CodeBook.md file in this repository.

The original data set is supplied by the course and can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The original data set is described in the readme.txt file which is located in the following subdirectory:
> ./data/UCI HAR Dataset/ 

## Contents
The following files are included in this repository:
- CodeBook.md: The codebook that describes the steps taken to go from the original data set to the tidy version required by the assignment.
- cleaningData.R: R script which was developed during the assignment. Available at this time only for access to the version control files that were uploaded with it. This file has the wrong name for the assignment, therefore, the contents of its latest update were copied onto the next described file.
- run_analysis.R: R script which is required by the assignment. This script, when run in an environment which has a ./data/ subdirectory with the contents of the UCI HAR Dataset, will tidy that data set and group the observations by subject and activity, calculating the mean of all the variables of interest \(ones which were previously the mean or standard deviation of an original measurement\)