# Tidy Data Course Project
# 2/24/2018
# Chris M.

## Introduction

This project cleans data obtained from UCI's Machine Learning Repositry on human activity recognition using Samsung Galaxy II smartphones. The study information can be found below:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Prerequisites for running this project are to download the repository and extract the following dataset into the directory(in the "UCI HAR Dataset" subdirectory):
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Contents

This project consists of the script run_analysis.R. The purpose of this script is to take the data from the UCI study, merge it into a single dataset, appropriately label all columns, add names for the activity types rather than numerical identifiers and extract all fields that are means or stds. Finally, the script will generate a tidy dataset with averages for all the variables that were kept.