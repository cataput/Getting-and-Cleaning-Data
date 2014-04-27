The script in the file "run_analysis.R" allow to compute the operations described below.
The file can be divided into 2 parts.

Part 1

- read the train and the test data, present into the working directory, into R
- acquire the name of the variables from an external file and set the names of the train and validation matrix in R
- unify the train and test matrix into one 
- filter the variables with "mean" or "std"
- export the data into a csv file


Part 2
- insert all the activity label in a variable
- read the "subjects" from external files and modify them in order to let them be more descriptive
- calculate the mean for each column
- export the dataset in a csv file