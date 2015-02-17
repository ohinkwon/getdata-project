# Load dplyr and data.table
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
    y <- read.table(file.path(dir, paste0('y', postfix)), col.names=c('activity_nr'), nrows=nrows)
    subject <- read.table(file.path(dir, paste0('subject', postfix)), col.names=c('subject'), nrows=nrows)
    data <- cbind(subject, y, X)
}

# Main function for tidying dataset
tidy_har_dataset <- function(dest='tidy_har.txt') {
    # First, download and unzip data if needed
    get_har_dataset()
    # Read test data
    test <- read_data('test', 100)
    # Read train data
    train <- read_data('train', 100)
    # Merge train and test data into one data frame
    data <- rbind(test, train)
    # Read features
    features <- read.table(file.path(HAR_DIR, 'features.txt'), col.names=c('nr', 'name'), colClasses=c('numeric', 'character'))
    # Select features corresponding to mean and stdev of measurements
    mean_std <- grep('-(mean|std)\\(', features$name)
    # Construct column names
    columns = paste0('V', features[mean_std,]$nr)
    # Add two first columns
    columns_plus = c('subject', 'activity_nr', columns)
    # Select only these columns
    selected <- select(data, one_of(columns_plus))
    # Rename columns
    new_columns <- features[mean_std,]$name
    renamed <- rename_(selected, .dots=setNames(columns, features[mean_std,]$name))
    # Read activity data
    activities <- read.table(file.path(HAR_DIR, 'activity_labels.txt'), col.names=c('nr', 'activity'), colClasses=c('numeric', 'character'))
    # Merge measurements and activities data by activity nr
    merged <- merge(activities, renamed, by.x='nr', by.y='activity_nr')
    # Drop `nr` column
    final <- select(merged, -(nr))
    # Melt dataset
    melted <- melt(final, id.vars=c('activity', 'subject'), measure.vars=new_columns)

    # Prepare tidy data set with averages of each variable for each activity and each subject
    tidy <- summarise(group_by(melted, activity, subject, variable), mean(value))
    
    print(head(tidy, n=100))
}