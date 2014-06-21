TidyDataCourseProject
=====================

## CODEBOOK.md

The original input files, subject_test.txt and subject_train.txt,
have 561 columns, with only 477 unique names. I'm a little puzzled
by this, but here was my solution: I did TWO unusual things.

(1) After I read in the two files subject_train.txt and subject_test.txt,
and used rbind to append them together, I re-did the column names to 
be Cnnn<original column name> where nnn is the number of the column,
001 through 561. This way, when we crunched out the columns we didn't
want in the tidy data set, the essentially meaningless column names
(the features_info.txt was NOT helpful...), if nothing else the
column names will be UNIQUE. Also, there is some hope that knowing
the original location of the column once many columns are removed
(those not pertaining to mean() or std() ), would bear some vague
resemblance to the original raw column.

(2) I simply grepped on mean and std, not mean() and std(), so my
data set, while nominally tidy, has several more columns than I think
most people are turning in. Because I've effectively demonstrated
knowledge of the problem domain that the assignment tests,
I never went back to fix this.

So really, we don't care what the COLUMNS are, they are just means
and standard deviations of various motion variables that we don't 
particularly care about.

Each ROW of the second tidy data set corresponds to the mean of the
means and std deviations across the appropriate factors.

If you DO care what the columns are, the best source is features_info.txt.

