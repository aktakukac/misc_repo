setwd("C:/Users/M33313/Desktop/Coursera/03_Getting_and_cleaning_data")

library(RCurl)

# ----------------- Q1 ----------------------

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileUrl, destfile= "./acs_0730.csv", method="curl")

acs<- read.csv("./acs_0730.csv")

names(acs)

SplitNames <- strsplit(names(acs), "wgtp") 

SplitNames[[123]]

## [1] ""   "15"


# ----------------- Q2 ----------------------


library(dplyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

download.file(fileUrl, destfile= "./GDP.csv", method="curl")

GDP<- read.csv("./GDP.csv", sep=",", skip=4)

GDP <- rename(GDP, CountryCode=X, CountryName=X.3, GDP=X.4)

GDP <- select(GDP, c(1, 4, 5))

GDP <- slice(GDP, 1:190)

GDP$GDP <- gsub(",", "", GDP$GDP)

GDP %>% summarize(avg=mean(as.numeric(GDP)))

##        avg   1 377652.4


# ----------------- Q3 ----------------------

GDP[grepl("^United", GDP$CountryName),]
GDP[grep("^United", GDP$CountryName),]

# CountryCode          CountryName        GDP
# 1          USA        United States  16244600 
# 6          GBR       United Kingdom   2471784 
# 32         ARE United Arab Emirates    348595 

# ----------------- Q4 ----------------------

library(dplyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

download.file(fileUrl, destfile= "./GDP.csv", method="curl")

GDP<- read.csv("./GDP.csv", sep=",", skip=4)

GDP <- rename(GDP, CountryCode=X, CountryName=X.3, GDP=X.4)

GDP <- select(GDP, c(1, 4, 5))

GDP <- slice(GDP, 1:190)

GDP$GDP <- gsub(",", "", GDP$GDP)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(fileUrl, destfile= "./EDU.csv", method="curl")

EDU<- read.csv("./EDU.csv")

EDU <- distinct(EDU)

EDU_GDP <- inner_join(GDP, EDU, by="CountryCode")

Notes <- EDU_GDP$Special.Notes[grepl("[Ff]iscal year end", EDU_GDP$Special.Notes)]

Notes <- Notes[grepl("June", Notes)]

Notes <- as.data.frame(Notes)

dim(Notes)

# [1] 13  1

# ----------------- Q5 ----------------------

install.packages("quantmod")
install.packages("lubridate")

library(quantmod)
library(lubridate)

amzn = getSymbols("AMZN",auto.assign=FALSE)

sampleTimes = index(amzn) 

sTimes <- as.Date(sampleTimes, "%Y%m%d")

sTimes <- sTimes[year(sTimes)==2012]

sTimes <- as.data.frame(sTimes)

dim (sTimes)

#[1] 250   1

sTimes <- as.Date(sampleTimes, "%Y%m%d")

sTimes <- sTimes[year(sTimes)==2012 & wday(sTimes)==2]

sTimes <- as.data.frame(sTimes)

dim (sTimes)

# [1] 47  1





