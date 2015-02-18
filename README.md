Getting and Cleaning Data Course Project
========================================

The goal of this project is to prepare tidy dataset from *Human Activity Recognition Using Smartphones Data Set*.

## Contents

Project consists of these files:

- `README.md` - file you are reading now
- `run_analysis.R` - R script with functions to prepare tidy dataset
- `CodeBook.md` - a code book that describes the variables, the data, and transformations performed to clean up the data

## Usage

To prepare a tidy dataset perform the following steps:

1. Start R console.
2. Set working directory to the project dir with script file `run_analysis.R`.
3. Load functions from R script:

        > source('run_analysis.R')

4. Run main function:

        > tidy_har_dataset(dest)

  `dest` is file name where tidy dataset will be outputed.

## Description

The main function `tidy_har_dataset()` does not assume that `UCI HAR Dataset/` directory is in the working dir. However, if it is already present, data from it are used.

If directory is not present, function looks for `uci_har_dataset.zip` file. If this file is also not present, data are downloaded from the [original URL](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and saved into `uci_har_dataset.zip`. Then zip file is extracted.

After making sure that data dir is in place, the main data transformation proceeds in the following steps:

1. Test and train data are read from `UCI HAR Dataset/test/` and `UCI HAR Dataset/train/` dirs respectively and combined into one dataset.

    For both of test and train data there are three files: `X_...txt`, `y_...txt`, `subject_...txt` that need to be read and combined. These three files have the same number of lines corresponding to the same observations. `subject_...txt` provide subject identifiers for each observation, `y_...txt` provides activity codes for each observation, and `X_...txt` provides measurement data for each observation. Data from these three files are column-binded to yield a dataset with column *Subject*, *Activity* and 561 columns for measurements with automatically constructed column names *V1*, ..., *V561*.

    Loaded test data consist of 2947 rows-observations, while train data consists of 7352 rows-observations.

    Finally, these two datasets are row-binded, resulting in a merged dataset of 10299 rows corresponding to observations and 563 columns (*Subject*, *Activity*, and 561 measurements).

2. Only columns with measurements on the mean and standard deviation for each measurement are selected (obviously, together with *Subject* and *Activity*).

    File `UCI HAR Dataset/features.txt` lists all the features that were measured during the experiment. It has 561 lines with measurement names corresponding to 561 columns *V1*, ..., *V561* in the data that were loaded and merged in the first step.

    Measurements of mean and standard deviation for each signal have `-mean()` and `-std()` in their names. I do not include measurements with `-meanFreq()` and the last 7 with `Mean` in their names, as they have a rather different meaning.

    To get names of columns to be extracted, function finds row indexes for features with matching names (using `grep`), transforms them into corresponding names in the form *V?* and then uses `select_` function from `dplyr` package to select only those columns. *Activity* and *Subject* columns are selected as well.

    After this step only 68 columns (66 measurements) are left.

3. Activities are descriptively named in the main dataset.

    Up until now activities are represented by their codes in *Activity* column that are not descriptive at all.

    Similarly as with features, there is a file `UCI HAR Dataset/activity_labels.txt` that lists activities names with their corresponding codes. The data from this file are read first. Then activity names are transformed to be more readable: they are lowercased and the underscore is replaced with a simple space.

    Finally, activity codes from *Activity* column in the main dataset are replaced with corresponding activity names from activity data set.

4. Measurement columns are descriptively named.

    Up until now measurement columns still have their automatic column names in format *V?*. In this step, they are renamed to more descriptive names using feature-measurement names that were loaded and used in the 2nd step.

    Straight features names could be used but I transform them to be a little bit more tidy and reader-friendly: symbols `()-` are removed, names are camel-cased, also some errors are fixed, like `BodyBody` in certain variable.s Thus column corresponding to measurement *fBodyBodyGyroJerkMag-mean()* is named *fBodyGyroJerkMagMean*.

5. A new tidy dataset is created with the average of each variable for each activity and each subject. I selected long format of tidy data.

    Previously prepared dataset is melted so that columns corresponding to measurements become values in new column *Variable* and value of measurement goes to a new column automatically named  *value*.

    Finally, data are summarized, grouping by *Subject*, *Activity* and *Variable* columns, and creating new column *Average* with mean number of values in each group.

    This final dataset contains 11880 lines - one for each combination of 30 subjects, 6 activities and 66 measurements.

    If `dest` argument was provided to the function, final tidy dataset is outputted to it.
