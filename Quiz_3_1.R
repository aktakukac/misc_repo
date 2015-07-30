setwd("~/Repositories/GettingData")

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileUrl, destfile= "./acs_2.csv", method="curl")

acs<- read.csv("./acs_2.csv")

names(acs)

agricultureLogical <- ifelse((acs$ACR==3 & acs$AGS==6), TRUE, FALSE)

head(agricultureLogical)

table(agricultureLogical)

acs_2 <- acs[which(agricultureLogical),]

head(acs_2, n=4)

# 125, 238, 262

# ------ Q2 ---------

library(jpeg)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"

download.file(fileUrl, destfile= "./jeff.png", method="curl", mode = 'wb')

Jeff_jpg <- readJPEG("./jeff.png", native = TRUE)

qJeff_jpeg <- quantile(Jeff_jpg, probs=c(0.3, 0.8)) 

qJeff_jpeg

#    30%       80% 
#  -15259150 -10575416 

# ------ Q3 ---------

library(dplyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

download.file(fileUrl, destfile= "./GDP.csv", method="curl")

GDP<- read.csv("./GDP.csv", sep=",", skip=4)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(fileUrl, destfile= "./EDU.csv", method="curl")

EDU<- read.csv("./EDU.csv")

GDP <- rename(GDP, CountryCode=X)
GDP <- rename(GDP, CountryName=X.3, GDP=X.4)

GDP <- select(GDP, c(1, 4, 5))
GDP <- slice(GDP, 1:190)

GDP$GDP <- as.numeric(gsub(',', '', GDP$GDP))

GDP <- filter(GDP, GDP$GDP>0)

GDP < distinct(GDP)



EDU <- select(EDU, c(1, 2)) 

EDU <- distinct(EDU)

EDU_GDP <- inner_join(GDP, EDU, by="CountryCode")

GDP <- select(GDP, c(1))



#nrow(EDU_GDP)
# [1] 189

EDU_GDP <- arrange(EDU_GDP, desc(GDP))
head(EDU_GDP, n=14)

# 178                           NA            KN        KN            St. Kitts and Nevis            St. Kitts and Nevis

# ------ Q4 ---------

GDP<- read.csv("./GDP.csv", sep=",", skip=4)
GDP <- slice(GDP, 1:190)
GDP <- rename(GDP, CountryCode=X)
GDP <- rename(GDP, CountryName=X.3, GDP=X.4)
GDP$GDP <- as.numeric(gsub(',', '', GDP$GDP))

EDU<- read.csv("./EDU.csv")
EDU <- distinct(EDU)

EDU_GDP <- inner_join(GDP, EDU, by="CountryCode")

nrow(EDU_GDP)
# [1] 189

names(EDU_GDP)

table(EDU_GDP$Income.Group)

EDU_GDP <- EDU_GDP[order(EDU_GDP$GDP, decreasing=FALSE),]

EDU_GDP <- mutate(EDU_GDP, GDP_rank=rank(-EDU_GDP$GDP))

EDU_GDP %>% group_by(Income.Group) %>% summarize(avg=mean(GDP_rank))

#        Income.Group       avg
# 1    High income: OECD  32.96667
# 2 High income: nonOECD  91.65217
# 3           Low income 133.13514
# 4  Lower middle income 107.35185
# 5  Upper middle income  91.88889

# ------ Q5 ---------

EDU_GDP <- mutate(EDU_GDP, GDP_quant=ntile(-EDU_GDP$GDP, 5))

mytable <- xtabs(~EDU_GDP$Income.Group+EDU_GDP$GDP_quant, data=EDU_GDP)

ftable(mytable) 

# EDU_GDP$GDP_quant                       1  2  3  4  5
# EDU_GDP$Income.Group                                 
# 0  0  0  0  0
# High income: OECD                      18 10  1  1  0
# High income: nonOECD                    4  5  8  5  1
# Low income                              0  1  9 16 11
# Lower middle income                     5 13 12  8 16
# Upper middle income                    11  9  8  8  9
