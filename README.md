samsungdata
===========
Contains data extracted from Samsung Human Activity Regcognition dataset and files explaining the transformation
============================================
Extracted and transformed by Abrar ul Haq
============================================
The original data is based on experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years to study human activity recognition. Details of the orginal dataset are available in the data's readme file.
============================================
Number of rows = 180 i.e. 30 subjects X 6 activities
Number of columns = 81
Column names: 
 [1] "subject"                           "activity"                         
 [3] "timebodyacc-mean-x"                "timebodyacc-mean-y"               
 [5] "timebodyacc-mean-z"                "timegravityacc-mean-x"            
 [7] "timegravityacc-mean-y"             "timegravityacc-mean-z"            
 [9] "timebodyaccjerk-mean-x"            "timebodyaccjerk-mean-y"           
[11] "timebodyaccjerk-mean-z"            "timebodygyro-mean-x"              
[13] "timebodygyro-mean-y"               "timebodygyro-mean-z"              
[15] "timebodygyrojerk-mean-x"           "timebodygyrojerk-mean-y"          
[17] "timebodygyrojerk-mean-z"           "timebodyaccmag-mean"              
[19] "timegravityaccmag-mean"            "timebodyaccjerkmag-mean"          
[21] "timebodygyromag-mean"              "timebodygyrojerkmag-mean"         
[23] "frequencybodyacc-mean-x"           "frequencybodyacc-mean-y"          
[25] "frequencybodyacc-mean-z"           "frequencybodyacc-meanfreq-x"      
[27] "frequencybodyacc-meanfreq-y"       "frequencybodyacc-meanfreq-z"      
[29] "frequencybodyaccjerk-mean-x"       "frequencybodyaccjerk-mean-y"      
[31] "frequencybodyaccjerk-mean-z"       "frequencybodyaccjerk-meanfreq-x"  
[33] "frequencybodyaccjerk-meanfreq-y"   "frequencybodyaccjerk-meanfreq-z"  
[35] "frequencybodygyro-mean-x"          "frequencybodygyro-mean-y"         
[37] "frequencybodygyro-mean-z"          "frequencybodygyro-meanfreq-x"     
[39] "frequencybodygyro-meanfreq-y"      "frequencybodygyro-meanfreq-z"     
[41] "frequencybodyaccmag-mean"          "frequencybodyaccmag-meanfreq"     
[43] "frequencybodyaccjerkmag-mean"      "frequencybodyaccjerkmag-meanfreq" 
[45] "frequencybodygyromag-mean"         "frequencybodygyromag-meanfreq"    
[47] "frequencybodygyrojerkmag-mean"     "frequencybodygyrojerkmag-meanfreq"
[49] "timebodyacc-std-x"                 "timebodyacc-std-y"                
[51] "timebodyacc-std-z"                 "timegravityacc-std-x"             
[53] "timegravityacc-std-y"              "timegravityacc-std-z"             
[55] "timebodyaccjerk-std-x"             "timebodyaccjerk-std-y"            
[57] "timebodyaccjerk-std-z"             "timebodygyro-std-x"               
[59] "timebodygyro-std-y"                "timebodygyro-std-z"               
[61] "timebodygyrojerk-std-x"            "timebodygyrojerk-std-y"           
[63] "timebodygyrojerk-std-z"            "timebodyaccmag-std"               
[65] "timegravityaccmag-std"             "timebodyaccjerkmag-std"           
[67] "timebodygyromag-std"               "timebodygyrojerkmag-std"          
[69] "frequencybodyacc-std-x"            "frequencybodyacc-std-y"           
[71] "frequencybodyacc-std-z"            "frequencybodyaccjerk-std-x"       
[73] "frequencybodyaccjerk-std-y"        "frequencybodyaccjerk-std-z"       
[75] "frequencybodygyro-std-x"           "frequencybodygyro-std-y"          
[77] "frequencybodygyro-std-z"           "frequencybodyaccmag-std"          
[79] "frequencybodyaccjerkmag-std"       "frequencybodygyromag-std"         
[81] "frequencybodygyrojerkmag-std" 
============================================
To run the code the original data set should be in the working directory(main)
============================================

My data transformation can be summarized as joining the elements of human activity dataset and then extracting measurements for mean and standard deviation. 

Step 1: This involves combining the training and test data sets. First, I loaded the test dataset (x_test), the corresponding activity codes (y_test) and the corresponding subject codes(subject_test), which were joined columnwise. To protect the order of the dataset the activity labels were replaced by activity codes in the end using merge(). The columns were subsequently rearranged to bring activity and subject in the beginning. 
The above process was repeated for training data set and the two sets were combined using rbind.

Step 2: From the combined dataset above the column with mean/std in their names were extracted using a combination of grep() and subset().

Step 3: Of using descriptive variable names was accomplished in my step 1.

Step 4: The column names were systematically improved using the sub command. The following transformations were done:-
- Column names were brought to lower case.
- The "()" were removed.
- "t" and "f" were replaced by time and frequency
- duplicate strings in columns names were removed.
- 
Step 5: All the measurements in the table were gathered using gather() in two columns namely variable and measurement. Then the data was grouped by "subject", "activity" and "variable" column and mean for each group was calculated using summarise(). The summarized data was spread back again using spread() which resulted in the final tidy dataset.
============================================

