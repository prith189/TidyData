---
title: "README"
author: "PN"
date: "Sunday, January 25, 2015"
output: html_document
---

This is an R Markdown document explaining the steps that were performed to get a tidy dataset from an unprocessed raw data set.

This project was completed for the Coursera Course "Getting and Cleaning Data"

All the steps mentioned below have been realized in code as part of the R script "run_analysis.R"

Steps to extract the tidy data

- Download the raw dataset from here:
- After unzipping the data, place the copy the "run_analysis.R" script inside the "UCI HAR Dataset" directory
- Run the R script using R studio
- A tidy data set with the title "Tidy.txt" will be generated

Description of the R script that results in the tidy data

- The R dataset downloaded that two subsets: Training and Test
- Each subset that additional subsets: Collected Data, Activity for which data was collected, Subject on which the data was collected
- Combine the three Training dataframes to result in one Master Training DataFrame. This dataframe is of size 7352 x 563
- Combine the three Test dataframes to result in one Master Test DataFrame. This dataframe is of size 2947 x 563
- Rbind both the Training and Test data sets to result in one Master Dataframe. This dataframe is of size 10299 x 563
- Name the columns of the master Dataframe with the information from "features.txt"
- Extract only the mesurements that are either MEAN or STD. This was achieved by using the select function with the parameter "contains". The resulting dataframe is of size 10299 x 88
- Iterate over this dataframe and run ColMeans such that for every SUbject/Activity pair there is only one row in the tidy dataframe. The resulting data frame is of size 180 x 88
- Rename the entries of the column Activity with the information for the factor variable from "activity_labels.txt"
- This final tidy data set is of the size xx. One row for each Subject/Activity pair, and one column for each of the measurements that are either MEAN or STD. This dataset adheres to the tidy dataset principles
