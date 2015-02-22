# cleandataproject
Project submission for Getting and Cleaning Data course

Refer to the original project README.txt for information about the raw 
"Human Activity Recognition Using Smartphones" dataset, also in this 
directory.

## Files
The file uci_har_mean_std_average.txt contains a tidy data set generated from the original raw data using the script run_analysis.R. The contents of uci_har_mean_std_average.txt are described in the code book later in this README.

## Generating the tidy data set
- Download and unzip the original raw data set.
- In the R Console, set the working directory to the data set's "UCI HAR Dataset" directory (this is where the original README.txt is found).
- Copy the run_analysis.R script to the working directory.
- Execute the run_analysis.R script:  source("run_analysis.R")
- Wait. 
- The tidy data set is contained in the file uci_har_mean_std_average.txt .

## run_analysis.R
The run_analysis.R script generates a tidy data set with the average of each original feature variable for each activity and each subject. It does this using the following steps:
- load raw data files into data frames
- rename the feature columns in test and training sets using the names in the features list
- rename columns for labels and subjects
- combine data frames for test and training sets by appending columns
- combine test and training sets into one data frame by appending rows
- from this large data frame, extract only the columns for means and standard deviations, discarding the rest
- from the same data frame, also extract the activity and subject columns into their own data frame
- assign names to the activity indexes using the activity_labels list
- drop the activity_index column; we don't need it any more
- put together the combined data set by appending the subject+activity columns to the means+stds columns
- aggregate this combined data set by activity and subject, computing the average of each variable.
- write the aggregated data set to the file uci_har_mean_std_average.txt .
 
## Code Book
Each row in uci_har_mean_std_average.txt contains the following variables:
- A text activity label. 
- An integer identifier of the subject who carried out the experiment.
- For all observations in the original data set with the activity label and subject identifier, the average of each of the following. These variables are described in features_info.txt in the original data set:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* Time and frequency domain variables. 
