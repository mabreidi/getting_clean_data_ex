# getting_clean_data_ex
Coursera Assignment

tidy_data.txt contains the merged data set with only the columns containing the mean and standard deviation measurements as well as subject and activity
mean_tidy_data.txt contains the summary with the mean of each measurement per subject and activity

run_analysis.R contains the code needed to transform the data set given in the assignment into the two sets above
The steps are:

Loading the data sets, subject ids, activity ids, names of the measured features as well as the activity labels.

After that the data sets for train and test get combined using the rbind function, creating the dataframe called df.
THe subject ids and activity ids are also combined using the same order (first train, then test).

A column for the subject id is added to dataframe df.
A column for the activity is also added and filled with the descriptive activities matching the index in the combined label vector.

The columns to keep in the subset are found using the grep() function.
The columns to keep contain activity and subject information, as well as the mean and standard deviation measurement.

Lastly, the subset gets grouped by activity and subject and summarized.

The last lines save the subset as well as the summarized subset to .txt files.
