setwd("~/Repositories/GettingData")

fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile= "./quiz_1.csv", method="curl")

quizData <- read.csv("./quiz_1.csv")

library(data.table)

DT <- data.table(quizData)

DT[, .N, by=VAL]

install.packages("xlsx")

fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile= "./quiz_2.xlsx", method="curl")
quizData2<- read.xlsx("./quiz_2.xlsx", sheetIndex=1, header=TRUE)

colIndex <-7:15
rowIndex <- 18:23

quizData2 <- read.xlsx("./quiz_2.xlsx", sheetIndex=1, colIndex=colIndex, rowIndex=rowIndex, header=TRUE)

sum(quizData2$Zip*quizData2$Ext,na.rm=T) 

install.packages("XML")

library(XML)

fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

quizData3 <- xmlTreeParse(fileUrl, useInternal=TRUE)

fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile= "./quiz_3.csv", method="curl")

DT <- fread("./quiz_3.csv")

system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])