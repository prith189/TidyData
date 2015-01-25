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


```{r}
summary(cars)
```

You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
