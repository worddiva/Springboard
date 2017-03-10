#0. Load data into R and into a data frame 
   
library(dplyr)
library(tidyr)
library(readr)
titanic_original <- read_csv("~/Documents/Springboard/Data Wrangling/titanic3.csv")

#Inspect dataset and convert to local data frame
View(titanic_original)
tbl_df(titanic_original)
 
#1. Port of embarcation: Find the missing values in the "embarked" column and replace them with S 
#Find NAs
sum(is.na(titanic_original$embarked))
#Replace with "S"
titanic_original[is.na(titanic_original$embarked), "embarked"] <- "S"
#Check there are no more NAs
sum(is.na(titanic_original$embarked))== 0
 

#2. Age: Use mean or median of the age values to replace observations that have missing ages
#Find NAs
sum(is.na(titanic_original$age))
#Replace with mean age
titanic_original$age[which(is.na(titanic_original$age))] <- mean(titanic_original$age, na.rm = TRUE)
#Check there are no more NAs
sum(is.na(titanic_original$age))== 0
 
#3. Lifeboat: Find the missing lifeboat values and replace them with a dummy value "None"
#Find NAs
sum(is.na(titanic_original$boat))
#Replace with the string "None"
titanic_original$boat[which(is.na(titanic_original$boat))] <- "None"
#Check there are no more NAs
sum(is.na(titanic_original$boat))== 0
 
#4. Cabin: Create dummy variable to indicate if cabin number is known
titanic_original$has_cabin_number <- as.numeric(!is.na(titanic_original$cabin))

#5. Export cleaned up file as titanic_clean.csv
write.csv(titanic_original, "titanic_clean.csv")
 
