library(foreign)

# https://cran.r-project.org/web/packages/foreign/foreign.pdf

url <- ("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")

# downloading from https site 

download.file(url, destfile= "./for_2.for", method="curl")

doc_for <- read.fwf(file="./for_2.for", skip=4, widths=c(12, 7,4, 9,4, 9,4, 9,4))

head(doc_for)

doc_dt <- data.table(doc_for)

doc_dt[, sum(V4)]

# [1] 32426.7
