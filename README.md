Getting_and_Cleaning_Data_Project
=================================
Getting and Cleaning Data Project

Please note: Script written and tested on MS Windows 7.

•	Download and unzip data from following location into folder ’C:\Users\home\Desktop\REx\week3’: ( https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

•	Folders ‘UCI HAR Dataset\train’ and ‘UCI HAR Dataset/test’ will be created by the zip utility under folder  ‘C:\Users\home\Desktop\REx\week3’ 

•	Copy R source file ‘run_analysis.R’ file from this repo to location- ‘C:\Users\home\Desktop\REx\week3’

•	Execute R script with following script:
	  setwd("C:/Users/home/Desktop/REx/week3/")
	  source("run_analysis.R")
	  
•	Merge cleaned data will be written at location ‘C:\Users\home\Desktop\REx\week3\UCI HAR Dataset\ merged_clean_data’.
    		Size of data: 8.35 MB.
    		Data frame: 10299x68.
    		
•	Dataset with averages will be written at location  ‘C:\Users\home\Desktop\REx\week3\UCI HAR Dataset\ tidy_data.txt’.	
		Size of data: 0.225 Mb.
    		Data frame: 180x68
    		
•	The script normally runs for about 30 seconds.
