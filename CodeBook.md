# Code Book
The dimensions of the merged data set are 180x88.  Thirty subjects with six activities each yields 180 observations.  86 averages of the mean and standard deviation variables in the original data set, plus subject and activity yield 88 variables.

***
#### Dependencies
* [dplyr]("http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html") - For data manipulation convenience.

***
#### Environment
The following are produced when the **run_analysis.R** script is sourced.

Name           | Description
-------------- | -----------
dataPath       | The path of the downloaded data set
dataSrcUri     | The URL of the data set
activityLabels | A data frame table mapping an activity ID to its English label
trainingSet    | The tidy training data frame table
testSet        | The tidy test data frame table
merged         | The merged training and test data frame table

***
#### Functions
* **mapLabels(path_to_labels_file)** - This function, given a full or relative path to one of the label files, will load this file as a numeric vector and produce a character vector mapping the ID values contained in the label file to their English label in the activity labels data frame table.
* **getSubjects(path_to_subjects_file)** - This function, given a full or relative path to one of the subject files, will load this file as a numeric vector.

***
#### Data Cleaning Process
1. The data sets are downloaded if necessary and unzipped into a data directory named **UCI HAR Dataset** that is reflective of this data.
1. The features, which are the variable names, are read into a character vector and massaged so that the Mean and Std character strings are normalized, and non word characters are removed for ease and consistency.
1. The activity labels, are read into a data frame table that produces a mapping from ID to English label.  The activity observations in the data sets are identified by ID, and this data frame provides a lookup table for the label.  The column names have been set to _id_ and _label_ for convenience.
1. The training and test data sets are loaded into their own data frame tables.  The column names are are taken from the features character vector.
1. A _subject_ variable is added to both the training and test sets with data from the _getSubjects_ function.  Likewise, an _activity_ variable is added containing the mapped activity labels.
1. The two data from tables are merged, by rows, using dplyr.
1. The merged data frame table's variables are selected such that the subject and activity columns are first, followed by all columns who's names contain either **Mean** or **Std**.
1. The data frame table is arranged and grouped by subject and activity.
1. The average of each of the **Mean** and **Std** columns is calculated over the subject/activity groupings.
1. The merged data frame table is written to **./output/merged.csv** as an ASCII encoded file.  The row names are omitted as they duplicate the line numbers.

***
#### Variables
The following variables are present in the merged data set.

* **subject** - Identifier of the subject performing this test.  Values range from 1 - 30.
* **activity** - The activity this subject performed.  Values range from (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

The following variables are the arithmetic of the mean and standard deviation variables, subsetted from the original data set.  These variables have been prefixed by **_mean.of._** to distinguish them from the original variables.  Please examine the features_info.txt file in the original data set for detailed explanation of the original variables.

* **mean.of.tBodyAccMeanX**
* **mean.of.tBodyAccMeanY**
* **mean.of.tBodyAccMeanZ**
* **mean.of.tBodyAccStdX**
* **mean.of.tBodyAccStdY**
* **mean.of.tBodyAccStdZ**
* **mean.of.tGravityAccMeanX**
* **mean.of.tGravityAccMeanY**
* **mean.of.tGravityAccMeanZ**
* **mean.of.tGravityAccStdX**
* **mean.of.tGravityAccStdY**
* **mean.of.tGravityAccStdZ**
* **mean.of.tBodyAccJerkMeanX**
* **mean.of.tBodyAccJerkMeanY**
* **mean.of.tBodyAccJerkMeanZ**
* **mean.of.tBodyAccJerkStdX**
* **mean.of.tBodyAccJerkStdY**
* **mean.of.tBodyAccJerkStdZ**
* **mean.of.tBodyGyroMeanX**
* **mean.of.tBodyGyroMeanY**
* **mean.of.tBodyGyroMeanZ**
* **mean.of.tBodyGyroStdX**
* **mean.of.tBodyGyroStdY**
* **mean.of.tBodyGyroStdZ**
* **mean.of.tBodyGyroJerkMeanX**
* **mean.of.tBodyGyroJerkMeanY**
* **mean.of.tBodyGyroJerkMeanZ**
* **mean.of.tBodyGyroJerkStdX**
* **mean.of.tBodyGyroJerkStdY**
* **mean.of.tBodyGyroJerkStdZ**
* **mean.of.tBodyAccMagMean**
* **mean.of.tBodyAccMagStd**
* **mean.of.tGravityAccMagMean**
* **mean.of.tGravityAccMagStd**
* **mean.of.tBodyAccJerkMagMean**
* **mean.of.tBodyAccJerkMagStd**
* **mean.of.tBodyGyroMagMean**
* **mean.of.tBodyGyroMagStd**
* **mean.of.tBodyGyroJerkMagMean**
* **mean.of.tBodyGyroJerkMagStd**
* **mean.of.fBodyAccMeanX**
* **mean.of.fBodyAccMeanY**
* **mean.of.fBodyAccMeanZ**
* **mean.of.fBodyAccStdX**
* **mean.of.fBodyAccStdY**
* **mean.of.fBodyAccStdZ**
* **mean.of.fBodyAccMeanFreqX**
* **mean.of.fBodyAccMeanFreqY**
* **mean.of.fBodyAccMeanFreqZ**
* **mean.of.fBodyAccJerkMeanX**
* **mean.of.fBodyAccJerkMeanY**
* **mean.of.fBodyAccJerkMeanZ**
* **mean.of.fBodyAccJerkStdX**
* **mean.of.fBodyAccJerkStdY**
* **mean.of.fBodyAccJerkStdZ**
* **mean.of.fBodyAccJerkMeanFreqX**
* **mean.of.fBodyAccJerkMeanFreqY**
* **mean.of.fBodyAccJerkMeanFreqZ**
* **mean.of.fBodyGyroMeanX**
* **mean.of.fBodyGyroMeanY**
* **mean.of.fBodyGyroMeanZ**
* **mean.of.fBodyGyroStdX**
* **mean.of.fBodyGyroStdY**
* **mean.of.fBodyGyroStdZ**
* **mean.of.fBodyGyroMeanFreqX**
* **mean.of.fBodyGyroMeanFreqY**
* **mean.of.fBodyGyroMeanFreqZ**
* **mean.of.fBodyAccMagMean**
* **mean.of.fBodyAccMagStd**
* **mean.of.fBodyAccMagMeanFreq**
* **mean.of.fBodyBodyAccJerkMagMean**
* **mean.of.fBodyBodyAccJerkMagStd**
* **mean.of.fBodyBodyAccJerkMagMeanFreq**
* **mean.of.fBodyBodyGyroMagMean**
* **mean.of.fBodyBodyGyroMagStd**
* **mean.of.fBodyBodyGyroMagMeanFreq**
* **mean.of.fBodyBodyGyroJerkMagMean**
* **mean.of.fBodyBodyGyroJerkMagStd**
* **mean.of.fBodyBodyGyroJerkMagMeanFreq**
* **mean.of.angletBodyAccMean.gravity**
* **mean.of.angletBodyAccJerkMean.gravityMean**
* **mean.of.angletBodyGyroMean.gravityMean**
* **mean.of.angletBodyGyroJerkMean.gravityMean**
* **mean.of.angleX.gravityMean**
* **mean.of.angleY.gravityMean**
* **mean.of.angleZ.gravityMean**
