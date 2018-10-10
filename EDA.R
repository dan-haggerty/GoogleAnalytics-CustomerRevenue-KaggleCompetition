library(tidyverse)
library(jsonlite)
library(scales)
library(lubridate)
library(repr)
library(ggrepel)
library(gridExtra)
library(countrycode)

# load the training data in to the environment
train <- read_csv("train.csv")

# extract out just the first 10 rows. So I have a smaller
# data set to work with while I work on extracting out the nested fields
first10rows <- train[1:10,]

# separate out the nested values from the device, geoNetwork, totals and trafficSource variables
separateTotals <- first10rows %>%
                    separate(totals, into = c("blank", "visitsTitle", "visitsCount", "hitsTitle", "hitsCount", "pageviewTitle",
                            "pageviewCount", "bouncesTitle", "bouncesCount", "newVisitsTitle", 
                            "newVisitsCount"))

#filter the totals row to find one with the word revenue in it.
