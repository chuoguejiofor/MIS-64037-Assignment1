Assignment 1
================

The dataset can be found here. <https://data.baltimorecity.gov/Public-Safety/BPD-Part-1-Victim-Based-Crime-Data/wsfq-mvij/data>

``` r
library(tibble)
library(dplyr)
library(knitr)
crime_data <- read.csv("BPD_Part_1_Victim_Based_Crime_Data.csv", na.strings=c("", " ", "NA"))
crime_data <- tbl_df(crime_data)
```

Summary of Numeric Data
-----------------------

``` r
numeric_crime_data <- select_if(crime_data, is.numeric)
numeric_crime_data %>% summarise_all(mean, na.rm=TRUE) %>% kable
```

|      Post|  Total.Incidents|
|---------:|----------------:|
|  505.2396|                1|

Grouped by crime code:

``` r
crime_data %>% select(CrimeCode, Post, Total.Incidents) %>% group_by(CrimeCode) %>% summarise_all(mean, na.rm=TRUE) %>% head(10) %>% kable
```

| CrimeCode |      Post|  Total.Incidents|
|:----------|---------:|----------------:|
| 1F        |  571.6535|                1|
| 1K        |  486.2077|                1|
| 1O        |  519.2447|                1|
| 2A        |  512.4661|                1|
| 2B        |  538.0642|                1|
| 3AF       |  494.0802|                1|
| 3AJF      |  548.6851|                1|
| 3AJK      |  505.0000|                1|
| 3AJO      |  507.4032|                1|
| 3AK       |  444.8274|                1|

The values for District are in mixed case

``` r
crime_data %>% select(CrimeCode, District, Total.Incidents) %>% group_by(CrimeCode, District) %>% summarise(sum(Total.Incidents)) %>% head(10) %>% kable
```

| CrimeCode | District     |  sum(Total.Incidents)|
|:----------|:-------------|---------------------:|
| 1F        | CENTRAL      |                    62|
| 1F        | Eastern      |                     2|
| 1F        | EASTERN      |                   162|
| 1F        | Northeastern |                     1|
| 1F        | NORTHEASTERN |                   146|
| 1F        | Northern     |                     2|
| 1F        | NORTHERN     |                    72|
| 1F        | Northwestern |                     1|
| 1F        | NORTHWESTERN |                   157|
| 1F        | Southeastern |                    13|

so they must be made uniform to count the incidents accurately.

``` r
crime_data <- mutate(crime_data, District = toupper(District))
crime_data %>% select(CrimeCode, District, Total.Incidents) %>% group_by(CrimeCode, District) %>% summarise(sum(Total.Incidents)) %>% head(10) %>% kable
```

| CrimeCode | District     |  sum(Total.Incidents)|
|:----------|:-------------|---------------------:|
| 1F        | CENTRAL      |                    62|
| 1F        | EASTERN      |                   164|
| 1F        | NORTHEASTERN |                   147|
| 1F        | NORTHERN     |                    74|
| 1F        | NORTHWESTERN |                   158|
| 1F        | SOUTHEASTERN |                    58|
| 1F        | SOUTHERN     |                    95|
| 1F        | SOUTHWESTERN |                   158|
| 1F        | WESTERN      |                   198|
| 1F        | NA           |                     3|
