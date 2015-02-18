Codebook
========

# Variables

- **Subject** - identifier of subject (volunteer taking part in the experiment)

  VALUES: 1..30

- **Activity** - activity name (character)

  VALUES (in parenthesis - corresponding activity label from the original dataset):
    - walking (WALKING)
    - walking upstairs (WALKING_UPSTAIRS)
    - walking downstairs (WALKING_DOWNSTAIRS)
    - sitting (SITTING)
    - standing (STANDING)
    - laying (LAYING)


- **Variable** - measurement variable name (character)

  Values (in parenthesis - corresponding measurement name from the original list of features):

  - tBodyAccMeanX (tBodyAcc-mean()-X)
  - tBodyAccMeanY (tBodyAcc-mean()-Y)
  - tBodyAccMeanZ (tBodyAcc-mean()-Z)
  - tBodyAccStdX (tBodyAcc-std()-X)
  - tBodyAccStdY (tBodyAcc-std()-Y)
  - tBodyAccStdZ (tBodyAcc-std()-Z)
  - tGravityAccMeanX (tGravityAcc-mean()-X)
  - tGravityAccMeanY (tGravityAcc-mean()-Y)
  - tGravityAccMeanZ (tGravityAcc-mean()-Z)
  - tGravityAccStdX (tGravityAcc-std()-X)
  - tGravityAccStdY (tGravityAcc-std()-Y)
  - tGravityAccStdZ (tGravityAcc-std()-Z)
  - tBodyAccJerkMeanX (tBodyAccJerk-mean()-X)
  - tBodyAccJerkMeanY (tBodyAccJerk-mean()-Y)
  - tBodyAccJerkMeanZ (tBodyAccJerk-mean()-Z)
  - tBodyAccJerkStdX (tBodyAccJerk-std()-X)
  - tBodyAccJerkStdY (tBodyAccJerk-std()-Y)
  - tBodyAccJerkStdZ (tBodyAccJerk-std()-Z)
  - tBodyGyroMeanX (tBodyGyro-mean()-X)
  - tBodyGyroMeanY (tBodyGyro-mean()-Y)
  - tBodyGyroMeanZ (tBodyGyro-mean()-Z)
  - tBodyGyroStdX (tBodyGyro-std()-X)
  - tBodyGyroStdY (tBodyGyro-std()-Y)
  - tBodyGyroStdZ (tBodyGyro-std()-Z)
  - tBodyGyroJerkMeanX (tBodyGyroJerk-mean()-X)
  - tBodyGyroJerkMeanY (tBodyGyroJerk-mean()-Y)
  - tBodyGyroJerkMeanZ (tBodyGyroJerk-mean()-Z)
  - tBodyGyroJerkStdX (tBodyGyroJerk-std()-X)
  - tBodyGyroJerkStdY (tBodyGyroJerk-std()-Y)
  - tBodyGyroJerkStdZ (tBodyGyroJerk-std()-Z)
  - tBodyAccMagMean (tBodyAccMag-mean())
  - tBodyAccMagStd (tBodyAccMag-std())
  - tGravityAccMagMean (tGravityAccMag-mean())
  - tGravityAccMagStd (tGravityAccMag-std())
  - tBodyAccJerkMagMean (tBodyAccJerkMag-mean())
  - tBodyAccJerkMagStd (tBodyAccJerkMag-std())
  - tBodyGyroMagMean (tBodyGyroMag-mean())
  - tBodyGyroMagStd (tBodyGyroMag-std())
  - tBodyGyroJerkMagMean (tBodyGyroJerkMag-mean())
  - tBodyGyroJerkMagStd (tBodyGyroJerkMag-std())
  - fBodyAccMeanX (fBodyAcc-mean()-X)
  - fBodyAccMeanY (fBodyAcc-mean()-Y)
  - fBodyAccMeanZ (fBodyAcc-mean()-Z)
  - fBodyAccStdX (fBodyAcc-std()-X)
  - fBodyAccStdY (fBodyAcc-std()-Y)
  - fBodyAccStdZ (fBodyAcc-std()-Z)
  - fBodyAccJerkMeanX (fBodyAccJerk-mean()-X)
  - fBodyAccJerkMeanY (fBodyAccJerk-mean()-Y)
  - fBodyAccJerkMeanZ (fBodyAccJerk-mean()-Z)
  - fBodyAccJerkStdX (fBodyAccJerk-std()-X)
  - fBodyAccJerkStdY (fBodyAccJerk-std()-Y)
  - fBodyAccJerkStdZ (fBodyAccJerk-std()-Z)
  - fBodyGyroMeanX (fBodyGyro-mean()-X)
  - fBodyGyroMeanY (fBodyGyro-mean()-Y)
  - fBodyGyroMeanZ (fBodyGyro-mean()-Z)
  - fBodyGyroStdX (fBodyGyro-std()-X)
  - fBodyGyroStdY (fBodyGyro-std()-Y)
  - fBodyGyroStdZ (fBodyGyro-std()-Z)
  - fBodyAccMagMean (fBodyAccMag-mean())
  - fBodyAccMagStd (fBodyAccMag-std())
  - fBodyAccJerkMagMean (fBodyBodyAccJerkMag-mean())
  - fBodyAccJerkMagStd (fBodyBodyAccJerkMag-std())
  - fBodyGyroMagMean (fBodyBodyGyroMag-mean())
  - fBodyGyroMagStd (fBodyBodyGyroMag-std())
  - fBodyGyroJerkMagMean (fBodyBodyGyroJerkMag-mean())
  - fBodyGyroJerkMagStd (fBodyBodyGyroJerkMag-std())


- **Average** - average value over all original observations for each unique combination of Subject, Activity and Variable (measurement).
