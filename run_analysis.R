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

# Main function for tidying dataset
tidy_har_dataset <- function(dest='tidy_har.txt') {
    # First, download and unzip data if needed
    get_har_dataset()
}