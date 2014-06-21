TidyDataCourseProject
=====================

## Coursera June 2014 Getting and Cleaning Data Course Project

This submission (github repository) consists of several parts:

   (1) the big tidy data set, submitted on the assignment page

   (2) run_analysis.R, the R script that created the data,
       assuming that the zip file and/or the UCI HAR Dataset folder
       is in the current directory;

   (3) CODEBOOK.md, my lame attempt at a codebook

   (4) the SECOND tidy data set, the one with the means
       For reasons that I don't understand, we don't seem to
       submit the SECOND tidy data set on the assignment page.

My imaginative names for the datasets are 

## tidyDataFrame1.txt

and 

## tidyDataFrame2.txt

Both are tab-delimited.

I will attempt to move some of the comments from the .R script
into this file to make the R script more readable.

The CODEBOOK.md contains some description of how I derived the
columns and rows of the two tidy data sets.

## HOW THE TIDY DATA SETS WERE CONSTRUCTED

1. Glue (cbind) y_test.txt and subject_test.txt onto X_test.txt, and
   y_train.txt and subject_train.txt onto X_train.txt.
   These are actually the subject numbers, which we need.

2. Glue (rbind) the result of 1 onto each other (combine the
   test and train data).

3. Massage the 561 column names as described in my CODEBOOK.md
   and to some extent in the comments in my run_analysis.R,
   and tack them on top of the big matrix.

4. Squash out the columns that aren't means or standard deviations.

This results in tidy data frame #1. Then,

5. split and take the means of what's left, making a new dataset,
   with 180 rows consisting of 30 subjects by six factors.
   So we have 180 sets of means of means and means of std devs from
   the tidy data set #1

This results in tidy data frame #2.
   
Curiously, we had little to do in the way of cleaning up MISSING data....
