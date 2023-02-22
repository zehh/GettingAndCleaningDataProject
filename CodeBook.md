# Codebook for "run_analysis.R"

## Objective The purpose of this script is to tidy and reshape the "Human Activity Recognition Using Smartphones" dataset, so that it can be used for analysis.
The script takes the raw data from the UCI Machine Learning Repository and performs a series of cleaning and transformation steps to make it tidy and easy to use.
The end result is a tidy dataset containing the mean of each feature for each activity and each subject.

## Input The script uses the following input files:

X_train.txt and X_test.txt: These files contain the raw observations.
y_train.txt and y_test.txt: These files contain the activity numbers for each observation.
subject_train.txt and subject_test.txt: These files contain the subject id for each observation.
features.txt: This file matches the numbers to a more descriptive name of a variable.
Output The script returns a single tibble:

finaldataset: This tibble contains the tidy dataset with the mean of each selected variable, grouped by subject and activity, as required by the assignment.

## Processing Steps The following processing steps are performed in the script:

1.Loading the tidyverse package which will be required.
2.Download and unzip the dataset from the UCI Machine Learning Repository.
3.Read in the training and test feature data from "X_train.txt" and "X_test.txt".
4.Read in the feature names from "features.txt".
5.Clean and format the experimental data into a tidy format using the "tidyObs()" custom function.
6.Create a matrix containing the tidy feature data for the training and test sets.
7.Read in the activity labels from "activity_labels.txt".
8.Read in the activity numbers from "y_train.txt", "y_test.txt" and the subject data from "subject_train.txt", and "subject_test.txt".
9.Clean and format the activity and subject data.
10.Combine the feature data, activity data, and subject data into a single dataframe.
11.Select only the mean and standard deviation columns and the activity and subject columns.
12.Group the dataframe by subject and activity and calculate the mean of each variable.
13.Return the final tidy dataset with the operations described in step 11 and 12.

## Libraries Used 
tidyverse

## Custom Functions Used 
tidyObs() : This function takes in a vector of strings, removes the leading and trailing whitespaces, separates values by the remaining whitespaces and returns a list of numeric vectors.

## Variables Used fileurl : The URL of the dataset zipfile.
traindir : The directory containing the training data.
testdir : The directory containing the test data.
trainingset : The raw training feature data.
testset : The raw test feature data.
variablenames : The names of the features.
activity_labels : The labels for the activities.
activity_test : The activity labels for the test set.
activity_training : The activity labels for the training set.
subject_test : The subject IDs for the test set.
subject_train : The subject IDs for the training set.
tidytrainingtibble : The tidy training dataset in a tibble format.
tidytesttibble : The tidy test dataset in a tibble format.
merged : The merged tidy dataset in a tibble format.
mergedselected : The subset of the merged dataset containing only the mean and standard deviation columns, as well as the activity and subject columns.
finaldataset : The final tidy dataset containing the mean of each feature for each activity and each subject.
