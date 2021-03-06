library(tibble)
library(dplyr)
crime_data <- read.csv("BPD_Part_1_Victim_Based_Crime_Data.csv", na.strings=c("", " ", "NA"))
crime_data <- tbl_df(crime_data)
numeric_crime_data <- select_if(crime_data, is.numeric)
numeric_crime_data %>% summarise_all(mean, na.rm=TRUE)
crime_data %>% select(CrimeCode, Post, Total.Incidents) %>% group_by(CrimeCode) %>% summarise_all(mean, na.rm=TRUE)
crime_data <- mutate(crime_data, District = toupper(District))
crime_data %>% select(CrimeCode, District, Total.Incidents) %>% group_by(CrimeCode, District) %>% summarise(sum(Total.Incidents))
crime_data %>% arrange(CrimeCode, Weapon)

