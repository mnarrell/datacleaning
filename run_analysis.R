# Coursera Getting and Cleaning Data Course Project
#
# Matt Narrell (mnarrell@gmail.com)
# run_analysis.R

library(dplyr)

# Fetch the dataset, if necessary.
dataPath <- "./UCI HAR Dataset"
dataSrcUri <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(dataPath)) {
  temp <- tempfile()
  download.file(dataSrcUri, temp, method = "curl")
  unzip(temp)
  unlink(temp)
}

# Read the variable ids.
features <- read.table(file = paste(dataPath, "features.txt", sep = "/"), stringsAsFactors = FALSE)[, 2]
# Tidy the variable names.  Normalize the Mean and Std names, and remove the R-unfriendly characters.
features <- gsub("-mean", "Mean", features)
features <- gsub("-std", "Std", features)
features <- gsub("[-()]", "", features)
# Read the variable (id -> name) mapping.
activityLabels <- tbl_df(read.table(file = paste(dataPath, "activity_labels.txt", sep = "/"), stringsAsFactors = FALSE, 
                                    col.names = c("id", "label")))
# Convenience function to map a vector of feature ids to their labels.
mapLabels <- function(path) {
  labels <- as.numeric(readLines(paste(dataPath, path, sep = "/")))
  mappedLabels <- activityLabels[match(labels, activityLabels$id), "label"]$label
  mappedLabels
}
# Convenience function to read subject ids, from arbitrary files.
getSubjects <- function(path) {
  subjects <- as.numeric(readLines(paste(dataPath, path, sep = "/")))
  subjects
}

# Load the training data.
trainingSet <- tbl_df(read.table(file = paste(dataPath, "train/X_train.txt", sep = "/"), col.names = features)) %>%
  # Add the subject id, and the activity label to this data frame.
  mutate(subject = getSubjects("train/subject_train.txt"), activity = mapLabels("train/Y_train.txt"))

# Load the test data.
testSet <- tbl_df(read.table(file = paste(dataPath, "test/X_test.txt", sep = "/"), col.names = features)) %>%
  # Add the subject id, and the activity label to this data frame.
  mutate(subject = getSubjects("test/subject_test.txt"), activity = mapLabels("test/Y_test.txt"))

# Merge the data sets.
merged <- rbind_list(trainingSet, testSet)

# Select the mean and standard deviation variables and group by subject and activity.
merged <- merged %>%
  select(subject, activity, matches("Mean|Std", ignore.case = FALSE)) %>%
  arrange(subject, activity) %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

# Prefix these variables to distinguish them from the original data set.
n <- colnames(merged)[-(1:2)]
colnames(merged)[-(1:2)] <- paste("mean.of.", n, sep = "")
rm(n)

# Write the tidy output as a CSV file.
if(!file.exists("./output")) {
  dir.create("./output")
}
write.csv(merged, "./output/merged.csv", fileEncoding = "ASCII", row.names = FALSE) 
