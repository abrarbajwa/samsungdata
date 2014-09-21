### Step 1: Combining the two data sets
# loading the required packages
require(dplyr)
require(tidyr)

# loeading the test datasets  
x_test <- read.table("./test/X_test.txt", colClasses = "numeric")
subject_test <- read.table("./test/subject_test.txt", colClasses = "numeric")
y_test <- read.table("./test/y_test.txt", colClasses = "numeric", 
                     col.names = "Activity_code")

# consolidating measurements, subjects and activities
x_consol1 <- cbind(subject_test, y_test, x_test)

# merging activity labels and activity codes in the end to protect order of dataset
activity_labels <- read.table("./activity_labels.txt", colClasses = "character",
                              col.names = c("Activity_code", "Activity"))
x_consol_merge1 <- (merge(activity_labels, x_consol1)) [,-1]

# Rearranging columns to put Subject in the first column
x_consol_merge1 <- x_consol_merge1[,c(2,1,3:563)]

## Doing the same steps for training data sets
x_train <- read.table("./train/X_train.txt", colClasses = "numeric")
subject_train <- read.table("./train/subject_train.txt", colClasses = "numeric")
y_train <- read.table("./train/y_train.txt", colClasses = "numeric", 
                     col.names = "Activity_code")

# consolidating measurements, subjects and activities
x_consol2 <- cbind(subject_train, y_train, x_train)

# merging activity labels and activity codes in the end to protect order of dataset
activity_labels <- read.table("./activity_labels.txt", colClasses = "character",
                              col.names = c("Activity_code", "Activity"))
x_consol_merge2 <- (merge(activity_labels, x_consol2)) [,-1]

# Rearranging columns to put Subject in the first column
x_consol_merge2 <- x_consol_merge2[,c(2,1,3:563)]

## Binding the test and training data sets
x_consol <- rbind(x_consol_merge1, x_consol_merge2)

## Assigning varialbe names from features dataset
features <- read.table("./features.txt", colClasses = "character")
features <- rbind("Subject", "Activity", features[2])
colnames(x_consol) <- features[,1]

### Step 2: Extracting measurements on mean and standard deviation
mean_col <- grep("mean", names(x_consol), value = T)
std_col <- grep("std", names(x_consol), value = T)
x_consol_var <- subset(x_consol, select = c("Subject", "Activity",
                                            mean_col, std_col))

### Step 3: Using descriptive names to describe activities
# Already done in step 1

### Step 4: Rename column names systematically 
# Bringing them to lower case
names(x_consol_var) <- tolower(names(x_consol_var))
# Removing the brackets
names(x_consol_var) <- sub("()", "", names(x_consol_var), fixed = T) 
# Replace t with time and f with frequency using regular expressions
names(x_consol_var) <- sub("^[t]", "time", names(x_consol_var))
names(x_consol_var) <- sub("^[f]", "frequency", names(x_consol_var))
# Replace duplicate body
names(x_consol_var) <- sub("bodybody", "body", names(x_consol_var), fixed = T)

### Step 5: Create second, tidy dataset with average for each variable-activity-subject pair
# Gathering measurements into variable and measurements column 
gat_consol <- gather(x_consol_var, variable, measurement, -c(subject, activity))
# Grouping data by subject and activity
gat_consol <- group_by(gat_consol, subject, activity, variable)
# Evaluating means for each measurement
summ_consol <- summarize(gat_consol, mean = mean(measurement))
# Taking variables back to columns
tidy_data <- spread(summ_consol, variable, mean)
head(tidy_data)
## Above is the tidy data required in the wide format




