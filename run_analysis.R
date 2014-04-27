# Getting and cleaning data course - peer assignment 

## Part 1


# Read data into R
x_train <- read.table("train/X_train.txt", sep="")
y_train <- read.table("train/y_train.txt", sep="")
x_test <- read.table("test/X_test.txt", sep="")
y_test <- read.table("test/y_test.txt", sep="")


# read the names of the variables
Variables <- read.table("features.txt", sep="")
variablesNames <- Variables[,2]
activity_labels <- read.table("activity_labels.txt", sep="")


# update the column names of the datasets
names(x_train) <- variablesNames
names(x_test) <- variablesNames

## Create 2 new dataset with test and training data
x_total <- rbind(x_test,x_train)
y_total <- rbind(y_test,y_train)

# select only variables with "mean" or "std" word
names_mean <- grep("[m]ean|std", variablesNames)

# filter the x matrix
x_total_mean <- x_total[,names_mean]

# export x_total_mean matrix
write.csv(x_total_mean,file="x_total_mean.csv", sep="")



## Part 2


y_total_labels <- vector(mode="character", length=length(y_total))

# insert each activity label in a variable
for(i in 1:6){
  prog <- which(y_total==i)
  y_total_labels[prog] <- as.character(activity_labels[i,2])
}

# read subject
subject_train <- read.table("train/subject_train.txt", sep="")
subject_test <- read.table("test/subject_test.txt", sep="")


# modify the ID adding "Subject"
mod_id <- function(ds){
	return(paste("Subject ", as.character(ds), sep=""))
	}
	
subject_train_mod <- sapply(subject_train, FUN=mod_id)
subject_test_mod <- sapply(subject_test, FUN=mod_id)

# unify train and test subjects
new_subject <- rbind(subject_train_mod, subject_test_mod)


# create a new dataset for the means of each variable
means_dataset <- matrix(ncol=length(names(x_total_mean)), nrow=length(unique(new_subject)))
rownames(means_dataset) <- unique(new_subject); 
colnames(means_dataset) <- names(x_total_mean);

# calculate the mean for each column
for(j in unique(new_subject)){
    k <- which(new_subject == j)
    calculated_mean <- colMeans(x_total_mean[k,])
    means_dataset[j,] <- calculated_mean
}

write.csv(means_dataset,file="means_dataset.csv", sep="")