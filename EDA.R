library(tidyverse)
library(jsonlite)
library(scales)
library(lubridate)
library(repr)
library(ggrepel)
library(gridExtra)
library(countrycode)

train <- read_csv("train.csv")

# This is a Kernel from the following discussion
# It is one way to separate out the individual variables from the columns
# that have combined them.
# https://www.kaggle.com/erikbruin/google-analytics-eda-with-screenshots-of-the-app/notebook

# Keep in mind that the dependent variable "transactionRevenue" only happens for a small
# subset of the visits. So its only in a few instances of the "totals" column/variable.
# Also, it doesn't appear that the transactionRevenune variable is in the test set. 
# Which is what I expected. 

#JSON columns are "device", "geoNetwork", "totals", "trafficSource"

tr_device <- paste("[", paste(train$device, collapse = ","), "]") %>% fromJSON(flatten = T)
tr_geoNetwork <- paste("[", paste(train$geoNetwork, collapse = ","), "]") %>% fromJSON(flatten = T)
tr_totals <- paste("[", paste(train$totals, collapse = ","), "]") %>% fromJSON(flatten = T)
tr_trafficSource <- paste("[", paste(train$trafficSource, collapse = ","), "]") %>% fromJSON(flatten = T)

te_device <- paste("[", paste(test$device, collapse = ","), "]") %>% fromJSON(flatten = T)
te_geoNetwork <- paste("[", paste(test$geoNetwork, collapse = ","), "]") %>% fromJSON(flatten = T)
te_totals <- paste("[", paste(test$totals, collapse = ","), "]") %>% fromJSON(flatten = T)
te_trafficSource <- paste("[", paste(test$trafficSource, collapse = ","), "]") %>% fromJSON(flatten = T)

#Combine to make the full training and test sets
train <- train %>%
  cbind(tr_device, tr_geoNetwork, tr_totals, tr_trafficSource) %>%
  select(-device, -geoNetwork, -totals, -trafficSource)

test <- test %>%
  cbind(te_device, te_geoNetwork, te_totals, te_trafficSource) %>%
  select(-device, -geoNetwork, -totals, -trafficSource)

#Remove temporary tr_ and te_ sets
rm(tr_device)
rm(tr_geoNetwork)
rm(tr_totals)
rm(tr_trafficSource)
rm(te_device)
rm(te_geoNetwork)
rm(te_totals)
rm(te_trafficSource)
