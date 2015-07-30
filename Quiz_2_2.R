library(sqldf)

setwd("~/Repositories/GettingData")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile= "./acs.csv", method="curl")

acs<- read.csv("./acs.csv")

# sqldf("select pwgtp1 from acs where AGEP < 50")

# sqldf("select distinct AGEP from acs")