# Matlab-Code-for-Thesis
## Table of Contents
* [General Information](#General-Information)

### General Information
As part of the users thesis, they used Loboda's Online Reading Span Task (2012; https://ubiq-x.gitlab.io/rspan/) to investigate the impact of auditory noise on university student's performance in tasks of higher cognition. In this task, participants are presented with letters that they have to classify as correct or incorrect and between sentence presentation the participants are presented with letters that they are requested to remember at the end of a trial. This task produces a "Results" box which can be copied into an individual text file for each condition for each participant. This results box/text file includes the order in which the number sentence-letter combinations were presented to participants, as well as letters presented, letters recalled, whether a participant was correct or incorrect in their letter recall and whether a participant was correct or incorrect in their sentence classification. Participants also receive a total number of presented combinations, a total sentence comprehension accuracy score and four working memory capacity scores, all calculated in different ways. However, participants were required to complete this experiment in a number of different conditions resulting in many text files that are difficult to examine as a whole. Thus this Matlab project was created to extract and organise information for initial examination before data analysis using IBM SPSS. This project was created using Matlab 24.2.

The code for this project is built on txt files being of the exact same format as within the "Results" box from Loboda (2012); the text box is 24 lines long and contains only the details of one participant in one condition. The code is also designed to interpret only txt files in the same format as the researcher had decided; participants random four-letter alphabeticised code, an underscore and which condition they were in (in this case, 1, 2 or 3). This looks like 'ABCD_condition1'.

This code will produce a number of variables:
1. allcond - this lists the conditions
2. allsubj - this tells you all the subjects included, numbering each one
3. cond - this tells you how many conditions there are in total
4. dat - is a structure containing information on data imported
5.   dat.sub - notes which subject number data came from
6.   dat.cond - notes which condition data was collected in
7.   dat.tlen - notes the trial length
8.   dat.letters - reports the presented letters
9.   dat.recalled - reports what letters were recalled
10.   dat.accM - reports the score of each letter recall (either 0 for incorrect or 1 for correct)
11.   dat.accS - reports the score of each sentence classification (either 0 for incorrect or 1 for correct)
12. dat_in - notes the data collected in the last loop of the code
13. perf - this is another structure pertaining to the relevant scores for data analysis (score in working memory [letters recalled] and score in sentence comprehension accuracy)
14.   perf.n - refers to number of sentence-letter combinations presented to participant
15.   perf.acc - refers to sentence comprehension accuract scores specifically in each participant in each condition
16.   perf.PU/perf.PL/perf.FU/perf.FL - refers to different working memory scoring systems in each participant in each condition
17. subj - notes the number of subjects within the code

Finally, this code will also produce 3 plots
1. Scatterplot matrix of sentence comprehension scores with the different working memory scoring systems
2. Line graph tracking sentence comprehension scores over conditions
3. Line graph tracking working memory PU scores over conditions (as these only were used in researchers analysis

