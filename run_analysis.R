# Load packages
library(dplyr)
library(reshape2)

# Directory with UCI HAR dataset
HAR_DIR <- 'UCI HAR Dataset'

# Function to download and unzip data if not present in working dir
get_har_dataset <- function() {
    zip_file <- 'uci_har_dataset.zip'
    if (!file.exists(HAR_DIR)) {
        if (!file.exists(zip_file)) {
            url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
            download.file(url, dest=zip_file, method='curl')
        }
        if (file.exists(zip_file)) {
            unzip(zip_file)
        } else {
            stop('Fatal error: no data found')
        }
    }
    if (!file.exists(HAR_DIR)) {
        stop('Fatal error: no data found')
    }
}

# Function to read test/train data
#   `which` is either 'test' or 'train'
#   `nrows` is number of rows to read (used for testing the function)
# Load subject, activity and measurement data and combine into one data frame.
#
read_data <- function(which, nrows=-1) {
    if (!(which %in% c('test', 'train'))) {
        stop('Undefined data part')
    }
    dir <- file.path(HAR_DIR, which)
    postfix <- paste0('_', which, '.txt')
    X <- read.table(file.path(dir, paste0('X', postfix)), nrows=nrows)
    y <- read.table(file.path(dir, paste0('y', postfix)), col.names=c('Activity'), nrows=nrows)
    subject <- read.table(file.path(dir, paste0('subject', postfix)), col.names=c('Subject'), nrows=nrows)
    data <- cbind(subject, y, X)
    data
}

# Transform activity name to a more readable one
# Convert to lowercase and replace the underscore with the space
transform_activity <- function(activity) {
    activity <- tolower(activity)
    activity <- gsub('_', ' ', activity)
    activity
}

# Transform measurement variable name to a more descriptive and readable one
# Camel case, remove brackets, remove '-', remove some duplications 
transform_measurement <- function(measurement) {
    measurement <- gsub('[\\(\\)]', '', measurement)
    measurement <- gsub('-mean', 'Mean', measurement)
    measurement <- gsub('-std', 'Std', measurement)
    measurement <- gsub('-', '', measurement)
    measurement <- gsub('BodyBody', 'Body', measurement)    
    measurement
}


# Main function for tidying dataset
tidy_har_dataset <- function(dest=NULL) {
    ## 1. Load and combine data
    # First, download and unzip data if needed
    get_har_dataset()
    # Read test data
    test <- read_data('test')
    # Read train data
    train <- read_data('train')
    # Merge train and test data into one data frame
    combined_data <- rbind(test, train)
    
    ## 2. Select only measurements of mean and standard deviation
    # Read features
    features <- read.table(file.path(HAR_DIR, 'features.txt'), col.names=c('code', 'name'), colClasses=c('numeric', 'character'))
    # Select features corresponding to mean and stdev of measurements
    mean_and_std <- grep('-(mean|std)\\(', features$name)
    # Construct column names
    columns = paste0('V', features[mean_and_std,]$code)
    # Add two first columns
    columns_plus = c('Subject', 'Activity', columns)
    # Select only these columns
    small_data <- select(combined_data, one_of(columns_plus))
    
    ## 3. Descriptively label activities
    # Read activity data
    activities <- read.table(file.path(HAR_DIR, 'activity_labels.txt'), col.names=c('code', 'activity'), colClasses=c('numeric', 'character'))
    # Change activity labels to more readable ones
    activities$activity <- lapply(activities$activity, transform_activity)
    # Replace activity codes with their labels in the main dataset
    for (row in 1:nrow(small_data)) {
        small_data[row,]$Activity <- activities[which(small_data[row,]$Activity==activities$code),]$activity[[1]]
    }
    
    ## 4. Descriptively label measurement variables
    # Construct new names for columns
    new_columns <- lapply(features[mean_and_std,]$name, transform_measurement)
    # Rename columns
    final_data <- rename_(small_data, .dots=setNames(columns, unlist(new_columns)))
    
    ## 5. Create a new tidy data with average of each variable for each activity and subject
    # Melt dataset so that measurement columns become values
    melted_data <- melt(final_data, id.vars=c('Subject', 'Activity'), measure.vars=new_columns)
    # Rename variable column
    melted_data <- rename(melted_data, Variable=variable)
    # Prepare tidy data set with averages of each variable for each activity and each subject
    tidy <- summarise(group_by(melted_data, Subject, Activity, Variable), Average=mean(value))
    # Output data if file name is provided
    if (!is.null(dest)) {
        write.table(tidy, file=dest, row.name=FALSE)
    }
    tidy
}
